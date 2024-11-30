<?php

namespace App\Domain\Services;

use App\Domain\Enum\UserToDebtRelationship;
use App\Domain\Jobs\NotifyChangesJob;
use App\Domain\Jobs\NotifyUsersJob;
use App\Domain\Models\Debt;
use App\Domain\Repository\DebtRepository;
use App\Domain\Resources\DebtResource;
use Illuminate\Support\Arr;

class DebtService extends BaseService
{
    protected $repository = DebtRepository::class;

    public function getAllByUser()
    {
        $userId = auth()->user()->id;
        $own = $this->repository->getAllByUser($userId);

        $others = $this->repository->getAllIncludingYou(auth()->user());

        return [
            'own' => DebtResource::collection($own),
            'others' => DebtResource::collection($others)
        ];
    }

    public function create(array $data)
    {
        $data['user_id'] = auth()->user()->id;
        $debt = $this->repository->create($data);
        $data['users'] = array_map(function ($user) use ($debt) {
            $user['debt_id'] = $debt->id;
            if ($user['relationship'] != UserToDebtRelationship::RECEIVER) {
                $user['verify_code'] = bin2hex(random_bytes(4));
            }
            if (!array_key_exists('phone', $user)) {
                $user['phone'] = null;
            }
            if (!array_key_exists('email', $user)) {
                $user['email'] = null;
            }
            $user['created_at'] = $debt->created_at;
            $user['updated_at'] = $debt->updated_at;
            return $user;
        }, $data['users']);
        if (!Arr::first($data['users'], fn ($user) => $user['relationship'] == UserToDebtRelationship::RECEIVER)) {
            $data['users'][] = [
                'relationship' => UserToDebtRelationship::RECEIVER,
                'phone' => auth()->user()->phone,
                'email' => auth()->user()->email,
                'name' => auth()->user()->first_name . ' ' . auth()->user()->last_name,
                'value' => 0,
                'debt_id' => $debt->id,
                'verify_code' => null,
                'created_at' => $debt->created_at,
                'updated_at'=> $debt->updated_at
            ];
        }
        $debt->users()->insert($data['users']);

        if (isset($data['proofs'])) {
            $data['proofs'] = array_map(function ($proof) use ($debt) {
                $proof['debt_id'] = $debt->id;
                $proof['user_id'] = $debt->user_id;
                return $proof;
            }, $data['proofs']);
            $debt->proofs()->insert($data['proofs']);
        }

        NotifyUsersJob::dispatch($debt);

        return $debt;
    }

    public function partialPay(int $id, array $data)
    {
        $debt = $this->repository->find($id);
        $data['users'] = array_map(function ($user) use ($debt) {
            $user['debt_id'] = $debt->id;
            if ($user['value'] == $user['paid_value']) {
                $user['paid_at'] = now()->format('Y-m-d H:i:s');
            }
            $user['updated_at'] = now()->format('Y-m-d H:i:s');
            return $user;
        }, $data['users']);
        $debt->users()->forceFill($data['users'])->save();

        return $debt;
    }

    public function totalPay(Debt $debt, $proofs = null)
    {
        foreach ($debt->users as $user) {
            if ($user->verified_at == null && $user->relationship == UserToDebtRelationship::PAYER) {
                abort(403);
            }
            if ($user->relationship != UserToDebtRelationship::PAYER) continue;
            $user->paid_value = $user->value != 0 ? $user->value : $debt->total_value;
            $user->save();
        }

        if ($proofs)
            $debt->proofs()->insert($proofs);

        return $this->repository->find($debt->id);
    }
}
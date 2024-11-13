<?php

namespace App\Domain\Services;

use App\Domain\Enum\UserToDebtRelationship;
use App\Domain\Repository\DebtRepository;
use App\Jobs\NotifyChangesJob;
use App\Jobs\NotifyUsersJob;

class DebtService extends BaseService
{
    protected $repository = DebtRepository::class;

    public function getAllByUser()
    {
        $userId = auth()->user()->id;
        return $this->repository->getAllByUser($userId);
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
            return $user;
        }, $data['users']);
        $debt->users()->insert($data['users']);

        if (isset($data['proofs'])) {
            $data['proofs'] = array_map(function ($proof) use ($debt) {
                $proof['debt_id'] = $debt->id;
                return $proof;
            }, $data['proofs']);
            $debt->proofs()->insert($data['proofs']);
        }

        NotifyUsersJob::dispatch($debt);

        return $debt;
    }

    public function update(int $id, array $data)
    {
        $debt = $this->repository->create($data);
        $debt = $this->repository->update($debt);
        $data['users'] = array_map(function ($user) use ($debt) {
            $user['debt_id'] = $debt->id;
            return $user;
        }, $data['users']);
        $debt->users()->forceFill($data['users'])->save();

        if (isset($data['proofs'])) {
            $data['proofs'] = array_map(function ($proof) use ($debt) {
                $proof['debt_id'] = $debt->id;
                return $proof;
            }, $data['proofs']);
            $debt->proofs()->forceFill($data['proofs'])->save();
        }
        return $debt;
    }

    public function updateValues(int $id, array $data)
    {
        $changes = $this->repository->update($id, $data);
        NotifyChangesJob::dispatch($changes);
        return $changes;
    }
}
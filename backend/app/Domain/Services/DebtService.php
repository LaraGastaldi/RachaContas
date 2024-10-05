<?php

namespace App\Domain\Services;

use App\Domain\Repository\DebtRepository;

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

        return $debt;
    }
}
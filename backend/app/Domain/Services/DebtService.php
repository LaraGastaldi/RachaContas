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
        
    }
}
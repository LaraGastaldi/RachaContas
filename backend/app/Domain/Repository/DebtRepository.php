<?php

namespace App\Domain\Repository;

use App\Domain\Models\Debt;

class DebtRepository extends BaseRepository
{
    protected $model = Debt::class;

    public function getAllByUser($userId)
    {
        return $this->model::join('user_to_debt', 'debts.id', '=', 'user_to_debt.debt_id')
            ->where('user_to_debt.user_id', $userId)
            ->get();
    }
}
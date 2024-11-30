<?php

namespace App\Domain\Repository;

use App\Domain\Enum\UserToDebtRelationship;
use App\Domain\Models\Debt;
use App\Domain\Models\UserToDebt;

class DebtRepository extends BaseRepository
{
    protected $model = Debt::class;

    public function getAllByUser($userId)
    {
        return $this->model::where('user_id', $userId)
            ->orderBy('created_at', 'desc')
            ->get();
    }

    public function getAllIncludingYou($user)
    {
        return $this->model::where('user_id', '!=', $user->id)
        ->whereHas('users', function ($query) use ($user) {
            $query->where('email', $user->email);
        })->get();
    }
}
<?php

namespace App\Domain\Controllers;

use App\Domain\Models\UserToDebt;
use App\Domain\Resources\DebtResource;
use App\Domain\Resources\UserToDebtResource;

class UserDebtController
{
    public function getUserInfo($code)
    {
        $userDebt = UserToDebt::where('verify_code', '=', $code)->firstOrFail();
        
        $debt = $userDebt->debt;

        $userDebt = new UserToDebtResource($userDebt);
        $debt = new DebtResource($debt);

        return response()->json([
            'user' => $userDebt,
            'debt' => $debt
        ], 200);
    }
}
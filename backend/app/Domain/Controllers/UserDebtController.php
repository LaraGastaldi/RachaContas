<?php

namespace App\Domain\Controllers;

use App\Domain\Models\UserToDebt;
use App\Domain\Resources\DebtResource;
use App\Domain\Resources\UserToDebtResource;
use App\Domain\Services\UserToDebtService;

class UserDebtController extends BaseController
{
    protected $resource = UserToDebtResource::class;
    /**
     * @var \App\Domain\Services\UserToDebtService
     */
    protected $service = UserToDebtService::class;
    
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

    public function verify($code)
    {
        UserToDebt::where('verify_code', '=', $code)->firstOrFail();

        UserToDebt::where('verify_code', '=', $code)->update([
            'verfied_at' => now()->format('Y-m-d H:i:s')
        ]);
        
        return response()->json(['message' => 'OK'], 200);
    }
}
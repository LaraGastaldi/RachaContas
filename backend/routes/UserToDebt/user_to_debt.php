<?php

use App\Domain\Controllers\DebtController;
use App\Domain\Controllers\UserDebtController;
use App\Domain\Models\UserToDebt;
use Illuminate\Support\Facades\Route;

Route::middleware(
    'auth'
    )->group(function () {
    Route::delete('/user-to-debt/{id}', [UserDebtController::class,'delete'])
        ->name('user-to-debt.delete')
        ->can('user_debt_owner', 'id');
    Route::patch('/user-to-debt/{id}', [UserDebtController::class, 'update'])
        ->name('user-to-debt.udpate')
        ->can('user_debt_owner', 'id');
});
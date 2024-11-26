<?php
use App\Domain\Controllers\DebtController;
use App\Domain\Models\Debt;
use Illuminate\Support\Facades\Route;

Route::middleware(
    'auth'
)->group(function () {
    Route::get('/debt', [DebtController::class, 'getAllByUser']); 
    Route::post('/debt', [DebtController::class, 'create']);
    Route::patch('/debt/{id}', [DebtController::class, 'update'])
        ->can('debt_owner', Debt::class);
    Route::delete('/debt/{id}', [DebtController::class, 'delete'])
        ->can('debt_owner', Debt::class);
    Route::post('/debt/{id}/total-pay', [DebtController::class, 'totalPay'])
        ->can('debt_owner', Debt::class);
});
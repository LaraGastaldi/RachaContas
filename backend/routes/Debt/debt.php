<?php
use App\Domain\Controllers\DebtController;
use Illuminate\Support\Facades\Route;

Route::middleware(
    'auth'
)->group(function () {
    Route::get('/debt', [DebtController::class, 'getAllByUser']); 
    Route::post('/debt', [DebtController::class, 'create']);
    Route::patch('/debt/{id}', [DebtController::class, 'update']);
    Route::delete('/debt/{id}', [DebtController::class, 'delete']);
    ROute::patch('/debt/{id}/update-users', [DebtController::class, 'updateUsers']);
    Route::post('/debt/{id}/total-pay', [DebtController::class, 'totalPay']);
});
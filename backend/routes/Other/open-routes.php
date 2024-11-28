<?php

use \Illuminate\Support\Facades\Route;
use \App\Domain\Controllers\UserDebtController;

Route::get('/verify/{code}', [UserDebtController::class, 'verifyView'])
    ->name('user-to-debt.verify');
Route::post('/verify/{id}', [UserDebtController::class, 'verify'])
    ->name('user-to-debt.verify');
Route::get('/verified', [UserDebtController::class, 'verified'])
    ->name('user-to-debt.verified');
<?php

use App\Domain\Controllers\UserDebtController;
use Illuminate\Support\Facades\Route;

Route::get('/get-user-info/{id}', [UserDebtController::class, 'getUserInfo'])->name('user-to-debt.info');
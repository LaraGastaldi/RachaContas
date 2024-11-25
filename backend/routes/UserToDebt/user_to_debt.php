<?php

use App\Domain\Controllers\UserDebtController;
use Illuminate\Support\Facades\Route;

Route::get('/get-user-info/{id}', [UserDebtController::class, 'getUserInfo'])->name('user-to-debt.info');
Route::delete('/user-to-debt/{id}', [UserDebtController::class,'delete'])->name('user-to-debt.delete');
Route::patch('/user-to-debt/{id}', [UserDebtController::class, 'update'])->name('user-to-debt.udpate');
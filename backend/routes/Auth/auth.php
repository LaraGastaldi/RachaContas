<?php

use App\Domain\Controllers\AuthController;
use Illuminate\Support\Facades\Route;

Route::post('/register', [AuthController::class, 'register'])->name('register')->middleware(\App\Domain\Middlewares\ThrottleIfProduction::class);

Route::post('login', [AuthController::class, 'login'])->name('login');
Route::post('logout', [AuthController::class, 'logout'])->name('logout');
Route::post('refresh', [AuthController::class, 'refresh'])->name('refresh');
// Route::post('me', [AuthController::class, 'me'])->name('me');

Route::get('me', [AuthController::class, 'me'])->name('me')->middleware('auth');
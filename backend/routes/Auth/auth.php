<?php

use App\Domain\Controllers\AuthController;
use Illuminate\Support\Facades\Route;

Route::post('/login', [AuthController::class, 'login'])->middleware('auth')->name('login');

Route::post('/register', [AuthController::class, 'register'])->name('register');
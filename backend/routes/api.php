<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware(\App\Domain\Middlewares\SemiAuthMiddleware::class)->group(function () {
    include_once(base_path() . '/routes/Auth/auth.php');
    include_once(base_path() . '/routes/Debt/debt.php');
});
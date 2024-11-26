<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware(\App\Domain\Middlewares\SemiAuthMiddleware::class)->group(function () {
    include_once(base_path() . '/routes/Auth/auth.php');
    include_once(base_path() . '/routes/Debt/debt.php');
    include_once(base_path() . '/routes/UserToDebt/user_to_debt.php');
});

include_once(base_path() . '/routes/Other/open-routes.php');
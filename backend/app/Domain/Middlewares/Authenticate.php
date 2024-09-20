<?php

namespace App\Domain\Middlewares;

use Closure;
use Illuminate\Support\Facades\Auth;

class Authenticate
{
    public function handle($request, Closure $next)
    {
        if (!auth()->user()) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        return $next($request);
    }
}
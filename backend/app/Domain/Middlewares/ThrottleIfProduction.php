<?php

namespace App\Domain\Middlewares;

use Illuminate\Http\Request;
use Illuminate\Routing\Middleware\ThrottleRequests;

class ThrottleIfProduction
{
    public function handle(Request $request, $next)
    {
        if (env('APP_ENV') === 'production') {
            resolve(ThrottleRequests::class)->handle($request, $next, 1, 2);
        }

        return $next($request);
    }
}
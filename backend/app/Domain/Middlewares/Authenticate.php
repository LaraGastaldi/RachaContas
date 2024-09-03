<?php

namespace App\Domain\Middlewares;

use Closure;

class Authenticate
{
    public function handle($request, Closure $next)
    {
        if (!auth()->validate(['Authorization' => $request->bearerToken()])) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        return $next($request);
    }
}
<?php

namespace App\Domain\Middlewares;
use Illuminate\Http\Request;

class SemiAuthMiddleware 
{
    public function handle(Request $request, $next)
    {
        if ($request->headers->get('Authorization2') != env('API_SECRET')) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return $next($request);
    }
}
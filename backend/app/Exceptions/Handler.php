<?php

namespace App\Exceptions;

use Exception;
use Symfony\Component\ErrorHandler\Exception\FlattenException;

class Handler extends \Illuminate\Foundation\Exceptions\Handler
{
    public function render($request, \Throwable $e)
    {
        dd($e);
        if ($e instanceof Exception) {
            $e = FlattenException::create($e);
        }

        dd($e);
        return response()->json([
            'message' => $e->getMessage(),
            'trace' => env('APP_ENV') != 'production' ? $e->getTrace() : null,
            'status' => $e->getStatusCode()
        ], $e->getStatusCode());
    }
}
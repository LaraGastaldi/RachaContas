<?php

namespace App\Exceptions;

use Exception;
use Symfony\Component\ErrorHandler\Exception\FlattenException;

class Handler extends \Illuminate\Foundation\Exceptions\Handler
{
    public function render($request, \Throwable $e)
    {
        if ($e instanceof Exception) {
            $e = FlattenException::create($e);
        }

        return response()->json([
            'message' => $e->getMessage(),
            'status' => $e->getStatusCode()
        ], $e->getStatusCode());
    }
}
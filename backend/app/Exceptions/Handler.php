<?php

namespace App\Exceptions;

use Exception;
use Illuminate\Database\UniqueConstraintViolationException;
use Illuminate\Validation\ValidationException;
use Symfony\Component\ErrorHandler\Exception\FlattenException;
use Symfony\Component\Routing\Exception\MethodNotAllowedException;

class Handler extends \Illuminate\Foundation\Exceptions\Handler
{
    public function render($request, \Throwable $e)
    {
        if ($e instanceof ValidationException) {
            return response()->json($e->validator->errors(), 422);
        }

        if ($e instanceof \Illuminate\Http\Exceptions\ThrottleRequestsException) {
            return response()->json([
                'message' => 'Too many requests, please slow down.',
                'status' => 429
            ], 429);
        }

        if ($e instanceof UniqueConstraintViolationException) {
            return response()->json([
                'email' => ['The email has already been taken.']
            ], 422);
        }

        if ($e instanceof MethodNotAllowedException) {
            return response()->json([
                'message' => 'Method not allowed.',
                'status' => 405
            ], 405);
        }

        if ($e instanceof Exception) {
            $exception = FlattenException::create($e);
        } else {
            $exception = FlattenException::create(new Exception($e->getMessage(), $e->getCode()));
        }

        if (env('APP_ENV') == 'production') {
            return response()->json([
                'message' => $exception->getMessage(),
                'status' => $exception->getStatusCode()
            ], $exception->getStatusCode());
        }

        return parent::render($request, $e);
    }
}
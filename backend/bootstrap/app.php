<?php

use App\Domain\Middlewares\Authenticate as MiddlewaresAuthenticate;
use App\Exceptions\Handler as ExceptionsHandler;
use Illuminate\Auth\Middleware\Authenticate;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Foundation\Exceptions\Handler;
use Illuminate\Http\Middleware\HandleCors;

setlocale(LC_MONETARY, 'pt_BR');

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        api: __DIR__.'/../routes/api.php',
        apiPrefix: '',
    )
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->append(HandleCors::class);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })
    ->withSingletons([
        Handler::class => ExceptionsHandler::class,
        Authenticate::class => MiddlewaresAuthenticate::class
    ])
    ->withProviders([
        Tymon\JWTAuth\Providers\LaravelServiceProvider::class,
    ])
    ->create();

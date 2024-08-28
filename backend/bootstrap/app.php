<?php

use App\Exceptions\Handler as ExceptionsHandler;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Exceptions\Handler;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        api: __DIR__.'/../routes/api.php',
        apiPrefix: '',
    )
    ->withSingletons([
        Handler::class => ExceptionsHandler::class,
    ])->create();

<?php

namespace App\Providers;

use App\Domain\Exceptions\Handler;
use Illuminate\Contracts\Debug\ExceptionHandler;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        JsonResource::withoutWrapping();

        // Auth::extend('jwt', function ($app, $name, array $config) {
        //     return new \App\Domain\Auth\AuthGuard(
        //         Auth::createUserProvider($config['provider']),
        //         $app->make('request')
        //     );
        // });
    }
}

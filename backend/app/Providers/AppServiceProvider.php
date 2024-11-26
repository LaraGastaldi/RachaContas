<?php

namespace App\Providers;

use App\Domain\Exceptions\Handler;
use App\Domain\Models\Debt;
use App\Domain\Models\UserToDebt;
use Gate;
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

        Gate::define("debt_owner", function ($user, Debt $debt) {
            return $user->id === $debt->user_id;
        });

        Gate::define("user_debt_owner", function ($user, UserToDebt $userToDebt) {
            return $user->id === $userToDebt->debt->user_id;
        });
    }
}

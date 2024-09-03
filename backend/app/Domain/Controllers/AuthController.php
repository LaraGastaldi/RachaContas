<?php

namespace App\Domain\Controllers;
use App\Domain\Models\User;
use App\Domain\Resources\UserResource;
use App\Domain\Services\AuthService;
use Illuminate\Http\Request;

class AuthController extends BaseController
{
    protected $resource = UserResource::class;
    /**
     * @var AuthService
     */
    protected $service = AuthService::class;

    // TODO: Implement the login method
    public function login(Request $request)
    {
        return $this->service->login($request->all());
    }

    protected function register(Request $request)
    {
        return $this->service->register($request->all());
    }

    public function refreshToken(Request $request)
    {
        return $this->service->refreshToken($request->all());
    }
}
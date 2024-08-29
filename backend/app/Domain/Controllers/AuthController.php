<?php

namespace App\Domain\Controllers;
use App\Domain\Models\User;
use App\Domain\Resources\UserResource;

class AuthController extends BaseController
{
    protected $resource = UserResource::class;

    // TODO: Implement the login method
    protected function login()
    {
        return new User([
            'name' => 'John Doe',
            'email' => 'skodf@fdjod.com',
            'password' => 'password',
        ]);
    }
}
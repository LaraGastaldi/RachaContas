<?php

namespace App\Domain\Services;

use App\Domain\Models\User;
use App\Domain\Repository\AuthRepository;

class AuthService extends BaseService
{
    protected $repository = AuthRepository::class;
    public function login($data) {
        return new User([
            'name' => 'John Doe',
            'email' => 'john@mail.com',
            'password' => 'password',
        ]);
    }

    public function register($data) {
        return new User([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => $data['password'],
        ]);
    }

    public function refreshToken($data) {

    }
}
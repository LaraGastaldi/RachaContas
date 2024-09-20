<?php

namespace App\Domain\Services;

use App\Domain\Models\User;
use App\Domain\Repository\AuthRepository;

class AuthService extends BaseService
{
    /**
     * @var AuthRepository
     */
    protected $repository = AuthRepository::class;
    public function login($data) {
        return new User([
            'name' => 'John Doe',
            'email' => 'john@mail.com',
            'password' => 'password',
        ]);
    }

    public function create($data) {
        return (new UserService())->create($data);
    }
}
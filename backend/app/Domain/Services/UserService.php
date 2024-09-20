<?php

namespace App\Domain\Services;

use App\Domain\Models\User;
use App\Domain\Repository\UserRepository;

class UserService extends BaseService
{
    /**
     * @var UserRepository
     */
    protected $repository = UserRepository::class;
}
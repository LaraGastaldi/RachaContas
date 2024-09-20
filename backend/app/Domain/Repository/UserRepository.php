<?php

namespace App\Domain\Repository;

use App\Domain\Models\User;

class UserRepository extends BaseRepository
{
    protected $model = User::class;
}
<?php

namespace App\Domain\Repository;

use App\Domain\Models\User;

class AuthRepository extends BaseRepository
{
    protected $model = User::class;

}
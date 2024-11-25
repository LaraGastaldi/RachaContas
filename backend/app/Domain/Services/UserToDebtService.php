<?php

namespace App\Domain\Services;

use App\Domain\Repository\UserToDebtRepository;

class UserToDebtService extends BaseService
{
    protected $repository = UserToDebtRepository::class;
}
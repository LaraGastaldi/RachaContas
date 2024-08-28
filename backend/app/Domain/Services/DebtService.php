<?php

namespace App\Domain\Services;

use App\Domain\Repository\DebtRepository;

class DebtService extends BaseService
{
    protected $repository = DebtRepository::class;
}
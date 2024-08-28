<?php

namespace App\Domain\Repository;

use App\Domain\Models\Debt;

class DebtRepository extends BaseRepository
{
    protected $model = Debt::class;
}
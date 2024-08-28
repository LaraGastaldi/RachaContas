<?php

namespace App\Domain\Controllers;
use App\Domain\Resources\DebtResource;
use App\Domain\Services\DebtService;

class DebtController extends BaseController
{
    protected $resource = DebtResource::class;
    /**
     * @var DebtService
     */
    protected $service = DebtService::class;
}
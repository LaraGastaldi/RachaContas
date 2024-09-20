<?php

namespace App\Domain\Controllers;
use App\Domain\Enum\UserToDebtRelationship;
use App\Domain\Resources\DebtResource;
use App\Domain\Rules\PhoneRule;
use App\Domain\Services\DebtService;
use App\Rules\RequiredIn;
use Illuminate\Validation\Rules\RequiredIf;

class DebtController extends BaseController
{
    protected $resource = DebtResource::class;
    /**
     * @var DebtService
     */
    protected $service = DebtService::class;

    protected function getAllByUser()
    {
        return $this->service->getAllByUser();
    }

    protected function create(array $data)
    {
        request()->validate([
            'name' => 'required',
            'description' => 'nullable',
            'total_value' => 'required',
            'debt_date' => 'required|date',
            'max_pay_date' => 'nullable|date',
            'users' => 'required|array',
            'users.*.relationship' => ['required', new RequiredIn(UserToDebtRelationship::getRelationships())],
            'users.*.phone' => ['required_if:users.*.email,null', new PhoneRule],
            'users.*.email' => 'required_if:users.*.phone,null',
            'users.*.name' => 'required',
            'user.*.value' => 'nullable',
            'proofs' => 'nullable|array',
            'proofs.*.src' => 'required',
            'proofs.*.type' => 'required',
        ]);

        return $this->service->create($data);
    }
}
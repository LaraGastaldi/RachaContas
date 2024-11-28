<?php

namespace App\Domain\Controllers;
use App\Domain\Enum\UserToDebtRelationship;
use App\Domain\Resources\DebtResource;
use App\Domain\Rules\PhoneRule;
use App\Domain\Rules\RequiredIfArrayBigger;
use App\Domain\Services\DebtService;
use App\Domain\Rules\RequiredIn;
use Illuminate\Http\Request;

class DebtController extends BaseController
{
    protected $resource = DebtResource::class;
    /**
     * @var DebtService
     */
    protected $service = DebtService::class;

    public function getAllByUser()
    {
        return $this->service->getAllByUser();
    }

    protected function create(Request $request)
    {
        $validated = $request->validate([
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
            'users.*.value' => new RequiredIfArrayBigger($request->input('users'), 1),
            'proofs' => 'nullable|array',
            'proofs.*.src' => 'required',
            'proofs.*.type' => 'required',
        ]);

        return $this->service->create($validated);
    }

    protected function update($id, Request $request)
    {
        $validated = $request->validate([
            'name' => 'sometimes',
            'description' => 'sometimes',
            'debt_date' => 'sometimes|date',
            'max_pay_date' => 'nullable|date',
        ]);

        return $this->service->update($id, $validated);
    }

    public function partialPay($id, Request $request)
    {
        $validated = $request->validate([
            'user.id' => 'required',
            'user.value' => 'required',
            'user.paid_value' => 'required'
        ]);

        return $this->service->partialPay($id, $validated);
    }
    protected function totalPay($id, Request $request)
    {
        $request->validate([
            'proofs' => 'sometimes|array',
            'proofs.*.src' => 'required',
            'proofs.*.type' => 'required'
        ]);

        $debt = $this->service->find($id);

        if ($debt->user_id != auth()->user()->id) {
            abort(403);
        }

        return $this->service->totalPay($debt, $request->input('proofs'));
    }
}
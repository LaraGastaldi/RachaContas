<?php

namespace App\Domain\Controllers;

use App\Domain\Models\UserToDebt;
use App\Domain\Resources\DebtResource;
use App\Domain\Resources\UserToDebtResource;
use App\Domain\Services\UserToDebtService;
use Illuminate\Http\Request;

class UserDebtController extends BaseController
{
    protected $resource = UserToDebtResource::class;
    /**
     * @var UserToDebtService
     */
    protected $service = UserToDebtService::class;
    
    public function getUserInfo($code): array
    {
        $userDebt = UserToDebt::where('verify_code', '=', $code)->firstOrFail();
        
        $debt = $userDebt->debt;

        return [
            'user' => $userDebt,
            'debt' => $debt
        ];
    }

    public function verifyView($code): \Illuminate\View\View
    {
        $info = $this->getUserInfo($code);

        return view('pages.verify-debt', $info);
    }
    public function verify($id): \Illuminate\Http\RedirectResponse
    {
        $user = UserToDebt::where('id','=', $id)->firstOrFail();
        $user->verified_at = now()->format('Y-m-d H:i:s');
        $user->save();

        return redirect()->route('user-to-debt.verified');
    }

    public function verified(): \Illuminate\View\View
    {
        return view('pages.verified-debt');
    }

    public function update(int $id, Request $request)
    {
        $validated = $request->validate([
            'name' => 'sometimes',
            'value' => 'sometimes',
            'relationship' => 'sometimes',
            'email' => 'sometimes',
        ]);

        return $this->service->update($id, $validated);
    }
}
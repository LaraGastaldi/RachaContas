<?php

namespace App\Domain\Resources;

class DebtResource extends BaseResource
{
    public function toArray($request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'description' => $this->description,
            'total_value' => $this->total_value,
            'debt_date' => $this->debt_date,
            'max_pay_date' => $this->max_pay_date,
            'created_at' => $this->created_at,
            'users' => UserToDebtResource::collection($this->users),
            'proofs' => ProofResource::collection($this->proofs),
        ];
    }
}
<?php

namespace App\Domain\Resources;

class UserToDebtResource extends BaseResource
{
    public function toArray($request): array
    {
        return [
            'id' => $this->id,
            'relationship' => $this->relationship,
            'user' => new UserResource($this->user),
            'name' => $this->name,
            'value' => $this->value,
            'email' => $this->email,
            'paid_value' => $this->paid_value,
            'verified_at' => $this->verified_at
        ];
    }
}
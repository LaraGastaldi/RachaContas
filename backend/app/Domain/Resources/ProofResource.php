<?php

namespace App\Domain\Resources;

class ProofResource extends BaseResource
{
    public function toArray($request): array
    {
        return [
            'id' => $this->id,
            'src' => $this->src,
            'type' => $this->type,
        ];
    }
}
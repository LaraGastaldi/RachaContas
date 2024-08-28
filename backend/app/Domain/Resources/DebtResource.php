<?php

namespace App\Domain\Resources;

class DebtResource extends BaseResource
{
    public function toArray($request): array
    {
        $year = intval($this->year) ?? null;
        return [
            'id' => $this->id,
            'marca' => $this->make,
            'modelo' => $this->model,
            'ano' => $year,
            'cor' => $this->color,
            'km' => $this->km,
            'combustivel' => $this->fuel,
            'cambio' => $this->transmission,
            'portas' => intval($this->doors),
            'preco' => floatval($this->price),
            'opcionais' => OptionalResource::collection($this->optionals),
        ];
    }
}
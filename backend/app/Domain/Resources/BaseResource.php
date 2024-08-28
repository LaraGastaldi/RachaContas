<?php

namespace App\Domain\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Nette\NotImplementedException;

abstract class BaseResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        throw new NotImplementedException('Implemente o método toArray na classe filha "' . get_class($this) . '"');
    }
}
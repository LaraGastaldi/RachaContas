<?php

namespace App\Domain\Resources;

class OptionalResource extends BaseResource
{
    public function toArray(\Illuminate\Http\Request $request): array
    {
        return [
            $this->name,
        ];
    }

    public static function collection($resource)
    {
        return $resource->map(function ($item) {
            return $item['name'];
        });
    } 
}
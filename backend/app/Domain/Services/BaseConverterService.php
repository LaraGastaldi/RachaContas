<?php

namespace App\Domain\Services;

abstract class BaseConverterService
{
    abstract public function convertArray(array $array);

    abstract public function convertToArray($domain);
}
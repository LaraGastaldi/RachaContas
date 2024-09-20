<?php

namespace App\Domain\Rules;

use Illuminate\Contracts\Validation\Rule;

class PhoneRule implements Rule
{
    public function passes($attribute, $value)
    {
        return preg_match('/^\+\d{2}\s\d{2}\s(9\s)?\d{4}-\d{4}$/', $value);
    }

    public function message()
    {
        return 'O campo :attribute deve ser um telefone válido.';
    }
}
<?php

namespace App\Domain\Rules;

use Illuminate\Contracts\Validation\Rule;

class RequiredIn implements Rule
{
    protected $array;

    /**
     * Create a new rule instance.
     *
     * @param  array  $array
     * @return void
     */
    public function __construct(array $array)
    {
        $this->array = $array;
    }

    /**
     * Determine if the validation rule passes.
     *
     * @param  string  $attribute
     * @param  mixed  $value
     * @return bool
     */
    public function passes($attribute, $value)
    {
        // Check if the value exists in the provided array
        if (in_array($value, $this->array)) {
            return true;
        }

        return false;
    }

    /**
     * Get the validation error message.
     *
     * @return string
     */
    public function message()
    {
        return 'O campo :attribute deve estar presente em um dos valores permitidos.';
    }
}

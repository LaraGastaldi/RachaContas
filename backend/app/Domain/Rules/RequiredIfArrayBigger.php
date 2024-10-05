<?php

namespace App\Domain\Rules;

use Illuminate\Contracts\Validation\Rule;

class RequiredIfArrayBigger implements Rule
{
    protected $array;
    protected $size;

    /**
     * Create a new rule instance.
     *
     * @param  array  $array
     * @param  int  $size
     * @return void
     */
    public function __construct(array $array, $size)
    {
        $this->array = $array;
        $this->size = $size;
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
        if (count($this->array) > $this->size && empty($value)) {
            return false;
        }

        return true;
    }

    /**
     * Get the validation error message.
     *
     * @return string
     */
    public function message()
    {
        return __('validation.required');
    }
}

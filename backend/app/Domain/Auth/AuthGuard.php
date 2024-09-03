<?php

namespace App\Domain\Auth;

use Illuminate\Auth\TokenGuard;

class AuthGuard extends TokenGuard {

    public function validate(array $credentials = []) {
        return true;
    }
}
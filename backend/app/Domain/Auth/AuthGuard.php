<?php

namespace App\Domain\Auth;

use Illuminate\Auth\TokenGuard;

class AuthGuard extends TokenGuard {

    public function validate(array $credentials = []) {
        
    }

    public function getTokenForRequest() {
        return request()->bearerToken();
    }

    
}
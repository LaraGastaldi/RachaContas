<?php

namespace Tests;

use App\Domain\Models\User;
use Database\Factories\UserFactory;
use Illuminate\Foundation\Testing\TestCase as BaseTestCase;

abstract class TestCase extends BaseTestCase
{
    protected $user;
    public function setUp(): void
    {
        parent::setUp();
        $this->user = User::factory()->make();
        dd($this->user);
    }
}

<?php

namespace Tests\Feature;
use Tests\TestCase;

class AuthTest extends TestCase
{
    public function setUp(): void
    {
        parent::setUp();
    }

    public function test_register()
    {
        $response = $this->post('/register', [
            'name' => 'test',
            'email' => 'test@test.com',
            'password'=> '12345',
        ]);

        $response->assertStatus(200);
        $this->assertDatabaseHas('users', [
            'name'=> 'test',
        ]);
    }
}
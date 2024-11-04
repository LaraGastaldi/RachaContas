<?php

namespace Tests\Feature;
use Tests\TestCase;

class DebtTest extends TestCase
{
    public function setUp(): void
    {
        parent::setUp();
    }

    public function test_debt_creation()
    {
        $this->actingAs($this->user);

        $response = $this->post('/debt', [
            'name' => 'test',
            'description' => 'test description',
            'total_value' => 100.0,
            'debt_date' => now()->format('Y-m-d H:i'),
            'max_pay_date' => null,
            'users' => [
                [
                    'relationship' => 'payer',
                    'email' => 'teste@teste.com',
                    'name' => 'test',
                ]
            ]
        ]);

        $response->assertStatus(200);
    }
}
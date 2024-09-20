<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('debt_proofs', function (Blueprint $table) {
            $table->id();
            $table->timestamps();

            $table->longText('src');
            $table->string('type');

            $table->bigInteger('debt_id');
            $table->foreign('debt_id')->references('id')->on('debts');

            $table->bigInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('debt_proofs');
    }
};

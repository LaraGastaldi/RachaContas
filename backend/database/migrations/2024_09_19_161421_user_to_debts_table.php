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
        Schema::create('user_to_debt', function (Blueprint $table) {
            $table->id();
            $table->timestamps();

            $table->string('relationship');
            $table->string('phone')->nullable();
            $table->string('email')->nullable();
            $table->timestamp('email_sent_at')->nullable();
            $table->timestamp('sms_sent_at')->nullable();
            $table->timestamp('verified_at')->nullable();
            $table->float('value', 2);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_to_debt');
    }
};

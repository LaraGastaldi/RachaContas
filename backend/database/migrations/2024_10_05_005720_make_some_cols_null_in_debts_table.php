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
        Schema::table('debts', function (Blueprint $table) {
            $table->text('description')->nullable()->change();
            $table->timestampTz('max_pay_date')->nullable()->change();
            $table->timestampTz('debt_date')->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('debts', function (Blueprint $table) {
            $table->text('description')->change();
            $table->timestamp('max_pay_date')->change();
            $table->timestamp('debt_date')->change();
        });
    }
};

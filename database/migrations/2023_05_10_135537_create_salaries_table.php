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
        Schema::create('salaries', function (Blueprint $table) {
            $table->id();
            $table->string('basic_date')->nullable();
            $table->string('selectedPaymentType')->nullable();
            $table->string('cash_bank_account')->nullable();
            $table->string('selectedProject')->nullable();
            $table->string('bank_cheque_no')->nullable();
            $table->string('bank_cheque_date')->nullable();
            $table->string('bank_name')->nullable();
            $table->string('bank_branch')->nullable();
            $table->string('basic_salary')->nullable();
            $table->string('commission')->nullable();
            $table->string('paid_month')->nullable();
            $table->string('paid_year')->nullable();
            $table->string('employee_id')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('salaries');
    }
};

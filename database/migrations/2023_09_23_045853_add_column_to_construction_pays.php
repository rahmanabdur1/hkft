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
        Schema::table('construction_pays', function (Blueprint $table) {
            //
            $table->string('physical_voucher');
            $table->string('selectedPaymentType');
            $table->string('cash_bank_account')->nullable();
            $table->string('bank_cheque_no')->nullable();
            $table->string('bank_cheque_date')->nullable();
            $table->string('bank_name')->nullable();
            $table->string('bank_branch')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('construction_pays', function (Blueprint $table) {
            //
        });
    }
};

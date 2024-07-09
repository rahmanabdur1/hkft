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
        Schema::create('r_p_ledgers', function (Blueprint $table) {
            $table->id();
            $table->string('client_name')->nullable();
            $table->string('receipt_id')->nullable();
            $table->string('product_name')->nullable();
            $table->string('paid')->nullable();
            $table->string('due')->nullable();
            $table->string('cash')->nullable();
            $table->string('bank')->nullable();
            $table->string('date')->nullable();
            $table->string('return_amount')->nullable();
            $table->string('balance')->nullable();
            $table->string('account_type')->nullable();
            $table->string('financialYear')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('r_p_ledgers');
    }
};

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
        Schema::table('receipt_vouchers', function (Blueprint $table) {
            //
            $table->string('initial_total_amount')->nullable();
            $table->string('account_type')->nullable();
            $table->string('building_name')->nullable();
            $table->string('property_id')->nullable();
            $table->string('selected_label')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('receipt_vouchers', function (Blueprint $table) {
            //
        });
    }
};

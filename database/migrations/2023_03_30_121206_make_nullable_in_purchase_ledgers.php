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
        Schema::table('purchase_ledgers', function (Blueprint $table) {
            //
            $table->string('paid')->nullable()->change();
            $table->string('due')->nullable()->change();
            $table->string('balance')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('purchase_ledgers', function (Blueprint $table) {
            //
        });
    }
};

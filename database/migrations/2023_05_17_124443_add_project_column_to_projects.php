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
        Schema::table('projects', function (Blueprint $table) {
            //
            $table->string('logo')->nullable();
            $table->string('contact_number')->nullable();
            $table->string('land_amount')->nullable();
            $table->string('average_flat_size')->nullable();
            $table->string('flore_area_size')->nullable();
            $table->string('building_height')->nullable();
            $table->string('architact_drawing')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('projects', function (Blueprint $table) {
            //
        });
    }
};

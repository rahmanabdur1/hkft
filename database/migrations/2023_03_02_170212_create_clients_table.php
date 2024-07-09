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
        Schema::create('clients', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('father_name')->nullable();
            $table->string('mother_name')->nullable();
            $table->string('husban_wife_name')->nullable();
            $table->string('birth_date');
            $table->string('religion')->nullable();
            $table->string('occupation')->nullable();
            $table->string('nationality')->nullable();
            $table->string('national_id_no');
            $table->string('permanent_location')->nullable();
            $table->string('permanent_post_office')->nullable();
            $table->string('permanent_thana')->nullable();
            $table->string('permanent_district')->nullable();
            $table->string('temprorary_location');
            $table->string('temprorary_post_office')->nullable();
            $table->string('temprorary_thana')->nullable();
            $table->string('temprorary_district')->nullable();
            $table->string('tin')->nullable();
            $table->string('phone')->nullable();
            $table->string('email')->nullable();
            $table->string('nid_img');
            $table->string('passport_img')->nullable();
            $table->string('tin_img')->nullable();
            $table->string('clientUnderProject');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('clients');
    }
};

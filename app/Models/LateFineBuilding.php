<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\LateFine;
class LateFineBuilding extends Model
{
    use HasFactory;
    protected $fillable=['building_name'];

    public function latefine(){
        return $this->belongsTo(LateFine::class,'late_fines_id');
    }
}

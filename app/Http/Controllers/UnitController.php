<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Unit;
use Illuminate\Support\Facades\DB;
class UnitController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index= Unit::all();
        return response()->json($index);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $unit = new Unit();
        $unit->item_name = $request->item_name;
        $unit->item_unit = $request->item_unit;
        $unit->save();
        return response()->json($unit);
    }
    // public function itemName($itemName){
    //     $unit = DB::table('units')->where('item_name',$itemName);
    //     return response()->json($unit);
    // }
    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $unit = DB::table('units')->where('id',$id)->first();
        return response()->json($unit);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $unit = Unit::find($id);
        $unit->item_name = $request->item_name;
        $unit->item_unit = $request->item_unit;
        $unit->save();
        return response()->json($unit);
    }

    public function filterUnit($itemName){
        $item = strtolower($itemName);

        if($item == 'land'){
            $index = DB::table('units')->whereRaw('lower(item_name) = ?','land')->get();
            return response()->json($index);
        }else if($item =='others'){
            $index = DB::table('units')->whereRaw('lower(item_name) != ?','land')->get();

            return response()->json($index);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}

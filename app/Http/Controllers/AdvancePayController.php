<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\AdvancePay;
use App\Models\TotalAdvancePay;

use Illuminate\Support\Facades\DB;
class AdvancePayController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index= AdvancePay::all();
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
        $advance = new AdvancePay;
        $advance->basic_date = $request->basic_date;
        $advance->client_name = $request->client_name;
        $advance->client_id = $request->client_id;
        $advance->selectedProject = $request->selectedProject;
        $advance->selectedBuilding =  $request->selectedBuilding;
        $advance->amount = $request->amount;
        $advance->note = $request->note;
        $advance->save();

        $index = DB::table('total_advance_pays')->where('client_id',$request->client_id)->first();
        if(!$index){
            $total_advance= new TotalAdvancePay;
            $total_advance->basic_date = $request->basic_date;
            $total_advance->client_name = $request->client_name;
            $total_advance->client_id = $request->client_id;
            $total_advance->selectedProject = $request->selectedProject;
            $total_advance->selectedBuilding =  $request->selectedBuilding;
            $total_advance->amount = $request->amount;
            $total_advance->note = $request->note;
            $total_advance->save();
        }else{
            $indexes = DB::table('total_advance_pays')->where('client_id',$request->client_id)->get();
            $totalAmount = 0;
            foreach($indexes as $ind){
                $totalAmount += intval($ind->amount);
            }
            $totalAmount += $request->amount;
            DB::table('total_advance_pays')->where('client_id',$request->client_id)->update(['amount'=>$totalAmount]);
        }
        return response()->json($advance);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $advance = AdvancePay::find($id);
        return response()->json($advance);
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
        $advance =  AdvancePay::find($id);
        $advance->basic_date = $request->basic_date;
        $advance->client_name = $request->client_name;
        $advance->client_id = $request->client_id;
        $advance->selectedProject = $request->selectedProject;
        $advance->selectedBuilding =  $request->selectedBuilding;
        $advance->amount = $request->amount;
        $advance->note = $request->note;
        $advance->save();

        $index = DB::table('total_advance_pays')->where('client_id',$request->client_id)->first();
        $updatedAmount = intval($index->amount)- intval($request->old_amount)+intval($request->amount);
        DB::table('total_advance_pays')->where('client_id',$request->client_id)->update(["amount"=>$updatedAmount]);
        return response()->json($advance);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        DB::table('advance_pays')->where('id',$id)->delete();
    }
}

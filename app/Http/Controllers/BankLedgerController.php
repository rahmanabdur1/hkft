<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\BankLedger;
use Carbon\Carbon;

class BankLedgerController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index = DB::table('bank_ledgers')
        ->select('bank_ledgers.product_name', DB::raw('MIN(id) as id'))
        ->groupBy('product_name')
        ->get();
        return response()->json($index);
    }

    public function receiveLdg(Request $request){
        $startdate = Carbon::createFromFormat('Y-m-d',$request->startDate);
        $enddate = Carbon::createFromFormat('Y-m-d',$request->endDate);
        if($request->supplier_name == null || $request->supplier_name ==''){
            $index = DB::table('bank_ledgers')->select('bank_ledgers.*')->where('product_name',$request->product_name)->whereBetween('date',[$startdate,$enddate])->orderBy('date')->get();
            $totalBalance = 0;
            $indexArray = [];
             if($index){
                 foreach($index as $ind){
                     $totalBalance+= intval($ind->paid) + intval($ind->due)+intval($ind->receipt_paid);
                     $indexArray[] = [
                        'id'=>$ind->id,
                        'payment_id'=>$ind->payment_id,
                        'cash'=>$ind->cash,
                        'bank'=>$ind->bank,
                         'paid' => $ind->paid,
                         'due' => $ind->due,
                         'return_amount'=>$ind->return_amount,
                         'balance' => $totalBalance,
                         'date'=>$ind->date,
                         'supplier_name'=>$ind->supplier_name,
                         'account_type'=>$ind->account_type,
                         'product_name'=>$ind->product_name,
                         'receipt_paid'=>$ind->receipt_paid,
                         'payment_status'=>$ind->payment_status,
                        ];
                 }
             }
        }else if($request->product_name == null || $request->product_name ==''){
            $index = DB::table('bank_ledgers')->select('bank_ledgers.*')->where('supplier_name',$request->supplier_name)->whereBetween('date',[$startdate,$enddate])->orderBy('date')->get();
            $totalBalance = 0;
            $indexArray = [];
             if($index){
                 foreach($index as $ind){
                     $totalBalance+= intval($ind->paid) + intval($ind->due)+intval($ind->receipt_paid);
                     $indexArray[] = [
                        'id'=>$ind->id,
                        'payment_id'=>$ind->payment_id,
                        'cash'=>$ind->cash,
                        'bank'=>$ind->bank,
                         'paid' => $ind->paid,
                         'due' => $ind->due,
                         'return_amount'=>$ind->return_amount,
                         'balance' => $totalBalance,
                         'date'=>$ind->date,
                         'supplier_name'=>$ind->supplier_name,
                         'account_type'=>$ind->account_type,
                         'product_name'=>$ind->product_name,
                         'receipt_paid'=>$ind->receipt_paid,
                         'payment_status'=>$ind->payment_status,
                        ];
                 }
             }
         }else{
             $index = DB::table('bank_ledgers')->select('bank_ledgers.*')->where('product_name',$request->product_name)->where('supplier_name',$request->supplier_name)->whereBetween('date',[$startdate,$enddate])->orderBy('date')->get();
    $totalBalance = 0;
    $indexArray = [];
     if($index){
         foreach($index as $ind){
             $totalBalance+= intval($ind->paid) + intval($ind->due)+intval($ind->receipt_paid);
             $indexArray[] = [
                'id'=>$ind->id,
                'payment_id'=>$ind->payment_id,
                'cash'=>$ind->cash,
                'bank'=>$ind->bank,
                 'paid' => $ind->paid,
                 'due' => $ind->due,
                 'return_amount'=>$ind->return_amount,
                 'balance' => $totalBalance,
                 'date'=>$ind->date,
                 'supplier_name'=>$ind->supplier_name,
                 'account_type'=>$ind->account_type,
                 'product_name'=>$ind->product_name,
                 'receipt_paid'=>$ind->receipt_paid,
                 'payment_status'=>$ind->payment_status,
                ];
         }
     }
         }


         return response()->json($indexArray);
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
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
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
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}

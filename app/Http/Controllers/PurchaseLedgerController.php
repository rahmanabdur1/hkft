<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\PurchaseLedger;
use Carbon\Carbon;
class PurchaseLedgerController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        //  $index= PurchaseLedger::all();
        $index = DB::table('purchase_ledgers')
        ->select('purchase_ledgers.product_name', DB::raw('MIN(id) as id'))
        ->groupBy('product_name')
        ->get();
        return response()->json($index);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function receiveLdg(Request $request){
        $startdate = Carbon::createFromFormat('Y-m-d',$request->startDate);
        $enddate = Carbon::createFromFormat('Y-m-d',$request->endDate);
        if($request->supplier_name == null || $request->supplier_name==''){
            $index = DB::table('purchase_ledgers')->select('purchase_ledgers.*')->where('product_name',$request->product_name)->whereBetween('date',[$startdate,$enddate])->orderBy('date')->get();
            $totalBalance = 0;
           $indexArray = [];
            if($index){
                foreach($index as $ind){
                    $totalBalance+=  intval($ind->balance);
                    $indexArray[] = [


                        'id'=>$ind->id,
                        'payment_id'=>$ind->payment_id,
                        'supplier_id'=>$ind->supplier_id,
                        'paid' => $ind->paid,
                        'due' => $ind->due,
                        'return_amount'=>$ind->return_amount,
                        'total_balance' => $totalBalance,
                         'balance'=>$ind->balance,
                        'date'=>$ind->date,
                        'supplier_name'=>$ind->supplier_name,
                        'cash'=>$ind->cash,
                        'bank'=>$ind->bank,
                        'product_name'=>$ind->product_name,
                    ];
                }
            }


        }
        else if($request->product_name == null || $request->product_name==''){
            $index = DB::table('purchase_ledgers')->select('purchase_ledgers.*')->where('supplier_name',$request->supplier_name)->whereBetween('date',[$startdate,$enddate])->orderBy('date')->get();
            $totalBalance = 0;
           $indexArray = [];
            if($index){
                foreach($index as $ind){
                    $totalBalance+=  intval($ind->balance);
                    $indexArray[] = [


                        'id'=>$ind->id,
                        'payment_id'=>$ind->payment_id,
                        'supplier_id'=>$ind->supplier_id,
                        'paid' => $ind->paid,
                        'due' => $ind->due,
                        'return_amount'=>$ind->return_amount,
                        'total_balance' => $totalBalance,
                         'balance'=>$ind->balance,
                        'date'=>$ind->date,
                        'supplier_name'=>$ind->supplier_name,
                        'cash'=>$ind->cash,
                        'bank'=>$ind->bank,
                        'product_name'=>$ind->product_name,
                    ];
                }
            }
        }

        else{
            $index = DB::table('purchase_ledgers')->select('purchase_ledgers.*')->where('product_name',$request->product_name)->where('supplier_name',$request->supplier_name)->whereBetween('date',[$startdate,$enddate])->orderBy('date')->get();
        $totalBalance = 0;
       $indexArray = [];
        if($index){
            foreach($index as $ind){
                $totalBalance+=  intval($ind->balance);
                $indexArray[] = [


                    'id'=>$ind->id,
                    'payment_id'=>$ind->payment_id,
                    'supplier_id'=>$ind->supplier_id,
                    'paid' => $ind->paid,
                    'due' => $ind->due,
                    'return_amount'=>$ind->return_amount,
                    'total_balance' => $totalBalance,
                     'balance'=>$ind->balance,
                    'date'=>$ind->date,
                    'supplier_name'=>$ind->supplier_name,
                    'cash'=>$ind->cash,
                    'bank'=>$ind->bank,
                    'product_name'=>$ind->product_name,
                ];
            }
        }
        }


        return response()->json($indexArray);
    }
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

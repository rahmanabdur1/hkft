<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
class SalesLedgerController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index = DB::table('sells_ledgers')
        ->select('sells_ledgers.product_name', DB::raw('MIN(id) as id'))
        ->groupBy('product_name')
        ->get();
        return response()->json($index);
    }

    public function receiveLdg(Request $request){
        $startdate = Carbon::createFromFormat('Y-m-d',$request->startDate);
        $enddate = Carbon::createFromFormat('Y-m-d',$request->endDate);
        if($request->product_name == null || $request->product_name==''){
            $index = DB::table('sells_ledgers')->select('sells_ledgers.*')->where('client_name',$request->client_name)->whereBetween('date',[$startdate,$enddate])->orderBy('date')->get();
            $totalBalance = 0;
           $indexArray = [];
            if($index){
                foreach($index as $ind){
                    $totalBalance+=  intval($ind->total_balance);
                    $indexArray[] = [


                        'id'=>$ind->id,
                        'payment_id'=>$ind->receipt_id,
                        'supplier_id'=>$ind->client_id,
                        'paid' => $ind->paid,
                        'due' => $ind->due,
                        'return_amount'=>$ind->return_amount,
                        'balance'=>$totalBalance,
                        'total_balance'=>$ind->total_balance,
                        'date'=>$ind->date,
                        'supplier_name'=>$ind->client_name,
                        'cash'=>$ind->cash,
                        'bank'=>$ind->bank,
                        'product_name'=>$ind->product_name,
                    ];
                }
            }
        }else if($request->client_name == null || $request->client_name==''){
            $index = DB::table('sells_ledgers')->select('sells_ledgers.*')->where('product_name',$request->product_name)->whereBetween('date',[$startdate,$enddate])->orderBy('date')->get();
            $totalBalance = 0;
           $indexArray = [];
            if($index){
                foreach($index as $ind){
                    $totalBalance+=  intval($ind->total_balance);
                    $indexArray[] = [


                        'id'=>$ind->id,
                        'payment_id'=>$ind->receipt_id,
                        'supplier_id'=>$ind->client_id,
                        'paid' => $ind->paid,
                        'due' => $ind->due,
                        'return_amount'=>$ind->return_amount,
                        'balance'=>$totalBalance,
                        'total_balance'=>$ind->total_balance,
                        'date'=>$ind->date,
                        'supplier_name'=>$ind->client_name,
                        'cash'=>$ind->cash,
                        'bank'=>$ind->bank,
                        'product_name'=>$ind->product_name,
                    ];
                }
            }

        }
            else{
            $index = DB::table('sells_ledgers')->select('sells_ledgers.*')->where('product_name',$request->product_name)->where('client_name',$request->client_name)->whereBetween('date',[$startdate,$enddate])->orderBy('date')->get();
        $totalBalance = 0;
       $indexArray = [];
        if($index){
            foreach($index as $ind){
                $totalBalance+=  intval($ind->total_balance);
                $indexArray[] = [


                    'id'=>$ind->id,
                    'payment_id'=>$ind->receipt_id,
                    'supplier_id'=>$ind->client_id,
                    'paid' => $ind->paid,
                    'due' => $ind->due,
                    'return_amount'=>$ind->return_amount,
                    'total_balance'=>$ind->total_balance,

                    'balance'=>$totalBalance,
                    'date'=>$ind->date,
                    'supplier_name'=>$ind->client_name,
                    'cash'=>$ind->cash,
                    'bank'=>$ind->bank,
                    'product_name'=>$ind->product_name,
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

<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use DateTime;
use Carbon\Carbon;
class TrialBalanceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }
    public function trialBalance(Request $request){
        $prevYearStartDate= new DateTime('01-07-'.$request->startYear);
        $currentYearEndDate = new DateTime('30-06-'.$request->endYear);
        $totalCashBalance=0;
        //cash ledger
        $cash_index = DB::table('cash_ledgers')->select('cash_ledgers.*')->whereBetween('date',[$prevYearStartDate,$currentYearEndDate])->get();
        if($cash_index){
            foreach($cash_index as $ind){
                $totalCashBalance+= intval($ind->paid) + intval($ind->due) +intval($ind->return_amount) +intval($ind->receipt_paid);

            }
        }
        //bank ledger
        $totalBankBalance=0;

        $bank_index = DB::table('bank_ledgers')->select('bank_ledgers.*')->whereBetween('date',[$prevYearStartDate,$currentYearEndDate])->get();
        if($bank_index){
            foreach($bank_index as $ind){
                $totalBankBalance+= intval($ind->paid) + intval($ind->due) +intval($ind->return_amount) +intval($ind->receipt_paid);

            }
        }

        //purchase ledger
        $totalPurchaseBalance = 0;
        $purchase_index = DB::table('purchase_ledgers')->select('purchase_ledgers.*')->whereBetween('date',[$prevYearStartDate,$currentYearEndDate])->get();
        if($purchase_index){
            foreach($purchase_index as $ind){
                $totalPurchaseBalance+= intval($ind->balance);

            }
        }
        //sales ledger
        $totalSalesBalance = 0;
        $sales_index = DB::table('sells_ledgers')->select('sells_ledgers.*')->whereBetween('date',[$prevYearStartDate,$currentYearEndDate])->get();
        if($sales_index){
            foreach($sales_index as $ind){
                $totalSalesBalance+=  intval($ind->total_balance);

            }
        }
        //accounts payable ledger
        $totalApBalance= 0;
        $ap_index = DB::table('apledgers')->select('apledgers.*')->whereBetween('date',[$prevYearStartDate,$currentYearEndDate])->get();
        if($ap_index){
            foreach($ap_index as $ind){
                $totalApBalance+=  intval($ind->paid) + intval($ind->due)+intval($ind->return_amount);;

            }
        }

        //accounts receivable ledger
        $totalArBalance = 0;
        $ar_index = DB::table('r_p_ledgers')->select('r_p_ledgers.*')->whereBetween('date',[$prevYearStartDate,$currentYearEndDate])->get();
        if($ar_index){
            foreach($ar_index as $ind){
                $totalArBalance+=  intval($ind->paid)+intval($ind->due);

            }
        }
        $data[] = [
            'totalCashBalance'=>$totalCashBalance,
            'totalBankBalance'=>$totalBankBalance,
            'totalPurchaseBalance'=>$totalPurchaseBalance,
            'totalSalesBalance'=>$totalSalesBalance,
            'totalApBalance'=>$totalApBalance,
            'totalArBalance'=>$totalArBalance,
        ];

        return response()->json($data);

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

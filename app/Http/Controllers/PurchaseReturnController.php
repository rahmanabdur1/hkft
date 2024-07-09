<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\PurchaseReturn;
use App\Models\Apledger;
use App\Models\PaymentVoucher;
use App\Models\payable_journal;
use App\Models\StockJournal;
class PurchaseReturnController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //

        $getPurchaseReturn = DB::table('purchase_returns')->pluck('payment_id');

        $index = PaymentVoucher::whereNotIn('payment_id', $getPurchaseReturn)->whereRaw("product_name != ?",'Land')->get();
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
        // purchase return
        $purchase_return = new PurchaseReturn;
        $purchase_return->payment_id = $request->payment_id;
        $purchase_return->supplier_name = $request->payee_name;
        $purchase_return->per_unit_price = $request->per_unit_price;
        $purchase_return->max_qty = $request->max_qty;
        $purchase_return->return_qty = $request->qty;
        $purchase_return->payment_due = $request->payment_due;
        $purchase_return->remaining_due = $request->remaining_due;
        $purchase_return->date = $request->date;
        $purchase_return->return_amount = $request->total_amount;
        $purchase_return->save();

        // payment vouchers
        $pv_database = DB::table('payment_vouchers')->where('payment_id', $request->payment_id)->first();

        $remaining_qty = intval($pv_database->qty) - intval($request->qty);
        $remaining_payment_due = intval($request->remaining_due);
        $remaining_total_amount = intval($pv_database->total_amount) - intval($request->total_amount);
        DB::table('payment_vouchers')->where('payment_id', $request->payment_id)->update(['qty' => $remaining_qty, 'payment_due' => $remaining_payment_due, 'total_amount' => $remaining_total_amount]);
        // stocks
        DB::table('stocks')->where('payment_id', $request->payment_id)->update(['quantity' => $remaining_qty]);
        //apledger
        $apledger = new Apledger;
        $apledger->supplier_name = $request->payee_name;
        $apledger->product_name = $request->product_name;
        $apledger->payment_id = $request->payment_id;
        $apledger->paid = 0;
        $apledger->due = 0;
        $apledger->cash = 'Cash';
        $apledger->bank = null;
        $apledger->date = $request->date;
        $apledger->return_amount = $request->total_amount;
        $parts = explode('-', $request->date);
        $year = $parts[0];
        $prevyear = intval($parts[0]) - 1;
        $apledger->financialYear = $prevyear . "-" . $year;
        $apledger->save();

        // payable journals + pay payables
        DB::table('payable_journals')->where('payment_id', $request->payment_id)->update(['due' => $remaining_payment_due, 'paid' => $remaining_payment_due]);
        if (intval($remaining_payment_due) == 0) {
            DB::table('payable_journals')->where('payment_id', $request->payment_id)->delete();
        }
        $pay_payables = DB::table('pay_payables')->where('payment_id', $request->payment_id)->first();
        if ($pay_payables) {
            $pay_payables_payment_due = intval($pay_payables->payment_due) - intval($request->total_amount);
            DB::table('pay_payables')->where('payment_id', $request->payment_id)->update(['payment_due' => $pay_payables_payment_due]);

            if (intval($remaining_payment_due) == 0) {
                $second_payment_due = 0;
                DB::table('pay_payables')->where('payment_id', $request->payment_id)->update(['payment_due' => $remaining_payment_due, 'second_payment_due' => $second_payment_due]);
            } else {
                $second_payment_due = intval($pay_payables_payment_due) - intval($pay_payables->receive_amount);
                // DB::table('payable_journals')->where('payment_id', $request->payment_id)->update(['due' => $remaining_payment_due, 'paid' => $remaining_payment_due]);
                DB::table('pay_payables')->where('payment_id', $request->payment_id)->update(['second_payment_due' => $second_payment_due]);
            }


        }


        //purchase journals --
        DB::table('purchased_journals')->where('payment_id', $request->payment_id)->update(['due' => $remaining_payment_due, 'total_amount' => $remaining_total_amount]);
        //purchase_ledger
        DB::table('purchase_ledgers')->where('payment_id', $request->payment_id)->update(['due' => $remaining_payment_due, 'balance' => $remaining_total_amount]);

            //stock journal
            if (strtolower($request->product_name) != 'land') {
                $sj_index = DB::table('stock_journals')->where('product_name', $request->product_name)->first();
                if ($sj_index) {
                    $updated_qty = intval($sj_index->total_quantity) - intval($request->qty);
                    DB::table('stock_journals')->where('product_name', $request->product_name)->update(['total_quantity' => $updated_qty]);
                    return response()->json(['sj_index' => $sj_index]);
                } else {
                    $item_id = DB::table('stocks')->where('product_name',$request->product_name)->first();
                    $stock_journal = new StockJournal;
                    $stock_journal->product_name = $request->product_name;
                    $stock_journal->total_quantity = $request->qty;
                    $stock_journal->product_id = $item_id->item_id;
                    $stock_journal->save();
                    return response()->json(['sj_index_new_entry' => $stock_journal]);

                }
            }

            //endd

        //end of all process
        return response()->json(['remain qty' => $remaining_qty . "-remain payment due:" . $remaining_payment_due . "-remaining_total_amount" . $remaining_total_amount]);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $index = PurchaseReturn::find($id);
        return response()->json($index);
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

            //stock journal
            if (strtolower($request->product_name) != 'land') {
                $sj_index = DB::table('stock_journals')->where('product_name', $request->product_name)->first();
                if ($sj_index) {
                    $dbindex = DB::table('purchase_returns')->where('payment_id',$request->payment_id)->first();
                    $updated_qty = intval($sj_index->total_quantity) - intval($request->qty)+ intval($dbindex->return_qty);
                    DB::table('stock_journals')->where('product_name', $request->product_name)->update(['total_quantity' => $updated_qty]);
                    return response()->json(['sj_index' => $sj_index]);
                } else {
                    $item_id = DB::table('stocks')->where('product_name',$request->product_name)->first();
                    $stock_journal = new StockJournal;
                    $stock_journal->product_name = $request->product_name;
                    $stock_journal->total_quantity = $request->qty;
                    $stock_journal->product_id = $item_id->item_id;
                    $stock_journal->save();
                    return response()->json(['sj_index_new_entry' => $stock_journal]);

                }
            }

            //endd
        $pv_database = DB::table('payment_vouchers')->where('payment_id', $request->payment_id)->first();

        //purchase returns
        $current_return_qty1 = $request->qty;
        // $payment_due1 = intval($request->payment_due);
        $payment_due1 = intval($pv_database->initian_total_amount) - intval($pv_database->receive_amount);
        $current_return_amount1 = intval($request->total_amount);
        $remaining_due1 = intval($request->updated_dbbase_payment_amount);
        DB::table('purchase_returns')->where('payment_id', $request->payment_id)->update(['return_qty' => $current_return_qty1, 'payment_due' => $payment_due1, 'return_amount' => $current_return_amount1, 'remaining_due' => $remaining_due1, 'max_qty' => $request->remaining_qty]);
        //  payment vouchers

        $remaining_qty = intval($request->remaining_qty);
        $remaining_payment_due = intval($request->updated_dbbase_payment_amount);
        $remaining_total_amount = intval($request->updated_dbbase_total_amount);
        DB::table('payment_vouchers')->where('payment_id', $request->payment_id)->update(['qty' => $remaining_qty, 'payment_due' => $remaining_payment_due, 'total_amount' => $remaining_total_amount]);
        // stocks
        DB::table('stocks')->where('payment_id', $request->payment_id)->update(['quantity' => $remaining_qty]);

        //apledger

        $dateUpdate = $request->date;
        $returnAmount = $request->total_amount;
        $parts = explode('-', $request->date);
        $year = $parts[0];
        $prevyear = intval($parts[0]) - 1;
        $financialYear = $prevyear . "-" . $year;
        DB::table('apledgers')->where('payment_id', $request->payment_id)->where('account_type', null)->update(['date' => $dateUpdate, 'return_amount' => $returnAmount, 'financialYear' => $financialYear]);

        // payable journals + pay payables
        DB::table('payable_journals')->where('payment_id', $request->payment_id)->update(['due' => $remaining_payment_due, 'paid' => $remaining_payment_due]);
        if (intval($remaining_payment_due) == 0) {
            DB::table('payable_journals')->where('payment_id', $request->payment_id)->delete();
        }
        $pay_payables = DB::table('pay_payables')->where('payment_id', $request->payment_id)->first();
         //purchase journals --
         DB::table('purchased_journals')->where('payment_id', $request->payment_id)->update(['due' => $remaining_payment_due, 'total_amount' => $remaining_total_amount]);
         //purchase_ledger
         DB::table('purchase_ledgers')->where('payment_id', $request->payment_id)->update(['due' => $remaining_payment_due, 'balance' => $remaining_total_amount]);
        if($pay_payables){
            $pay_payables_payment_due = intval($pay_payables->payment_due) + intval($request->old_total_amount) - intval($request->total_amount);

            $second_payment_due2 = intval($pay_payables_payment_due) - intval($pay_payables->receive_amount);

                $payment_due = intval($pay_payables->payment_due) + intval($request->old_total_amount) - intval($request->total_amount);
        }
        if ($pay_payables) {// payment due update korte hobe correct vabe
            $pay_payables_payment_due = intval($pay_payables->payment_due) + intval($request->old_total_amount) - intval($request->total_amount);
            DB::table('pay_payables')->where('payment_id', $request->payment_id)->update(['payment_due' => $pay_payables_payment_due]);

            if (intval($remaining_payment_due) == 0) {
                $second_payment_due = 0;
                DB::table('pay_payables')->where('payment_id', $request->payment_id)->update(['payment_due' => $remaining_payment_due, 'second_payment_due' => $second_payment_due]);
            } else {
                $second_payment_due = intval($pay_payables_payment_due) - intval($pay_payables->receive_amount);
                DB::table('pay_payables')->where('payment_id', $request->payment_id)->update(['second_payment_due' => $second_payment_due]);
            }


        }
        //add payable journals
        if (intval($remaining_payment_due) != 0) {
            $checkPayable = DB::table('payable_journals')->where('payment_id', $request->payment_id)->first();
            if (!$checkPayable) {
                $getData = DB::table('payment_vouchers')->where('payment_id', $request->payment_id)->first();
                $payable_journal = new payable_journal;
                $payable_journal->payment_id = $getData->payment_id;
                $payable_journal->payee_name = $getData->payee_name;
                $payable_journal->product_name = $getData->product_name;
                $payable_journal->payee_name_type = "Debit";
                $payable_journal->due = $remaining_payment_due;
                if ($getData->selectedPaymentType == 'Cheque') {
                    $payable_journal->bank = $getData->cash_bank_account;
                    $payable_journal->bank_type = "Credit";
                    $payable_journal->cash = null;
                    $payable_journal->cash_type = null;
                } else if ($getData->selectedPaymentType == 'Cash') {
                    $payable_journal->cash = "Cash";
                    $payable_journal->cash_type = "Credit";
                    $payable_journal->bank = null;
                    $payable_journal->bank_type = null;
                }
                $payable_journal->paid = $remaining_payment_due;
                $payable_journal->payable_date = $getData->basic_date;
                $payable_journal->financialYear = $getData->financialYear;
                $payable_journal->project = $getData->selectedProject;
                $payable_journal->save();
            }
        }





            return response()->json(['current_return_amount'=>$request->total_amount,'old_return_amount'=>$request->old_total_amount,'payment_due_in_purchase'=>$request->payment_due,'payment_due'=>$payment_due, 'pay payables payment due: '=>$pay_payables_payment_due,'second payment due: '=>$second_payment_due2,'receive_amount'=>$pay_payables->receive_amount]);



    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}

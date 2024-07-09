<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\PurchaseLedger;
use App\Models\Apledger;
use App\Models\CashLedger;
use App\Models\BankLedger;
use App\Models\PayPayable;
use App\Models\payable_journal;
use App\Models\purchased_journal;
use App\Models\PaymentHistory;

class PayPayableController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $getPayable = DB::table('pay_payables')->pluck('payment_id');

        $index = payable_journal::whereNotIn('payment_id', $getPayable)->get();
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
        $paypayable = new PayPayable;
        $paypayable->financialYear = $request->financialYear;
        $paypayable->basic_date = $request->basic_date;
        $paypayable->selectedPaymentType = $request->selectedPaymentType;
        $paypayable->cash_bank_account = $request->cash_bank_account;
        $paypayable->supplier_name = $request->payee_name;
        $paypayable->product_name = $request->product_name;
        $paypayable->bank_cheque_no = $request->bank_cheque_no;
        $paypayable->bank_cheque_date = $request->bank_cheque_date;
        $paypayable->bank_name = $request->bank_name;
        $paypayable->bank_branch = $request->bank_branch;
        $paypayable->receive_amount = intval($request->receive_amount);
        $paypayable->payment_id = $request->payment_id;
        $paypayable->payment_due = $request->payment_due; //total to pay
        $paypayable->second_payment_due = $request->second_payment_due;
        $paypayable->account_type = $request->account_type;
        $paypayable->save();

        $paymentHistory = new PaymentHistory;
        $paymentHistory->financialYear = $request->financialYear;
        $paymentHistory->basic_date = $request->basic_date;
        $paymentHistory->selectedPaymentType = $request->selectedPaymentType;
        $paymentHistory->cash_bank_account = $request->cash_bank_account;
        $paymentHistory->supplier_name = $request->payee_name;
        $paymentHistory->product_name = $request->product_name;
        $paymentHistory->bank_cheque_no = $request->bank_cheque_no;
        $paymentHistory->bank_cheque_date = $request->bank_cheque_date;
        $paymentHistory->bank_name = $request->bank_name;
        $paymentHistory->bank_branch = $request->bank_branch;
        $paymentHistory->paid = intval($request->current_amount);
        $paymentHistory->payment_id = $request->payment_id;
        $paymentHistory->project = $request->selectedProject;

        $paymentHistory->save();

        //purchase journal
        $PurchaseJournal = DB::table('purchased_journals')->where('payment_id', $request->payment_id)->first();

        $purchased_journal_due = intval($PurchaseJournal->due) - intval($request->receive_amount);
        $purchased_journal_paid = intval($PurchaseJournal->paid) + intval($request->receive_amount);


        DB::table('purchased_journals')->where('payment_id', $request->payment_id)->update(['due' => $purchased_journal_due, 'paid' => $purchased_journal_paid]);
        // purchased ledger
        DB::table('purchase_ledgers')->where('payment_id', $request->payment_id)->update(['due' => $purchased_journal_due, 'paid' => $purchased_journal_paid]);
        //payment voucher
        $pmntVoucher = array();
        $totalPayablePaid = 0;
        $getPayable1 = DB::table('pay_payables')->where('payment_id', $request->payment_id)->get();
        if ($getPayable1) {
            foreach ($getPayable1 as $gpv) {
                $totalPayablePaid += intval($gpv->receive_amount);
            }
        }
        $getPaymentVoucher = DB::table('payment_vouchers')->where('payment_id', $request->payment_id)->first();

        $pmntVoucher_receive_amount = intval($totalPayablePaid) + intval($getPaymentVoucher->receive_amount);
        $pmntVoucher_payment_due = intval($getPaymentVoucher->payment_due) - intval($totalPayablePaid);
        DB::table('payment_vouchers')->where('payment_id', $request->payment_id)->update(['receive_amount' => $pmntVoucher_receive_amount, 'payment_due' => $pmntVoucher_payment_due]);
        //payable journal
        if (intval($request->second_payment_due) > 0) {

            $getPaymentVoucher12 = DB::table('payment_vouchers')->where('payment_id', $request->payment_id)->first();

            DB::table('payable_journals')->where('payment_id', $request->payment_id)->update(['paid' => $getPaymentVoucher12->payment_due, 'due' => $getPaymentVoucher12->payment_due]);
        } else if (intval($request->second_payment_due) == 0) {
            DB::table('payable_journals')->where('payment_id', $request->payment_id)->delete();
        }

        //accounts payable ledger


        $apledger = new Apledger;
        $total_balance_init = 0;
        $getLedgers = DB::table('apledgers')->select('apledgers.*')->where('product_name', $request->product_name)->get();

        if ($getLedgers) {
            foreach ($getLedgers as $getLedger) {
                $total_balance_init += intval($getLedger->due) + intval($getLedger->paid) + intval($getLedger->return_amount);
            }
        }
        $apledger->supplier_name = $request->payee_name;
        $apledger->payment_id = $request->payment_id;
        $apledger->product_name = $request->product_name;
        $apledger->paid = intval($request->receive_amount);
        $apledger->financialYear = $request->financialYear;
        if ($request->selectedPaymentType == 'Cash') {
            $apledger->cash = "Cash";
            $apledger->bank = null;
        } else if ($request->selectedPaymentType == 'Cheque') {
            $apledger->cash = null;
            $apledger->bank = "Bank - " . $request->cash_bank_account;

        }
        $apledger->due = 0;
        $apledger->date = $request->basic_date;
        $apledger->return_amount = 0;
        $apledger->balance = $total_balance_init + intval($request->receive_amount);
        $apledger->account_type = $request->account_type;
        $apledger->save();


        // bank ledger && cash ledger
        if (intval($request->receive_amount) > 0) {


            if ($request->selectedPaymentType == 'Cheque') {
                $bankledger = new BankLedger;
                $bankledger->supplier_name = $request->payee_name;
                $bankledger->payment_id = $request->payment_id;
                $bankledger->product_name = $request->product_name;
                $bankledger->paid = -intval($request->receive_amount);
                $bankledger->due = 0;
                $bankledger->cash = "";
                $bankledger->bank = "Bank - " . $request->cash_bank_account;
                $bankledger->date = $request->basic_date;
                $bankledger->account_type = $request->account_type;

                $checkFullPaid = DB::table('pay_payables')->where('account_type',$request->account_type)->first();
                if($checkFullPaid->second_payment_due == 0){
                    $bankledger->payment_status = 1;

                }else{
                    $bankledger->payment_status = 0;

                }
                $totalBankBalance = 0;
                $bank_Ledgers = DB::table('bank_ledgers')->where('product_name', $request->product_name)->get();
                if ($bank_Ledgers) {
                    foreach ($bank_Ledgers as $bank_Ledger) {
                        $totalBankBalance += intval($bank_Ledger->paid) + intval($bank_Ledger->due);
                    }
                }
                $bankledger->balance = $totalBankBalance - intval($request->receive_amount);
                $bankledger->save();
            } else if ($request->selectedPaymentType == 'Cash') {

                $cashledger = new CashLedger;
                $cashledger->supplier_name = $request->payee_name;
                $cashledger->payment_id = $request->payment_id;
                $cashledger->product_name = $request->product_name;
                $cashledger->paid = -intval($request->receive_amount);
                $cashledger->due = 0;
                $cashledger->cash = "Cash";
                $cashledger->bank = "";
                $cashledger->date = $request->basic_date;
                $cashledger->account_type = $request->account_type;
                $totalCashBalance = 0;
                $checkFullPaid = DB::table('pay_payables')->where('account_type',$request->account_type)->first();
                if($checkFullPaid->second_payment_due == 0){
                    $cashledger->payment_status = 1;

                }else{
                    $cashledger->payment_status = 0;

                }
                $cash_Ledgers = DB::table('cash_ledgers')->where('product_name', $request->product_name)->get();
                if ($cash_Ledgers) {
                    foreach ($cash_Ledgers as $cash_Ledger) {
                        $totalCashBalance += intval($cash_Ledger->paid) + intval($cash_Ledger->due);
                    }
                }
                $cashledger->balance = $totalCashBalance - intval($request->receive_amount);

                $cashledger->save();

            }
        }

        //update purchase returns
        $purchase_returns = DB::table('purchase_returns')->where('payment_id', $request->payment_id)->first();
        if ($purchase_returns) {
            $payment_due = intval($purchase_returns->payment_due) - intval($request->receive_amount);
            $remaining_due = intval($payment_due) - intval($purchase_returns->return_amount);
            if(intval($remaining_due)== 0){
                $checkInCash = DB::table('cash_ledgers')->where('account_type', $request->account_type)->first();
                if($checkInCash){
                    DB::table('cash_ledgers')->where('account_type', $request->account_type)->update(['payment_status'=>1]);
                }
                $checkInBank = DB::table('bank_ledgers')->where('account_type', $request->account_type)->first();
                if($checkInBank){
                    DB::table('bank_ledgers')->where('account_type', $request->account_type)->update(['payment_status'=>1]);
                }
            }else{
                $checkInCash = DB::table('cash_ledgers')->where('account_type', $request->account_type)->first();
                if($checkInCash){
                    DB::table('cash_ledgers')->where('account_type', $request->account_type)->update(['payment_status'=>0]);
                }
                $checkInBank = DB::table('bank_ledgers')->where('account_type', $request->account_type)->first();
                if($checkInBank){
                    DB::table('bank_ledgers')->where('account_type', $request->account_type)->update(['payment_status'=>0]);
                }
            }
            DB::table('purchase_returns')->where('payment_id', $request->payment_id)->update(['payment_due' => $payment_due, 'remaining_due' => $remaining_due]);
        }



        //end store

        //end store-|
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $getData = DB::table('pay_payables')->join('payable_journals', 'pay_payables.payment_id', '=', 'payable_journals.payment_id')->select('pay_payables.*', 'payable_journals.payee_name')->where('pay_payables.id', $id)->first();

        return response()->json($getData);
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


        $paymentHistory = new PaymentHistory;
        $paymentHistory->financialYear = $request->financialYear;
        $paymentHistory->basic_date = $request->basic_date;
        $paymentHistory->selectedPaymentType = $request->selectedPaymentType;
        $paymentHistory->cash_bank_account = $request->cash_bank_account;
        $paymentHistory->supplier_name = $request->payee_name;
        $paymentHistory->product_name = $request->product_name;
        $paymentHistory->bank_cheque_no = $request->bank_cheque_no;
        $paymentHistory->bank_cheque_date = $request->bank_cheque_date;
        $paymentHistory->bank_name = $request->bank_name;
        $paymentHistory->bank_branch = $request->bank_branch;
        $paymentHistory->paid = intval($request->current_amount);
        $paymentHistory->payment_id = $request->payment_id;
        $fetchProject = DB::table('payment_histories')->where('payment_id',$request->payment_id)->first();

        $paymentHistory->project = $fetchProject->project;
        $paymentHistory->save();
        //udpate pay payable

        $paypayable = array();
        $paypayable['financialYear'] = $request->financialYear;
        $paypayable['basic_date'] = $request->basic_date;
        $paypayable['selectedPaymentType'] = $request->selectedPaymentType;
        $paypayable['cash_bank_account'] = $request->cash_bank_account;
        $paypayable['supplier_name'] = $request->payee_name;
        $paypayable['product_name'] = $request->product_name;
        $paypayable['bank_cheque_no'] = $request->bank_cheque_no;
        $paypayable['bank_cheque_date'] = $request->bank_cheque_date;
        $paypayable['bank_name'] = $request->bank_name;
        $paypayable['bank_branch'] = $request->bank_branch;
        $paypayable['receive_amount'] = intval($request->receive_amount);
        $paypayable['payment_id'] = $request->payment_id;
        $paypayable['payment_due'] = $request->payment_due; //total to pay
        $paypayable['second_payment_due'] = $request->second_payment_due;

        DB::table('pay_payables')->where('account_type', $request->account_type)->update($paypayable);

        //payment voucher
        // $pmntVoucher = array();

        $getPayable1 = DB::table('pay_payables')->where('payment_id', $request->payment_id)->first();

        $getPaymentVoucher = DB::table('payment_vouchers')->where('payment_id', $request->payment_id)->first();

        $pmntVoucher_receive_amount = intval($getPaymentVoucher->receive_amount) - intval($request->old_receive_amount) + intval($getPayable1->receive_amount);
        // $pmntVoucher_payment_due = intval($getPaymentVoucher->payment_due) +intval($request->old_receive_amount)-intval($getPayable1->receive_amount);
        $pmntVoucher_payment_due = intval($request->second_payment_due);
        DB::table('payment_vouchers')->where('payment_id', $request->payment_id)->update(['receive_amount' => $pmntVoucher_receive_amount, 'payment_due' => $pmntVoucher_payment_due]);

        //update purchased journal old payment id and changed payment id
        $paidPrchsd = $pmntVoucher_receive_amount;
        $duePrchsd = $pmntVoucher_payment_due;

        DB::table('purchased_journals')->where('payment_id', $request->payment_id)->update(['paid' => $paidPrchsd, 'due' => $duePrchsd]);


        // purchased ledger
        DB::table('purchase_ledgers')->where('payment_id', $request->payment_id)->update(['due' => $duePrchsd, 'paid' => $paidPrchsd]);




        //update account payable
        if (intval($request->second_payment_due) > 0) {

            $getPaymentVoucher12 = DB::table('payment_vouchers')->where('payment_id', $request->payment_id)->first();

            DB::table('payable_journals')->where('payment_id', $request->payment_id)->update(['paid' => $getPaymentVoucher12->payment_due, 'due' => $getPaymentVoucher12->payment_due]);
        } else if (intval($request->second_payment_due) == 0) {
            DB::table('payable_journals')->where('payment_id', $request->payment_id)->delete();
        }


        //update apledger
        $apledger = array();
        $apledger['supplier_name'] = $request->payee_name;
        $apledger['due'] = 0;
        $apledger['date'] = $request->basic_date;
        $apledger['product_name'] = $request->product_name;
        if ($request->selectedPaymentType == 'Cash') {
            $apledger['cash'] = "Cash";
            $apledger['bank'] = null;
        } else if ($request->selectedPaymentType == 'Cheque') {
            $apledger['cash'] = null;
            $apledger['bank'] = "Bank - " . $request->cash_bank_account;

        }
        $apledger['paid'] = $request->receive_amount;
        $apledger['financialYear'] = $request->financialYear;
        DB::table('apledgers')->where('account_type', $request->account_type)->update($apledger);

        //update Cash && bank Ledger
        if ($request->selectedPaymentType == 'Cheque') {
            $getBankAccount = DB::table('bank_ledgers')->where('account_type', $request->account_type)->first();
            if ($getBankAccount) {
                $bankledger = array();
                $bankledger['supplier_name'] = $request->payee_name;
                $bankledger['payment_id'] = $request->payment_id;
                $bankledger['product_name'] = $request->product_name;
                $bankledger['paid'] = -intval($request->receive_amount);
                $bankledger['due'] = 0;
                $bankledger['cash'] = "";
                $bankledger['bank'] = "Bank-" . $request->cash_bank_account;
                $bankledger['date'] = $request->basic_date;
                $checkFullPaid = DB::table('pay_payables')->where('account_type',$request->account_type)->first();
                if($checkFullPaid->second_payment_due == 0){
                    $bankledger['payment_status'] = 1;

                }else{
                    $bankledger['payment_status'] = 0;

                }
                $bankledger['financialYear'] = $request->financialYear;

                DB::table('bank_ledgers')->where('account_type', $request->account_type)->update($bankledger);
            } else {
                $bankledger = new BankLedger;
                $bankledger->supplier_name = $request->payee_name;
                $bankledger->payment_id = $request->payment_id;
                $bankledger->product_name = $request->product_name;
                $bankledger->paid = -intval($request->receive_amount);
                $bankledger->due = 0;
                $bankledger->cash = "";
                $bankledger->bank = "Bank - " . $request->cash_bank_account;
                $bankledger->date = $request->basic_date;
                $bankledger->account_type = $request->account_type;
                $checkFullPaid = DB::table('pay_payables')->where('account_type',$request->account_type)->first();
                if($checkFullPaid->second_payment_due == 0){
                    $bankledger->payment_status = 1;

                }else{
                    $bankledger->payment_status = 0;

                }
                $totalBankBalance = 0;
                $bank_Ledgers = DB::table('bank_ledgers')->where('product_name', $request->product_name)->get();
                if ($bank_Ledgers) {
                    foreach ($bank_Ledgers as $bank_Ledger) {
                        $totalBankBalance += intval($bank_Ledger->paid) + intval($bank_Ledger->due);
                    }
                }
                $bankledger->balance = $totalBankBalance - intval($request->receive_amount);
                $bankledger->save();
                DB::table('cash_ledgers')->where('account_type', $request->account_type)->delete();
            }


        } else if ($request->selectedPaymentType == 'Cash') {
            $getCashAccount = DB::table('cash_ledgers')->where('account_type', $request->account_type)->first();
            if ($getCashAccount) {
                $cashledger = array();
                $cashledger['supplier_name'] = $request->payee_name;
                $cashledger['payment_id'] = $request->payment_id;
                $cashledger['product_name'] = $request->product_name;
                $cashledger['paid'] = -intval($request->receive_amount);
                $cashledger['due'] = 0;
                $cashledger['cash'] = "Cash";
                $cashledger['bank'] = "";
                $cashledger['date'] = $request->basic_date;

                $checkFullPaid = DB::table('pay_payables')->where('account_type',$request->account_type)->first();
                if($checkFullPaid->second_payment_due == 0){
                    $cashledger['payment_status'] = 1;

                }else{
                    $cashledger['payment_status'] = 0;

                }
                $cashledger['financialYear'] = $request->financialYear;
                DB::table('cash_ledgers')->where('account_type', $request->account_type)->update($cashledger);

            } else {
                $cashledger = new CashLedger;
                $cashledger->supplier_name = $request->payee_name;
                $cashledger->payment_id = $request->payment_id;
                $cashledger->product_name = $request->product_name;
                $cashledger->paid = -intval($request->receive_amount);
                $cashledger->due = 0;
                $cashledger->cash = "Cash";
                $cashledger->bank = "";
                $cashledger->date = $request->basic_date;
                $cashledger->account_type = $request->account_type;
                $totalCashBalance = 0;
                $checkFullPaid = DB::table('pay_payables')->where('account_type',$request->account_type)->first();
                if($checkFullPaid->second_payment_due == 0){
                    $cashledger->payment_status = 1;

                }else{
                    $cashledger->payment_status = 0;

                }
                $cash_Ledgers = DB::table('cash_ledgers')->where('product_name', $request->product_name)->get();
                if ($cash_Ledgers) {
                    foreach ($cash_Ledgers as $cash_Ledger) {
                        $totalCashBalance += intval($cash_Ledger->paid) + intval($cash_Ledger->due);
                    }
                }
                $cashledger->balance = $totalCashBalance - intval($request->receive_amount);

                $cashledger->save();
                DB::table('bank_ledgers')->where('account_type', $request->account_type)->delete();

            }

        }

        //update purchase returns
        $purchase_returns = DB::table('purchase_returns')->where('payment_id', $request->payment_id)->first();
        if ($purchase_returns) {
            $payment_due = intval($purchase_returns->payment_due) + intval($request->old_receive_amount)- intval($request->receive_amount);
            $remaining_due = intval($payment_due) - intval($purchase_returns->return_amount);
            DB::table('purchase_returns')->where('payment_id', $request->payment_id)->update(['payment_due' => $payment_due, 'remaining_due' => $remaining_due]);
            if(intval($remaining_due)== 0){
                $checkInCash = DB::table('cash_ledgers')->where('account_type', $request->account_type)->first();
                if($checkInCash){
                    DB::table('cash_ledgers')->where('account_type', $request->account_type)->update(['payment_status'=>1]);
                }
                $checkInBank = DB::table('bank_ledgers')->where('account_type', $request->account_type)->first();
                if($checkInBank){
                    DB::table('bank_ledgers')->where('account_type', $request->account_type)->update(['payment_status'=>1]);
                }
            }else{
                $checkInCash = DB::table('cash_ledgers')->where('account_type', $request->account_type)->first();
                if($checkInCash){
                    DB::table('cash_ledgers')->where('account_type', $request->account_type)->update(['payment_status'=>0]);
                }
                $checkInBank = DB::table('bank_ledgers')->where('account_type', $request->account_type)->first();
                if($checkInBank){
                    DB::table('bank_ledgers')->where('account_type', $request->account_type)->update(['payment_status'=>0]);
                }
            }
        }


        //end all update
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}

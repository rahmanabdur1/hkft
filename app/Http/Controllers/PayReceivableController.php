<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\ReceiptPayableJournal;
use Illuminate\Support\Facades\DB;
use App\Models\PayReceivable;
use App\Models\CashLedger;
use App\Models\BankLedger;
use App\Models\RPLedger;
use App\Models\ReceiptHistory;

class PayReceivableController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $getPayable = DB::table('pay_receivables')->pluck('receipt_id');

        $index = ReceiptPayableJournal::whereNotIn('receipt_id', $getPayable)->get();
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
        $paypayable = new PayReceivable;
        $paypayable->financialYear = $request->financialYear;
        $paypayable->basic_date = $request->basic_date;
        $paypayable->selectedPaymentType = $request->selectedPaymentType;
        $paypayable->cash_bank_account = $request->cash_bank_account;
        $paypayable->supplier_name = $request->client_name;
        $paypayable->product_name = $request->product_name;
        $paypayable->bank_cheque_no = $request->bank_cheque_no;
        $paypayable->bank_cheque_date = $request->bank_cheque_date;
        $paypayable->bank_name = $request->bank_name;
        $paypayable->bank_branch = $request->bank_branch;
        $paypayable->receive_amount = intval($request->receive_amount);
        $paypayable->receipt_id = $request->receipt_id;
        $paypayable->due = $request->due; //total to pay
        $paypayable->second_due = $request->second_due;
        $paypayable->account_type = $request->account_type;
        $paypayable->save();

        $paymentHistory = new ReceiptHistory;
        $paymentHistory->financialYear = $request->financialYear;
        $paymentHistory->basic_date = $request->basic_date;
        $paymentHistory->selectedPaymentType = $request->selectedPaymentType;
        $paymentHistory->cash_bank_account = $request->cash_bank_account;
        $paymentHistory->supplier_name = $request->client_name;
        $paymentHistory->product_name = $request->product_name;
        $paymentHistory->bank_cheque_no = $request->bank_cheque_no;
        $paymentHistory->bank_cheque_date = $request->bank_cheque_date;
        $paymentHistory->bank_name = $request->bank_name;
        $paymentHistory->bank_branch = $request->bank_branch;
        $paymentHistory->paid = intval($request->receive_amount);
        $paymentHistory->receipt_id = $request->receipt_id;
        $fetchProject = DB::table('receipt_histories')->where('receipt_id',$request->receipt_id)->first();

        $paymentHistory->project = $fetchProject->project;


        $paymentHistory->save();
        //purchase journal
        $PurchaseJournal = DB::table('receipt_journals')->where('receipt_id', $request->receipt_id)->first();

        $purchased_journal_due = intval($PurchaseJournal->due) - intval($request->receive_amount);
        $purchased_journal_paid = intval($PurchaseJournal->paid) + intval($request->receive_amount);


        DB::table('receipt_journals')->where('receipt_id', $request->receipt_id)->update(['due' => $purchased_journal_due, 'paid' => $purchased_journal_paid]);
        // receipt ledger
        DB::table('sells_ledgers')->where('receipt_id', $request->receipt_id)->update(['due' => $purchased_journal_due, 'paid' => $purchased_journal_paid]);

        // receipt voucher
        $totalPayablePaid = 0;
        $getPayable1 = DB::table('pay_receivables')->where('receipt_id', $request->receipt_id)->get();
        if ($getPayable1) {
            foreach ($getPayable1 as $gpv) {
                $totalPayablePaid += intval($gpv->receive_amount);
            }
        }
        $getPaymentVoucher = DB::table('receipt_vouchers')->where('receipt_id', $request->receipt_id)->first();

        $pmntVoucher_receive_amount = intval($totalPayablePaid) + intval($getPaymentVoucher->total_amount);
        $pmntVoucher_payment_due = intval($getPaymentVoucher->due) - intval($totalPayablePaid);
        DB::table('receipt_vouchers')->where('receipt_id', $request->receipt_id)->update(['total_amount' => $pmntVoucher_receive_amount, 'due' => $pmntVoucher_payment_due]);
        //payable journal
        if (intval($request->second_due) > 0) {

            $getPaymentVoucher12 = DB::table('receipt_vouchers')->where('receipt_id', $request->receipt_id)->first();

            DB::table('receipt_payable_journals')->where('receipt_id', $request->receipt_id)->update(['paid' => $getPaymentVoucher12->due, 'due' => $getPaymentVoucher12->due]);
        } else if (intval($request->second_due) == 0) {
            DB::table('receipt_payable_journals')->where('receipt_id', $request->receipt_id)->delete();
        }

        //accounts receivable ledger


        $apledger = new RPLedger;
        $total_balance_init = 0;
        $getLedgers = DB::table('r_p_ledgers')->select('r_p_ledgers.*')->where('product_name', $request->product_name)->get();

        if ($getLedgers) {
            foreach ($getLedgers as $getLedger) {
                $total_balance_init += intval($getLedger->due) + intval($getLedger->paid) + intval($getLedger->return_amount);
            }
        }
        $apledger->client_name = $request->client_name;
        $apledger->receipt_id = $request->receipt_id;
        $apledger->product_name = $request->product_name;
        $apledger->paid = -intval($request->receive_amount);
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
        $apledger->account_type = $request->account_type;
        $apledger->save();


        // bank ledger && cash ledger
        if (intval($request->receive_amount) > 0) {


            if ($request->selectedPaymentType == 'Cheque') {
                $bankledger = new BankLedger;
                $bankledger->supplier_name = $request->client_name;
                $bankledger->payment_id = $request->receipt_id;
                $bankledger->product_name = $request->product_name;
                $bankledger->receipt_paid = intval($request->receive_amount);
                $bankledger->receipt_due = 0;
                $bankledger->cash = "";
                $bankledger->bank = "Bank - " . $request->cash_bank_account;
                $bankledger->date = $request->basic_date;
                $bankledger->account_type = $request->account_type;

                $checkFullPaid = DB::table('pay_receivables')->where('account_type',$request->account_type)->first();
                if($checkFullPaid->second_due == 0){
                    $bankledger->payment_status = 1;

                }else{
                    $bankledger->payment_status = 0;

                }
                $totalBankBalance = 0;
                $bank_Ledgers = DB::table('bank_ledgers')->where('product_name', $request->product_name)->get();
                if ($bank_Ledgers) {
                    foreach ($bank_Ledgers as $bank_Ledger) {
                        $totalBankBalance += intval($bank_Ledger->receipt_paid) + intval($bank_Ledger->receipt_due);
                    }
                }
                $bankledger->balance = $totalBankBalance - intval($request->receive_amount);
                $bankledger->save();
            } else if ($request->selectedPaymentType == 'Cash') {

                $cashledger = new CashLedger;
                $cashledger->supplier_name = $request->client_name;
                $cashledger->payment_id = $request->receipt_id;
                $cashledger->product_name = $request->product_name;
                $cashledger->receipt_paid = intval($request->receive_amount);
                $cashledger->receipt_due = 0;
                $cashledger->cash = "Cash";
                $cashledger->bank = "";
                $cashledger->date = $request->basic_date;
                $cashledger->account_type = $request->account_type;
                $totalCashBalance = 0;
                $checkFullPaid = DB::table('pay_receivables')->where('account_type',$request->account_type)->first();
                if($checkFullPaid->second_due == 0){
                    $cashledger->payment_status = 1;

                }else{
                    $cashledger->payment_status = 0;

                }
                $cash_Ledgers = DB::table('cash_ledgers')->where('product_name', $request->product_name)->get();
                if ($cash_Ledgers) {
                    foreach ($cash_Ledgers as $cash_Ledger) {
                        $totalCashBalance += intval($cash_Ledger->receipt_paid) + intval($cash_Ledger->receipt_due);
                    }
                }
                $cashledger->balance = $totalCashBalance - intval($request->receive_amount);

                $cashledger->save();

            }
    }
}

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $getData = DB::table('pay_receivables')->join('receipt_payable_journals', 'pay_receivables.receipt_id', '=', 'receipt_payable_journals.receipt_id')->select('pay_receivables.*', 'receipt_payable_journals.client_name')->where('pay_receivables.id', $id)->first();

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
        //

        $paymentHistory = new ReceiptHistory;
        $paymentHistory->financialYear = $request->financialYear;
        $paymentHistory->basic_date = $request->basic_date;
        $paymentHistory->selectedPaymentType = $request->selectedPaymentType;
        $paymentHistory->cash_bank_account = $request->cash_bank_account;
        $paymentHistory->supplier_name = $request->client_name;
        $paymentHistory->product_name = $request->product_name;
        $paymentHistory->bank_cheque_no = $request->bank_cheque_no;
        $paymentHistory->bank_cheque_date = $request->bank_cheque_date;
        $paymentHistory->bank_name = $request->bank_name;
        $paymentHistory->bank_branch = $request->bank_branch;
        $paymentHistory->paid = intval($request->current_amount);
        $paymentHistory->receipt_id = $request->receipt_id;
        $fetchProject = DB::table('receipt_histories')->where('receipt_id',$request->receipt_id)->first();

        $paymentHistory->project = $fetchProject->project;

        $paymentHistory->save();
           //udpate pay payable

           $paypayable = array();
           $paypayable['financialYear'] = $request->financialYear;
           $paypayable['basic_date'] = $request->basic_date;
           $paypayable['selectedPaymentType'] = $request->selectedPaymentType;
           $paypayable['cash_bank_account'] = $request->cash_bank_account;
           $paypayable['supplier_name'] = $request->client_name;
           $paypayable['product_name'] = $request->product_name;
           $paypayable['bank_cheque_no'] = $request->bank_cheque_no;
           $paypayable['bank_cheque_date'] = $request->bank_cheque_date;
           $paypayable['bank_name'] = $request->bank_name;
           $paypayable['bank_branch'] = $request->bank_branch;
           $paypayable['receive_amount'] = intval($request->receive_amount);
           $paypayable['receipt_id'] = $request->receipt_id;
           $paypayable['due'] = $request->due; //total to pay
           $paypayable['second_due'] = $request->second_due;

           DB::table('pay_receivables')->where('account_type', $request->account_type)->update($paypayable);

           //receipt voucher
           // $pmntVoucher = array();

           $getPayable1 = DB::table('pay_receivables')->where('receipt_id', $request->receipt_id)->first();

           $getPaymentVoucher = DB::table('receipt_vouchers')->where('receipt_id', $request->receipt_id)->first();

           $pmntVoucher_receive_amount = intval($getPaymentVoucher->total_amount) - intval($request->old_receive_amount) + intval($getPayable1->receive_amount);
           $pmntVoucher_payment_due = intval($request->second_due);
           DB::table('receipt_vouchers')->where('receipt_id', $request->receipt_id)->update(['total_amount' => $pmntVoucher_receive_amount, 'due' => $pmntVoucher_payment_due]);


           //update receipt journal old receipt id and changed receipt id
           $paidPrchsd = $pmntVoucher_receive_amount;
           $duePrchsd = $pmntVoucher_payment_due;

           DB::table('receipt_journals')->where('receipt_id', $request->receipt_id)->update(['paid' => $paidPrchsd, 'due' => $duePrchsd]);


           // receipt ledger
           DB::table('sells_ledgers')->where('receipt_id', $request->receipt_id)->update(['due' => $duePrchsd, 'paid' => $paidPrchsd]);




           //update account payable
           if (intval($request->second_due) > 0) {

               $getPaymentVoucher12 = DB::table('receipt_vouchers')->where('receipt_id', $request->receipt_id)->first();

               DB::table('receipt_payable_journals')->where('receipt_id', $request->receipt_id)->update(['paid' => $getPaymentVoucher12->due, 'due' => $getPaymentVoucher12->due]);
           } else if (intval($request->second_due) == 0) {
               DB::table('receipt_payable_journals')->where('receipt_id', $request->receipt_id)->delete();
           }


           //update apledger
           $apledger = array();
           $apledger['client_name'] = $request->client_name;
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
           $apledger['paid'] = -intval($request->receive_amount);
           $apledger['financialYear'] = $request->financialYear;
           DB::table('r_p_ledgers')->where('account_type', $request->account_type)->update($apledger);

           //update Cash && bank Ledger
           if ($request->selectedPaymentType == 'Cheque') {
               $getBankAccount = DB::table('bank_ledgers')->where('account_type', $request->account_type)->first();
               if ($getBankAccount) {
                   $bankledger = array();
                   $bankledger['supplier_name'] = $request->client_name;
                   $bankledger['payment_id'] = $request->receipt_id;
                   $bankledger['product_name'] = $request->product_name;
                   $bankledger['receipt_paid'] = intval($request->receive_amount);
                   $bankledger['receipt_due'] = 0;
                   $bankledger['cash'] = "";
                   $bankledger['bank'] = "Bank-" . $request->cash_bank_account;
                   $bankledger['date'] = $request->basic_date;
                   $checkFullPaid = DB::table('pay_receivables')->where('account_type',$request->account_type)->first();
                   if($checkFullPaid->second_due == 0){
                       $bankledger['payment_status'] = 1;

                   }else{
                       $bankledger['payment_status'] = 0;

                   }
                   $bankledger['financialYear'] = $request->financialYear;

                   DB::table('bank_ledgers')->where('account_type', $request->account_type)->update($bankledger);
               } else {
                   $bankledger = new BankLedger;
                   $bankledger->supplier_name = $request->client_name;
                   $bankledger->payment_id = $request->receipt_id;
                   $bankledger->product_name = $request->product_name;
                   $bankledger->receipt_paid = intval($request->receive_amount);
                   $bankledger->receipt_due = 0;
                   $bankledger->cash = "";
                   $bankledger->bank = "Bank - " . $request->cash_bank_account;
                   $bankledger->date = $request->basic_date;
                   $bankledger->account_type = $request->account_type;
                   $checkFullPaid = DB::table('pay_receivables')->where('account_type',$request->account_type)->first();
                   if($checkFullPaid->second_due == 0){
                       $bankledger->payment_status = 1;

                   }else{
                       $bankledger->payment_status = 0;

                   }
                   $totalBankBalance = 0;
                   $bank_Ledgers = DB::table('bank_ledgers')->where('product_name', $request->product_name)->get();
                   if ($bank_Ledgers) {
                       foreach ($bank_Ledgers as $bank_Ledger) {
                           $totalBankBalance += intval($bank_Ledger->receipt_paid) + intval($bank_Ledger->receipt_due);
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
                   $cashledger['supplier_name'] = $request->client_name;
                   $cashledger['payment_id'] = $request->receipt_id;
                   $cashledger['product_name'] = $request->product_name;
                   $cashledger['receipt_paid'] = intval($request->receive_amount);
                   $cashledger['receipt_due'] = 0;
                   $cashledger['cash'] = "Cash";
                   $cashledger['bank'] = "";
                   $cashledger['date'] = $request->basic_date;

                   $checkFullPaid = DB::table('pay_receivables')->where('account_type',$request->account_type)->first();
                   if($checkFullPaid->second_due == 0){
                       $cashledger['payment_status'] = 1;

                   }else{
                       $cashledger['payment_status'] = 0;

                   }
                   $cashledger['financialYear'] = $request->financialYear;
                   DB::table('cash_ledgers')->where('account_type', $request->account_type)->update($cashledger);

               } else {
                   $cashledger = new CashLedger;
                   $cashledger->supplier_name = $request->client_name;
                   $cashledger->payment_id = $request->receipt_id;
                   $cashledger->product_name = $request->product_name;
                   $cashledger->receipt_paid = intval($request->receive_amount);
                   $cashledger->receipt_due = 0;
                   $cashledger->cash = "Cash";
                   $cashledger->bank = "";
                   $cashledger->date = $request->basic_date;
                   $cashledger->account_type = $request->account_type;
                   $totalCashBalance = 0;
                   $checkFullPaid = DB::table('pay_receivables')->where('account_type',$request->account_type)->first();
                   if($checkFullPaid->second_due == 0){
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




    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}

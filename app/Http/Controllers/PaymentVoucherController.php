<?php

namespace App\Http\Controllers;

use App\Models\ConsumeStock;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\PaymentVoucher;
use App\Models\Stock;
use App\Models\PaymentAccountInfo;
use Illuminate\Support\Facades\DB;
use App\Models\payable_journal;
use App\Models\purchased_journal;
use App\Models\PurchaseLedger;
use App\Models\Apledger;
use App\Models\CashLedger;
use App\Models\BankLedger;
use App\Models\StockJournal;
use App\Models\PaymentHistory;

class PaymentVoucherController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $getData = PaymentVoucher::all();

        return response()->json($getData);
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
        $paymentHistory->paid = intval($request->receive_amount);
        $paymentHistory->payment_id = $request->payment_id;
        $paymentHistory->project = $request->selectedProject;

        $paymentHistory->save();

        $voucher = new PaymentVoucher;
        $voucher->financialYear = $request->financialYear;
        $voucher->category_name = $request->category_name;
        $voucher->category_id = $request->category_id;
        $voucher->basic_date = $request->basic_date;
        $voucher->selectedPaymentType = $request->selectedPaymentType;
        $voucher->cash_bank_account = $request->cash_bank_account;
        $voucher->payee_name = $request->payee_name;
        $voucher->building_name= $request->building_name;
        if ($request->payee_tin != null) {
            $voucher->payee_tin = $request->payee_tin;
        } else {
            $voucher->payee_tin = "";
        }
        if ($request->payee_phone != null) {
            $voucher->payee_phone = $request->payee_phone;
        } else {
            $voucher->payee_phone = "";
        }
        if ($request->payee_email != null) {
            $voucher->payee_email = $request->payee_email;
        } else {
            $voucher->payee_email = "";
        }
        $voucher->product_name = $request->product_name;
        $voucher->bank_cheque_no = $request->bank_cheque_no;
        $voucher->bank_cheque_date = $request->bank_cheque_date;
        $voucher->bank_name = $request->bank_name;
        if ($request->bank_branch != null) {
            $voucher->bank_branch = $request->bank_branch;
        } else {
            $voucher->bank_branch = "";
        }
        $voucher->initial_qty = $request->qty;
        $voucher->total_amount = $request->total_amount;
        $voucher->initian_total_amount = $request->total_amount;
        $voucher->payment_id = $request->payment_id;

        if ($request->payment_details != null) {
            $voucher->payment_details = $request->payment_details;
        } else {
            $voucher->payment_details = "";
        }
        $voucher->qty = $request->qty;
        $voucher->per_unit_price = $request->per_unit_price;
        $voucher->receive_amount = $request->receive_amount;
        $voucher->payment_due = $request->payment_due;
        $voucher->selectedProject = $request->selectedProject;
        $voucher->item_id = $request->item_id;
        $voucher->item_unit = $request->item_unit;
        $voucher->account_type = $request->account_type;
        if ($request->ledger_no) {
            $voucher->ledger_no = $request->ledger_no;
        } else {
            $voucher->ledger_no = 0;
        }
        if ($request->hasFile("Supporting_docs")) {
            $file = $request->file('Supporting_docs');
            $filename = uniqid() . $file->getClientOriginalName();
            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory

            $voucher->Supporting_docs = 'documents/' . $filename;
        } else {
            $voucher->Supporting_docs = '';
        }

        $stock = new Stock;
        $stock->stock_date = $request->basic_date;
        $stock->payment_id = $request->payment_id;
        $stock->quantity = $request->qty;
        $stock->item_id = $request->item_id;
        $stock->item_unit = $request->item_unit;
        $stock->product_name = $request->product_name;
        $stock->project = $request->selectedProject;
        $stock->selectedBuilding = $request->building_name;

        $stock->save();
        $voucher->save();



        $purchased_journal = new purchased_journal;
        $purchased_journal->payment_id = $request->payment_id;
        $purchased_journal->purchase_type = "Debit";
        $purchased_journal->product_name = $request->product_name;
        $purchased_journal->total_amount = $request->total_amount;
        $purchased_journal->payee_name = $request->payee_name;
        $purchased_journal->payee_name_type = "Credit";
        $purchased_journal->due = $request->payment_due;
        $purchased_journal->building_name= $request->building_name;

        if ($request->selectedPaymentType == 'Cheque') {
            $purchased_journal->bank = $request->cash_bank_account;
            $purchased_journal->bank_type = "Credit";
            $purchased_journal->cash = null;
            $purchased_journal->cash_type = null;
        } else if ($request->selectedPaymentType == 'Cash') {
            $purchased_journal->cash = "Cash";
            $purchased_journal->cash_type = "Credit";
            $purchased_journal->bank = null;
            $purchased_journal->bank_type = null;

        }

        $purchased_journal->paid = $request->receive_amount;
        $purchased_journal->payable_date = $request->basic_date;
        $purchased_journal->financialYear = $request->financialYear;
        if ($request->selectedProject) {
            $purchased_journal->project = $request->selectedProject;
        } else {
            $purchased_journal->project = "";
        }


        $purchased_journal->save();
        if (intval($request->receive_amount) < intval($request->total_amount)) {
            $payable_journal = new payable_journal;
            $payable_journal->payment_id = $request->payment_id;
            $payable_journal->payee_name = $request->payee_name;
            $payable_journal->product_name = $request->product_name;
            $payable_journal->payee_name_type = "Debit";
            $payable_journal->due = $request->payment_due;
            if ($request->selectedPaymentType == 'Cheque') {
                $payable_journal->bank = $request->cash_bank_account;
                $payable_journal->bank_type = "Credit";
                $payable_journal->cash = null;
                $payable_journal->cash_type = null;
            } else if ($request->selectedPaymentType == 'Cash') {
                $payable_journal->cash = "Cash";
                $payable_journal->cash_type = "Credit";
                $payable_journal->bank = null;
                $payable_journal->bank_type = null;
            }
            $payable_journal->building_name= $request->building_name;

            $payable_journal->paid = $request->payment_due;
            $payable_journal->payable_date = $request->basic_date;
            $payable_journal->financialYear = $request->financialYear;
            if ($request->selectedProject) {
                $payable_journal->project = $request->selectedProject;
            } else {
                $payable_journal->project = "";
            }
            $payable_journal->save();

        }

        $purchase_ledger = new PurchaseLedger;
        $total_balance_init = 0;
        $getLedgers = DB::table('purchase_ledgers')->select('purchase_ledgers.*')->where('product_name', $request->product_name)->get();

        if ($getLedgers) {
            foreach ($getLedgers as $getLedger) {
                $total_balance_init += (intval($getLedger->balance) - intval($getLedger->return_amount));
            }
        }

        $purchase_ledger->supplier_name = $request->payee_name;
        $purchase_ledger->supplier_id = $request->payee_id;
        $purchase_ledger->payment_id = $request->payment_id;
        $purchase_ledger->product_name = $request->product_name;
        $purchase_ledger->paid = $request->receive_amount;
        $purchase_ledger->due = $request->payment_due;
        $purchase_ledger->financialYear = $request->financialYear;
        if ($request->selectedPaymentType == 'Cash') {
            $purchase_ledger->cash = "Cash";
            $purchase_ledger->bank = null;
        } else if ($request->selectedPaymentType == 'Cheque') {
            $purchase_ledger->cash = null;
            $purchase_ledger->bank = "Bank - " . $request->cash_bank_account;

        }
        $purchase_ledger->date = $request->basic_date;
        $purchase_ledger->balance = $request->total_amount;
        $purchase_ledger->return_amount = 0;
        $purchase_ledger->total_balance = $total_balance_init + intval($request->total_amount);
        $purchase_ledger->save();

        if (intval($request->payment_due) > 0) {
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
            $apledger->paid = 0;
            if ($request->selectedPaymentType == 'Cash') {
                $apledger->cash = "Cash";
                $apledger->bank = null;
            } else if ($request->selectedPaymentType == 'Cheque') {
                $apledger->cash = null;
                $apledger->bank = "Bank - " . $request->cash_bank_account;

            }
            $apledger->financialYear = $request->financialYear;
            $apledger->due = -intval($request->payment_due);
            $apledger->date = $request->basic_date;
            $apledger->account_type = $request->account_type;
            $apledger->return_amount = 0;
            $apledger->balance = $total_balance_init - intval($request->payment_due);
            $apledger->save();
        }
        if (intval($request->receive_amount) != 0) {


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
                $bankledger->financialYear = $request->financialYear;
                $totalBankBalance = 0;
                $bank_Ledgers = DB::table('bank_ledgers')->where('product_name', $request->product_name)->get();
                if ($bank_Ledgers) {
                    foreach ($bank_Ledgers as $bank_Ledger) {
                        $totalBankBalance += intval($bank_Ledger->paid) + intval($bank_Ledger->due);
                    }
                }
                $bankledger->balance = $totalBankBalance - intval($request->receive_amount);
                if (intval($request->payment_due) > 0) {
                    $bankledger->payment_status = 0;
                } else if (intval($request->payment_due == 0)) {
                    $bankledger->payment_status = 1;
                }
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
                $cashledger->financialYear = $request->financialYear;
                $totalCashBalance = 0;
                $cash_Ledgers = DB::table('cash_ledgers')->where('product_name', $request->product_name)->get();
                if ($cash_Ledgers) {
                    foreach ($cash_Ledgers as $cash_Ledger) {
                        $totalCashBalance += intval($cash_Ledger->paid) + intval($cash_Ledger->due);
                    }
                }
                $cashledger->balance = $totalCashBalance - intval($request->receive_amount);
                if (intval($request->payment_due) > 0) {
                    $cashledger->payment_status = 0;
                } else if (intval($request->payment_due == 0)) {
                    $cashledger->payment_status = 1;
                }
                $cashledger->save();

            }
        }


        //stock journal
        // $item_id = DB::table('stocks')->whereRaw('lower(product_name) !=? ', 'land')->first();
        // if ($item_id) {
        //     $sj_index = DB::table('stock_journals')->whereRaw('lower(product_name) != ?', 'land')->where('product_id', $item_id->item_id)->first();
        //     if (strtolower($request->product_name) != 'land') {
        //         if ($sj_index) {
        //             $updated_qty = intval($sj_index->total_quantity) + intval($request->qty);
        //             DB::table('stock_journals')->where('product_id', $item_id->item_id)->update(['total_quantity' => $updated_qty]);
        //             return response()->json(['sj_index'=>$sj_index]);
        //         } else {
        //             $stock_journal = new StockJournal;
        //             $stock_journal->product_name = $request->product_name;
        //             $stock_journal->total_quantity = $request->qty;
        //             $stock_journal->product_id = $item_id->item_id;
        //             $stock_journal->save();
        //             return response()->json(['sj_index_new_entry'=>$stock_journal]);

        //         }
        //     }
        // }
        // if (strtolower($request->product_name) != 'land') {
        //     $sj_index = DB::table('stock_journals')->where('product_name', $request->product_name)->first();
        //     if ($sj_index) {
        //         $updated_qty = intval($sj_index->total_quantity) + intval($request->qty);
        //         DB::table('stock_journals')->where('product_name', $request->product_name)->update(['total_quantity' => $updated_qty]);
        //         return response()->json(['sj_index' => $sj_index]);
        //     } else {
        //         $item_id = DB::table('stocks')->where('product_name',$request->product_name)->first();
        //         $stock_journal = new StockJournal;
        //         $stock_journal->product_name = $request->product_name;
        //         $stock_journal->total_quantity = $request->qty;
        //         $stock_journal->product_id = $item_id->item_id;
        //         $stock_journal->save();
        //         return response()->json(['sj_index_new_entry' => $stock_journal]);

        //     }
        // }

        //endd

        // return response()->json(['vocuher' => $voucher, 'stock' => $stock]);

    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $index = PaymentVoucher::find($id);

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
    public function paymentUpdate(Request $request)
    {
        $voucher = PaymentVoucher::find($request->id);
        $voucher->financialYear = $request->financialYear;
        $voucher->building_name= $request->building_name;

        $voucher->basic_date = $request->basic_date;
        $voucher->selectedPaymentType = $request->selectedPaymentType;
        $voucher->cash_bank_account = $request->cash_bank_account;
        $voucher->payee_name = $request->payee_name;
        if ($request->payee_tin != null) {
            $voucher->payee_tin = $request->payee_tin;
        } else {
            $voucher->payee_tin = "";
        }
        if ($request->payee_phone != null) {
            $voucher->payee_phone = $request->payee_phone;
        } else {
            $voucher->payee_phone = "";
        }
        if ($request->payee_email != null) {
            $voucher->payee_email = $request->payee_email;
        } else {
            $voucher->payee_email = "";
        }
        $voucher->product_name = $request->product_name;
        $voucher->bank_cheque_no = $request->bank_cheque_no;
        $voucher->bank_cheque_date = $request->bank_cheque_date;
        $voucher->bank_name = $request->bank_name;
        if ($request->bank_branch != null) {
            $voucher->bank_branch = $request->bank_branch;
        } else {
            $voucher->bank_branch = "";
        }
        $voucher->total_amount = $request->total_amount;
        $voucher->payment_id = $request->payment_id;

        if ($request->payment_details != null) {
            $voucher->payment_details = $request->payment_details;
        } else {
            $voucher->payment_details = "";
        }
        if ($request->ledger_no) {
            $voucher->ledger_no = $request->ledger_no;
        } else {
            $voucher->ledger_no = 0;
        }
        $voucher->category_name = $request->category_name;
        $voucher->category_id = $request->category_id;
        $voucher->qty = $request->qty;
        $voucher->per_unit_price = $request->per_unit_price;
        $voucher->receive_amount = $request->receive_amount;
        $voucher->payment_due = $request->payment_due;
        $voucher->selectedProject = $request->selectedProject;
        $voucher->item_id = $request->item_id;
        $voucher->item_unit = $request->item_unit;

        if ($request->hasFile("Supporting_docs")) {
            $file = $request->file('Supporting_docs');
            $filename = uniqid() . $file->getClientOriginalName();
            // $path = $file->storeAs('AdminPanel/Documents/',$filename);
            //test


            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory


            //
            $database_doc = DB::table('payment_vouchers')->where('id', $request->id)->first();
            if ($database_doc->Supporting_docs != "") {
                $old_doc = public_path($voucher->Supporting_docs);

                unlink($old_doc);
                $voucher->Supporting_docs = 'documents/' . $filename;
            } else if ($database_doc->Supporting_docs === "") {

                $voucher->Supporting_docs = 'documents/' . $filename;
            }

        } else {
            $database_doc = DB::table('payment_vouchers')->where('id', $request->id)->first();
            $voucher->Supporting_docs = $database_doc->Supporting_docs;
        }


        $stock = array();
        $stock['payment_id'] = $request->payment_id;
        $stock['stock_date'] = $request->basic_date;
        $stock['quantity'] = $request->qty;
        $stock['project'] = $request->selectedProject;
        $stock['item_id'] = $request->item_id;
        $stock['item_unit'] = $request->item_unit;
        $stock['product_name'] = $request->product_name;
        $stock['selectedBuilding'] = $request->building_name;
        DB::table('stocks')->where('payment_id', $request->payment_id)->update($stock);
        $voucher->save();



        //payment_voucher update based on pay payable --perfect
        $updatePayable = array();
        $updatePayable['payment_due'] = intval($request->payment_due);
        $getPay_Payable = DB::table('pay_payables')->where('payment_id', $request->payment_id)->first();
        if ($getPay_Payable) {
            $updatePayable['payment_due'] = intval($request->payment_due);

            $updatePayable['second_payment_due'] = intval($request->payment_due) - intval($getPay_Payable->receive_amount);

            DB::table('pay_payables')->where('account_type', $getPay_Payable->account_type)->update($updatePayable);

        }

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

        $pmntVoucher['receive_amount'] = intval($totalPayablePaid) + intval($getPaymentVoucher->receive_amount);
        $pmntVoucher['payment_due'] = intval($getPaymentVoucher->payment_due) - intval($totalPayablePaid);
        DB::table('payment_vouchers')->where('payment_id', $request->payment_id)->update($pmntVoucher);

        //purchased_journal
        $purchased_journal = array();
        $purchased_journal['payment_id'] = $request->payment_id;
        $purchased_journal['purchase_type'] = "Debit";
        $purchased_journal['product_name'] = $request->product_name;
        $purchased_journal['total_amount'] = $request->total_amount;
        $purchased_journal['payee_name'] = $request->payee_name;
        $purchased_journal['payee_name_type'] = "Credit";
        $purchased_journal['building_name'] = $request->building_name;


        if ($request->selectedPaymentType == 'Cheque') {
            $purchased_journal['bank'] = $request->cash_bank_account;
            $purchased_journal['bank_type'] = "Credit";
            $purchased_journal['cash'] = null;
            $purchased_journal['cash_type'] = null;
        } else if ($request->selectedPaymentType == 'Cash') {
            $purchased_journal['cash'] = "Cash";
            $purchased_journal['cash_type'] = "Credit";
            $purchased_journal['bank'] = null;
            $purchased_journal['bank_type'] = null;

        }

        $purchased_journal['payable_date'] = $request->basic_date;
        $purchased_journal['financialYear'] = $request->financialYear;

        if ($request->selectedProject) {
            $purchased_journal['project'] = $request->selectedProject;
        } else {
            $purchased_journal['project'] = "";
        }


        $prchsdJournalPaid = 0;
        $prchsdJournalDue = 0;
        $PayPayable = DB::table('pay_payables')->where('payment_id', $request->payment_id)->get();
        if ($PayPayable) {
            foreach ($PayPayable as $pp) {
                $prchsdJournalPaid += $pp->receive_amount;
                $prchsdJournalDue -= $pp->receive_amount;
            }
        }
        $purchased_journal['paid'] = $prchsdJournalPaid + $request->receive_amount;
        $purchased_journal['due'] = $prchsdJournalDue + $request->payment_due;
        DB::table('purchased_journals')->where('payment_id', $request->payment_id)->update($purchased_journal);
        //update purchase_journals
        $updateAllNamePurchaseJournal = DB::table('purchased_journals')->where('payment_id', $request->payment_id)->get();
        if ($updateAllNamePurchaseJournal) {

            foreach ($updateAllNamePurchaseJournal as $ula) {

                DB::table('purchased_journals')->where('payment_id', $ula->payment_id)->update(['payee_name' => $request->payee_name, 'product_name' => $request->product_name]);
            }
        }


        //update
        $getPJ = DB::table('payable_journals')->where('payment_id', $request->payment_id)->first();
        if ($getPJ) {
            $payable_journal = array();
            $payable_journal['payment_id'] = $request->payment_id;
            $payable_journal['payee_name'] = $request->payee_name;
            $payable_journal['product_name'] = $request->product_name;
            $payable_journal['payee_name_type'] = "Debit";
            $payable_journal['building_name'] = $request->building_name;

            $payable_journal['due'] = $request->payment_due;
            if ($request->selectedPaymentType == 'Cheque') {
                $payable_journal['bank'] = $request->cash_bank_account;
                $payable_journal['bank_type'] = "Credit";
                $payable_journal['cash'] = null;
                $payable_journal['cash_type'] = null;
            } else if ($request->selectedPaymentType == 'Cash') {
                $payable_journal['cash'] = "Cash";
                $payable_journal['cash_type'] = "Credit";
                $payable_journal['bank'] = null;
                $payable_journal['bank_type'] = null;

            }
            $payable_journal['paid'] = $request->payment_due;
            $payable_journal['payable_date'] = $request->basic_date;
            $payable_journal['financialYear'] = $request->financialYear;

            if ($request->selectedProject) {
                $payable_journal['project'] = $request->selectedProject;
            } else {
                $payable_journal['project'] = "";
            }
            DB::table('payable_journals')->where('payment_id', $request->payment_id)->update($payable_journal);


            if (intval($request->payment_due) == 0) {
                DB::table('payable_journals')->where('payment_id', $request->payment_id)->delete();
            }

        } else {
            $payable_journal = new payable_journal;
            $payable_journal->payment_id = $request->payment_id;
            $payable_journal->payee_name = $request->payee_name;
            $payable_journal->product_name = $request->product_name;
            $payable_journal->payee_name_type = "Debit";
            $payable_journal->due = $request->payment_due;
            $payable_journal->building_name = $request->building_name;

            if ($request->selectedPaymentType == 'Cheque') {
                $payable_journal->bank = $request->cash_bank_account;
                $payable_journal->bank_type = "Credit";
                $payable_journal->cash = null;
                $payable_journal->cash_type = null;
            } else if ($request->selectedPaymentType == 'Cash') {
                $payable_journal->cash = "Cash";
                $payable_journal->cash_type = "Credit";
                $payable_journal->bank = null;
                $payable_journal->bank_type = null;
            }
            $payable_journal->paid = $request->payment_due;
            $payable_journal->payable_date = $request->basic_date;
            $payable_journal->financialYear = $request->financialYear;
            $payable_journal->project = $request->selectedProject;
            $payable_journal->save();
        }

        $pbljournal = array();
        $totalPayablePaid2 = 0;
        $totalPayablePaid3 = 0;

        $getPayable2 = DB::table('pay_payables')->where('payment_id', $request->payment_id)->get();
        if ($getPayable2) {
            foreach ($getPayable2 as $gpv) {
                $totalPayablePaid2 += intval($gpv->receive_amount);
            }
        }
        $getPayableJournal = DB::table('payable_journals')->where('payment_id', $request->payment_id)->get();
        foreach ($getPayableJournal as $gp) {
            $totalPayablePaid3 = intval($gp->due) - intval($totalPayablePaid2);
            $pbljournal['due'] = $totalPayablePaid3;
            $pbljournal['paid'] = $totalPayablePaid3;

            DB::table('payable_journals')->where('payment_id', $request->payment_id)->update($pbljournal);


        }


        //purchase ledger
        $purchase_ledger = array();
        $purchase_ledger['supplier_name'] = $request->payee_name;
        $purchase_ledger['supplier_id'] = $request->payee_id;
        $purchase_ledger['payment_id'] = $request->payment_id;
        $purchase_ledger['product_name'] = $request->product_name;
        $purchase_ledger['paid'] = intval($request->receive_amount);
        $purchase_ledger['due'] = intval($request->payment_due);
        $purchase_ledger['date'] = $request->basic_date;
        $purchase_ledger['balance'] = intval($request->total_amount);
        $purchase_ledger['financialYear'] = $request->financialYear;

        if ($request->selectedPaymentType == 'Cash') {
            $purchase_ledger['cash'] = "Cash";
            $purchase_ledger['bank'] = null;
        } else if ($request->selectedPaymentType == 'Cheque') {
            $purchase_ledger['cash'] = null;
            $purchase_ledger['bank'] = "Bank - " . $request->cash_bank_account;

        }
        DB::table('purchase_ledgers')->where('payment_id', $request->payment_id)->update($purchase_ledger);


        $currentPurchaseBalance = 0;
        $getCurrentPurchase = DB::table('purchase_ledgers')->select('purchase_ledgers.*')->where('product_name', $request->product_name)->get();
        foreach ($getCurrentPurchase as $gcp) {
            $currentPurchaseBalance += intval($gcp->balance);
            DB::table('purchase_ledgers')->where('payment_id', $gcp->payment_id)->update(["total_balance" => $currentPurchaseBalance]);
        }
        $oldPurchaseBalance = 0;
        $getOldPurchase = DB::table('purchase_ledgers')->select('purchase_ledgers.*')->where('product_name', $request->old_product)->get();
        foreach ($getOldPurchase as $gcp) {
            $oldPurchaseBalance += intval($gcp->balance) - intval($gcp->return_amount);
            DB::table('purchase_ledgers')->where('payment_id', $gcp->payment_id)->update(["total_balance" => $oldPurchaseBalance]);
        }

        if (intval($request->receive_amount) == intval($request->total_amount)) {
            $findApLedgers = DB::table('apledgers')->where('payment_id', $request->payment_id)->get();
            if ($findApLedgers) {
                foreach ($findApLedgers as $gsp) {
                    DB::table('apledgers')->where('payment_id', $gsp->payment_id)->update(['supplier_name' => $request->payee_name, 'product_name' => $request->product_name]);
                }
            }

            DB::table('payable_journals')->where('payment_id', $request->payment_id)->delete();

        } else if (intval($request->receive_amount) < intval($request->total_amount)) {
            $findApLedger = DB::table('apledgers')->where('payment_id', $request->payment_id)->first();
            $findApLedgers = DB::table('apledgers')->where('payment_id', $request->payment_id)->get();
            if ($findApLedgers) {
                foreach ($findApLedgers as $gsp) {
                    DB::table('apledgers')->where('payment_id', $gsp->payment_id)->update(['supplier_name' => $request->payee_name, 'product_name' => $request->product_name]);
                }
            }
            if (!$findApLedger) {
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
                $apledger->paid = 0;
                $apledger->account_type = rand(11111111, 99999999);
                $apledger->due = -intval($request->payment_due);
                $apledger->date = $request->basic_date;
                $apledger->financialYear = $request->financialYear;
                $apledger->return_amount = 0;
                $apledger->balance = $total_balance_init - intval($request->payment_due);
                $apledger->save();
            } else if ($findApLedger) {

                $apledger = array();
                $apledger['supplier_name'] = $request->payee_name;
                $apledger['due'] = -intval($request->payment_due);
                $apledger['date'] = $request->basic_date;
                $apledger['product_name'] = $request->product_name;
                if ($request->selectedPaymentType == 'Cash') {
                    $apledger['cash'] = "Cash";
                    $apledger['bank'] = null;
                } else if ($request->selectedPaymentType == 'Cheque') {
                    $apledger['cash'] = null;
                    $apledger['bank'] = "Bank - " . $request->cash_bank_account;

                }
                $apledger['financialYear'] = $request->financialYear;

                $firstRow = Apledger::where('payment_id', $request->payment_id)->first();
                if ($firstRow) {
                    $firstRow->update($apledger);
                }
                $getSamePayment = DB::table('apledgers')->select('apledgers.*')->where('payment_id', $request->payment_id)->get();
                if ($getSamePayment) {
                    foreach ($getSamePayment as $gsp) {
                        DB::table('apledgers')->where('payment_id', $gsp->payment_id)->update(['supplier_name' => $request->payee_name, 'product_name' => $request->product_name]);
                    }
                }
                $currentProductBalance = 0;
                $getCurrentProducts = DB::table('apledgers')->select('apledgers.*')->where('product_name', $request->product_name)->get();
                if ($getCurrentProducts) {
                    foreach ($getCurrentProducts as $getCurrentProduct) {
                        //for current change - no need to change for old one

                        $currentProductBalance += intval($getCurrentProduct->due) + intval($getCurrentProduct->paid) + intval($getCurrentProduct->return_amount);

                        DB::table('apledgers')->where('id', $getCurrentProduct->id)->update(['balance' => $currentProductBalance]);
                    }
                }
                $oldProductBalance = 0;
                $getOldProducts = DB::table('apledgers')->select('apledgers.*')->where('product_name', $request->old_product)->get();
                if ($getOldProducts) {
                    foreach ($getOldProducts as $getOldProduct) {
                        $oldProductBalance += $getOldProduct->due + intval($getOldProduct->paid) + intval($getOldProduct->return_amount);
                        DB::table('apledgers')->where('id', $getOldProduct->id)->update(['balance' => $oldProductBalance]);
                    }
                }

            }
        }

        if (intval($request->receive_amount) > 0) {
            if ($request->selectedPaymentType == 'Cheque') {
                $hasBankPI = DB::table('bank_ledgers')->where('account_type', $request->account_type)->first();
                if ($hasBankPI) {
                    //update all bank names
                    $updateAllName = DB::table('bank_ledgers')->where('payment_id', $request->payment_id)->get();
                    if ($updateAllName) {
                        foreach ($updateAllName as $ula) {
                            DB::table('bank_ledgers')->where('payment_id', $request->payment_id)->update(['supplier_name' => $request->payee_name, 'product_name' => $request->product_name]);
                        }
                    }

                    //update all cash names
                    $updateAllName2 = DB::table('cash_ledgers')->where('payment_id', $request->payment_id)->get();
                    if ($updateAllName2) {
                        foreach ($updateAllName2 as $ula) {
                            DB::table('cash_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->payee_name, 'product_name' => $request->product_name]);
                        }
                    }

                    //update bank
                    $bankledger = array();
                    $bankledger['supplier_name'] = $request->payee_name;
                    $bankledger['payment_id'] = $request->payment_id;
                    $bankledger['product_name'] = $request->product_name;
                    $bankledger['paid'] = -intval($request->receive_amount);
                    $bankledger['due'] = 0;
                    $bankledger['cash'] = "";
                    $bankledger['bank'] = "Bank-" . $request->cash_bank_account;
                    $bankledger['date'] = $request->basic_date;
                    $bankledger['financialYear'] = $request->financialYear;
                    if ($request->payment_due == 0) {
                        $bankledger['payment_status'] = 1;
                    }
                    DB::table('bank_ledgers')->where('account_type', $request->account_type)->update($bankledger);


                    //update bank total based on old and current product
                    $calculateBankTotals = DB::table('bank_ledgers')->where('product_name', $request->product_name)->get();
                    $calculateBankTotalBalance = 0;
                    if ($calculateBankTotals) {
                        foreach ($calculateBankTotals as $cbt) {
                            $calculateBankTotalBalance += intval($cbt->paid) + intval($cbt->due);
                            DB::table('bank_ledgers')->where('id', $cbt->id)->update(['balance' => $calculateBankTotalBalance]);
                        }
                    }

                    $calculateBankTotalsOld = DB::table('bank_ledgers')->where('product_name', $request->old_product)->get();
                    $calculateBankTotalBalance = 0;
                    if ($calculateBankTotalsOld) {
                        foreach ($calculateBankTotalsOld as $cbt) {
                            $calculateBankTotalBalance += intval($cbt->paid) + intval($cbt->due);
                            DB::table('bank_ledgers')->where('id', $cbt->id)->update(['balance' => $calculateBankTotalBalance]);
                        }
                    }

                    //update cash total based on old and current product
                    $calculateCashTotals = DB::table('cash_ledgers')->where('product_name', $request->product_name)->get();
                    $calculateCashTotalBalance = 0;
                    if ($calculateCashTotals) {
                        foreach ($calculateCashTotals as $cbt) {
                            $calculateCashTotalBalance += intval($cbt->paid) + intval($cbt->due);
                            DB::table('cash_ledgers')->where('id', $cbt->id)->update(['balance' => $calculateCashTotalBalance]);
                        }
                    }

                    $calculateCashTotalsOld = DB::table('cash_ledgers')->where('product_name', $request->old_product)->get();
                    $calculateCashTotalBalance = 0;
                    if ($calculateCashTotalsOld) {
                        foreach ($calculateCashTotalsOld as $cbt) {
                            $calculateCashTotalBalance += intval($cbt->paid) + intval($cbt->due);
                            DB::table('cash_ledgers')->where('id', $cbt->id)->update(['balance' => $calculateCashTotalBalance]);
                        }
                    }

                    //end if of bank pi
                } else {
                    //delete from cash
                    DB::table('cash_ledgers')->where('account_type', $request->account_type)->delete();


                    //before create bank data entry update supplier_name,product_name etc.

                    $updateAllName = DB::table('bank_ledgers')->where('payment_id', $request->payment_id)->get();
                    if ($updateAllName) {

                        foreach ($updateAllName as $ula) {

                            DB::table('bank_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->payee_name, 'product_name' => $request->product_name]);
                        }
                    }
                    $updateAllName2 = DB::table('cash_ledgers')->where('payment_id', $request->payment_id)->get();
                    if ($updateAllName2) {

                        foreach ($updateAllName2 as $ula) {

                            DB::table('cash_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->payee_name, 'product_name' => $request->product_name]);
                        }
                    }
                    //create bank
                    $bankledger = new BankLedger;
                    $bankledger->supplier_name = $request->payee_name;
                    $bankledger->payment_id = $request->payment_id;
                    $bankledger->product_name = $request->product_name;
                    $bankledger->paid = -intval($request->receive_amount);
                    $bankledger->due = 0;
                    $bankledger->cash = "";
                    $bankledger->bank = "Bank-" . $request->cash_bank_account;
                    $bankledger->date = $request->basic_date;
                    $bankledger->account_type = $request->account_type;
                    $bankledger->financialYear = $request->financialYear;
                    if (intval($request->payment_due) > 0) {
                        $bankledger->payment_status = 0;
                    } else if (intval($request->payment_due == 0)) {
                        $bankledger->payment_status = 1;
                    }
                    $bankledger->save();
                    //j nam notun hoise r jeta theika hoise both refresh inside table
                    $currentProductBase = DB::table('bank_ledgers')->where('product_name', $request->product_name)->get();
                    $currentProductBalance = 0;
                    if ($currentProductBase) {
                        foreach ($currentProductBase as $cpb) {
                            $currentProductBalance += intval($cpb->paid) + intval($cpb->due);
                            DB::table('bank_ledgers')->where('id', $cpb->id)->update(['balance' => $currentProductBalance]);
                        }
                    }

                    $calculateBankTotalsOld1 = DB::table('bank_ledgers')->where('product_name', $request->old_product)->get();
                    $calculateBankTotalBalance1 = 0;
                    if ($calculateBankTotalsOld1) {
                        foreach ($calculateBankTotalsOld1 as $cbt) {
                            $calculateBankTotalBalance1 += intval($cbt->paid) + intval($cbt->due);
                            DB::table('bank_ledgers')->where('id', $cbt->id)->update(['balance' => $calculateBankTotalBalance1]);
                        }
                    }

                    //update cash total based on old and current product
                    $calculateCashTotals = DB::table('cash_ledgers')->where('product_name', $request->product_name)->get();
                    $calculateCashTotalBalance = 0;
                    if ($calculateCashTotals) {
                        foreach ($calculateCashTotals as $cbt) {
                            $calculateCashTotalBalance += intval($cbt->paid) + intval($cbt->due);
                            DB::table('cash_ledgers')->where('id', $cbt->id)->update(['balance' => $calculateCashTotalBalance]);
                        }
                    }

                    $calculateCashTotalsOld = DB::table('cash_ledgers')->where('product_name', $request->old_product)->get();
                    $calculateCashTotalBalance = 0;
                    if ($calculateCashTotalsOld) {
                        foreach ($calculateCashTotalsOld as $cbt) {
                            $calculateCashTotalBalance += intval($cbt->paid) + intval($cbt->due);
                            DB::table('cash_ledgers')->where('id', $cbt->id)->update(['balance' => $calculateCashTotalBalance]);
                        }
                    }


                    //emd else
                }

            } else if ($request->selectedPaymentType == "Cash") {
                $hasCashPI = DB::table('cash_ledgers')->where('account_type', $request->account_type)->first();
                if ($hasCashPI) {
                    //update all cash names
                    $updateAllName = DB::table('cash_ledgers')->where('payment_id', $request->payment_id)->get();
                    if ($updateAllName) {
                        foreach ($updateAllName as $ula) {
                            DB::table('cash_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->payee_name, 'product_name' => $request->product_name]);
                        }
                    }
                    //update all bank names
                    $updateAllName2 = DB::table('bank_ledgers')->where('payment_id', $request->payment_id)->get();
                    if ($updateAllName2) {
                        foreach ($updateAllName2 as $ula) {
                            DB::table('bank_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->payee_name, 'product_name' => $request->product_name]);
                        }
                    }


                    //update cash
                    $cashledger = array();
                    $cashledger['supplier_name'] = $request->payee_name;
                    $cashledger['payment_id'] = $request->payment_id;
                    $cashledger['product_name'] = $request->product_name;
                    $cashledger['paid'] = -intval($request->receive_amount);
                    $cashledger['due'] = 0;
                    $cashledger['cash'] = "Cash";
                    $cashledger['bank'] = "";
                    $cashledger['date'] = $request->basic_date;
                    $cashledger['financialYear'] = $request->financialYear;
                    if ($request->payment_due == 0) {
                        $cashledger['payment_status'] = 1;
                    }
                    DB::table('cash_ledgers')->where('account_type', $request->account_type)->update($cashledger);

                    //update cash total based on old and current product
                    $calculateCashTotals = DB::table('cash_ledgers')->where('product_name', $request->product_name)->get();
                    $calculateCashTotalBalance = 0;
                    if ($calculateCashTotals) {
                        foreach ($calculateCashTotals as $cbt) {
                            $calculateCashTotalBalance += intval($cbt->paid) + intval($cbt->due);
                            DB::table('cash_ledgers')->where('id', $cbt->id)->update(['balance' => $calculateCashTotalBalance]);
                        }
                    }

                    $calculateCashTotalsOld = DB::table('cash_ledgers')->where('product_name', $request->old_product)->get();
                    $calculateCashTotalBalance = 0;
                    if ($calculateCashTotalsOld) {
                        foreach ($calculateCashTotalsOld as $cbt) {
                            $calculateCashTotalBalance += intval($cbt->paid) + intval($cbt->due);
                            DB::table('cash_ledgers')->where('id', $cbt->id)->update(['balance' => $calculateCashTotalBalance]);
                        }
                    }
                    //j nam notun hoise r jeta theika hoise both refresh inside table
                    $currentProductBase = DB::table('bank_ledgers')->where('product_name', $request->product_name)->get();
                    $currentProductBalance = 0;
                    if ($currentProductBase) {
                        foreach ($currentProductBase as $cpb) {
                            $currentProductBalance += intval($cpb->paid) + intval($cpb->due);
                            DB::table('bank_ledgers')->where('id', $cpb->id)->update(['balance' => $currentProductBalance]);
                        }
                    }

                    $calculateBankTotalsOld1 = DB::table('bank_ledgers')->where('product_name', $request->old_product)->get();
                    $calculateBankTotalBalance1 = 0;
                    if ($calculateBankTotalsOld1) {
                        foreach ($calculateBankTotalsOld1 as $cbt) {
                            $calculateBankTotalBalance1 += intval($cbt->paid) + intval($cbt->due);
                            DB::table('bank_ledgers')->where('id', $cbt->id)->update(['balance' => $calculateBankTotalBalance1]);
                        }
                    }


                    //end
                } else {
                    //delete from bank
                    DB::table('bank_ledgers')->where('account_type', $request->account_type)->delete();

                    //before create cash data entry update supplier_name, product_name etc.

                    $updateAllName = DB::table('cash_ledgers')->where('payment_id', $request->payment_id)->get();
                    if ($updateAllName) {

                        foreach ($updateAllName as $ula) {

                            DB::table('cash_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->payee_name, 'product_name' => $request->product_name]);
                        }
                    }

                    $updateAllName2 = DB::table('bank_ledgers')->where('payment_id', $request->payment_id)->get();
                    if ($updateAllName2) {

                        foreach ($updateAllName2 as $ula) {

                            DB::table('bank_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->payee_name, 'product_name' => $request->product_name]);
                        }
                    }
                    //create cash
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
                    $cashledger->financialYear = $request->financialYear;
                    if (intval($request->payment_due) > 0) {
                        $cashledger->payment_status = 0;
                    } else if (intval($request->payment_due == 0)) {
                        $cashledger->payment_status = 1;
                    }
                    $cashledger->save();

                    $currentProductBase = DB::table('cash_ledgers')->where('product_name', $request->product_name)->get();
                    $currentProductBalance = 0;
                    if ($currentProductBase) {
                        foreach ($currentProductBase as $cpb) {
                            $currentProductBalance += intval($cpb->paid) + intval($cpb->due);
                            DB::table('cash_ledgers')->where('id', $cpb->id)->update(['balance' => $currentProductBalance]);
                        }
                    }

                    $OldcurrentProductBase = DB::table('cash_ledgers')->where('product_name', $request->old_product)->get();
                    $OldcurrentProductBalance = 0;
                    if ($OldcurrentProductBase) {
                        foreach ($OldcurrentProductBase as $cpb) {
                            $OldcurrentProductBalance += intval($cpb->paid) + intval($cpb->due);
                            DB::table('cash_ledgers')->where('id', $cpb->id)->update(['balance' => $OldcurrentProductBalance]);
                        }
                    }


                    //j nam notun hoise r jeta theika hoise both refresh inside table
                    $currentProductBase = DB::table('bank_ledgers')->where('product_name', $request->product_name)->get();
                    $currentProductBalance = 0;
                    if ($currentProductBase) {
                        foreach ($currentProductBase as $cpb) {
                            $currentProductBalance += intval($cpb->paid) + intval($cpb->due);
                            DB::table('bank_ledgers')->where('id', $cpb->id)->update(['balance' => $currentProductBalance]);
                        }
                    }

                    $calculateBankTotalsOld1 = DB::table('bank_ledgers')->where('product_name', $request->old_product)->get();
                    $calculateBankTotalBalance1 = 0;
                    if ($calculateBankTotalsOld1) {
                        foreach ($calculateBankTotalsOld1 as $cbt) {
                            $calculateBankTotalBalance1 += intval($cbt->paid) + intval($cbt->due);
                            DB::table('bank_ledgers')->where('id', $cbt->id)->update(['balance' => $calculateBankTotalBalance1]);
                        }
                    }

                }
            }
        }

        if (intval($request->receive_amount) == 0) {

            if ($request->selectedPaymentType == 'Cheque') {
                DB::table('bank_ledgers')->where('account_type', $request->account_type)->delete();
            } else if ($request->selectedPaymentType == "Cash") {
                DB::table('cash_ledgers')->where('account_type', $request->account_type)->delete();
            }
        }

        //update pay payable
        //update pay receivable
        $receiptPayable = array();
        // $receiptPayable =  receiptPayable::find($request->receipt_id);
        $receiptPayable['payment_id'] = $request->payment_id;
        $receiptPayable['product_name'] = $request->product_name;
        $receiptPayable['supplier_name'] = $request->payee_name;
        $receiptPayable['basic_date'] = $request->basic_date;
        $receiptPayable['financialYear'] = $request->financialYear;

        DB::table('pay_payables')->where('payment_id', $request->payment_id)->update($receiptPayable);



        //stock journal
        // $item_id = DB::table('stocks')->whereRaw('lower(product_name) !=? ', 'land')->first();
        // if ($item_id) {
        //     $sj_index = DB::table('stock_journals')->whereRaw('lower(product_name) != ?', 'land')->where('product_name', $request->product_name)->first();
        //     if (strtolower($request->product_name) != 'land') {
        //         if ($sj_index) {
        //             $old_product = DB::table('stock_journals')->where('product_name', $request->old_product_name)->first();
        //           if($old_product){
        //             $update_old_product = intval($old_product->total_quantity) - intval($request->old_qty);
        //             if (intval($update_old_product) == 0 || intval($update_old_product)<0) {
        //                 DB::table('stock_journals')->where('product_name', $request->old_product_name)->delete();
        //             } else {
        //                 DB::table('stock_journals')->where('product_name', $request->old_product_name)->update(['total_quantity' => $update_old_product]);
        //             }
        //           }
        //             $get_current_product = DB::table('stock_journals')->where('product_name', $request->product_name)->first();
        //             $get_current_product_id_from_stock = DB::table('stocks')->where('product_name', $request->product_name)->first();
        //             if ($get_current_product) {
        //                 $updated_qty = intval($get_current_product->total_quantity) + intval($request->qty);
        //                 DB::table('stock_journals')->where('product_name', $request->product_name)->update(['total_quantity' => $updated_qty]);

        //             } else {
        //                 $stock_journal = new StockJournal;
        //                 $stock_journal->product_name = $request->product_name;
        //                 $stock_journal->total_quantity = $request->qty;
        //                 $stock_journal->product_id = $get_current_product_id_from_stock->item_id;
        //                 $stock_journal->save();
        //             }
        //         } else {
        //             $old_product = DB::table('stock_journals')->where('product_name', $request->old_product_name)->first();
        //             if ($old_product) {
        //                 $update_old_product = intval($old_product->total_quantity) - intval($request->old_qty);
        //                 if (intval($update_old_product) == 0) {
        //                     DB::table('stock_journals')->where('product_name', $request->old_product_name)->delete();
        //                 } else {
        //                     DB::table('stock_journals')->where('product_name', $request->old_product_name)->update(['total_quantity' => $update_old_product]);
        //                 }
        //             }
        //             $get_current_product_id_from_stock = DB::table('stocks')->where('product_name', $request->product_name)->first();

        //             $stock_journal = new StockJournal;
        //             $stock_journal->product_name = $request->product_name;
        //             $stock_journal->total_quantity = $request->qty;
        //             $stock_journal->product_id = $get_current_product_id_from_stock->item_id;
        //             $stock_journal->save();
        //         }


        //         $requisition = DB::table('stock_journals')->pluck('product_name');
        //         ConsumeStock::whereNotIn('product_name',$requisition)->delete();
        //     }
        // }
        // if (strtolower($request->product_name) == 'land') {
        //     if (strtolower($request->old_product_name) != 'land') {
        //         $old_product = DB::table('stock_journals')->where('product_name', $request->old_product_name)->first();
        //         if ($old_product) {
        //             $update_old_product = intval($old_product->total_quantity) - intval($request->old_qty);
        //             if (intval($update_old_product) == 0) {
        //                 DB::table('stock_journals')->where('product_name', $request->old_product_name)->delete();
        //             } else {
        //                 DB::table('stock_journals')->where('product_name', $request->old_product_name)->update(['total_quantity' => $update_old_product]);
        //             }
        //         }

        //     }
        // }

        // $totalStock = 0;
        // $DBconsume = DB::table('consume_stocks')->where('product_name',$request->product_name)->get();
        // if($DBconsume){
        //     foreach($DBconsume as $dc){
        //         $totalStock += intval($dc->consumeQuantity);

        //     }
        //     $DBStock = DB::table('stock_journals')->where('product_name',$request->product_name)->first();
        //     if($DBStock){
        //         if(intval($DBStock->total_quantity) < $totalStock){
        //             DB::table('consume_stocks')->where('product_name',$request->product_name)->delete();
        //         }
        //     }
        // }
        //end



    }
    public function update(Request $request, string $id)
    {
        //


    }

    /**
     * Remove the specified resource from storage.
     */






    public function destroy(string $id)
    {
        //delete from stock journal
        $get_stock_in_pv = DB::table('payment_vouchers')->where('payment_id', $id)->first();
        if (strtolower($get_stock_in_pv->product_name) != 'land') {
            $get_current_product = DB::table('stock_journals')->where('product_name', $get_stock_in_pv->product_name)->first();
            if ($get_current_product) {
                $updated_qty = intval($get_current_product->total_quantity) - intval($get_stock_in_pv->qty);
                DB::table('stock_journals')->where('product_name', $get_stock_in_pv->product_name)->update(['total_quantity' => $updated_qty]);
                if (intval($updated_qty) == 0 || intval($updated_qty) < 0) {
                    DB::table('stock_journals')->where('product_name', $get_stock_in_pv->product_name)->delete();

                }
            }
        }
        $requisition = DB::table('stock_journals')->pluck('product_name');
        ConsumeStock::whereNotIn('product_name',$requisition)->delete();
        // delete from payment voucher
        $pv = DB::table('payment_vouchers')->where('payment_id', $id)->delete();
        //delete from apledger
        $al = DB::table('apledgers')->where('payment_id', $id)->delete();

        //delete from cash ledger
        $cl = DB::table('cash_ledgers')->where('payment_id', $id)->delete();

        //delete from bank ledger
        $bl = DB::table('bank_ledgers')->where('payment_id', $id)->delete();

        //delete from purchase ledger
        $pl = DB::table('purchase_ledgers')->where('payment_id', $id)->delete();

        //delete from purchase journal
        $pj = DB::table('purchased_journals')->where('payment_id', $id)->delete();

        //delete from payable journal
        $payj = DB::table('payable_journals')->where('payment_id', $id)->delete();

        //delete from pay payable
        $paypay = DB::table('pay_payables')->where('payment_id', $id)->delete();

        //delete from pay return
        $pr = DB::table('purchase_returns')->where('payment_id', $id)->delete();


        //delete from stocks
        $st = DB::table('stocks')->where('payment_id', $id)->delete();


        //delete history
        $ht = DB::table('payment_histories')->where('payment_id',$id)->delete();

        // $allDelete = $pl && $pj && $payj && $paypay && $pr && $st && $pv && $al && $cl && $bl;
        return response()->json(['delete' => $get_stock_in_pv->product_name]);
    }
}

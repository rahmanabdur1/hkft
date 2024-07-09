<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\ReceiptVoucher;

use App\Models\ReceiptJournal;
use App\Models\ReceiptPayableJournal;
use App\Models\SellsLedger;
use App\Models\RPLedger;
use App\Models\CashLedger;
use App\Models\BankLedger;
use App\Models\ReceiptHistory;

use Illuminate\Support\Facades\DB;

class ReceiptVoucherController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $getData = ReceiptVoucher::all();

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
        $paymentHistory->paid = intval($request->total_amount);
        $paymentHistory->receipt_id = $request->receipt_id;
        $paymentHistory->project = $request->selectedProject;

        $paymentHistory->save();

        $voucher = new ReceiptVoucher;
        $voucher->received_by = $request->received_by;

        $voucher->financialYear = $request->financialYear;
        $voucher->basic_date = $request->basic_date;
        $voucher->selectedPaymentType = $request->selectedPaymentType;
        if ($request->cash_bank_account != null) {
            $voucher->cash_bank_account = $request->cash_bank_account;
        } else {
            $voucher->cash_bank_account = "";
        }
        $voucher->client_name = $request->client_name;
        $voucher->selectedProject = $request->selectedProject;

        if ($request->client_tin != null) {
            $voucher->client_tin = $request->client_tin;
        } else {
            $voucher->client_tin = "";
        }
        if ($request->client_phone != null) {
            $voucher->client_phone = $request->client_phone;
        } else {
            $voucher->client_phone = "";
        }
        if ($request->client_email != null) {
            $voucher->client_email = $request->client_email;
        } else {
            $voucher->client_email = "";
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
        $voucher->receipt_id = $request->receipt_id;
        if ($request->payto != null) {
            $voucher->payto = $request->payto;
        } else {
            $voucher->payto = "";
        }

        if ($request->payees_account_no != null) {
            $voucher->payees_account_no = $request->payees_account_no;
        } else {
            $voucher->payees_account_no = "";
        }
        if ($request->payment_receipt_details != null) {
            $voucher->payment_receipt_details = $request->payment_receipt_details;
        } else {
            $voucher->payment_receipt_details = "";
        }

        $voucher->client_id = $request->client_id;
        $voucher->due = $request->due;
        $voucher->product_amount = $request->product_amount;
        $voucher->initial_total_amount = $request->product_amount;
        $voucher->account_type = $request->account_type;
        $voucher->building_name = $request->building_name;
        $voucher->selected_label = $request->selected_label;
        $voucher->property_id = $request->property_id;
        $voucher->sub_property_id = $request->sub_property_id;
        $voucher->property_type = $request->property_type;
        if ($request->selected_label == 'all') {
            $inventory_length = DB::table('inventories')->where('property_id', $request->property_id)->get();
            if ($inventory_length) {
                foreach ($inventory_length as $il) {
                    DB::table('inventories')->where('property_id', $il->property_id)->where('property_status', 'Available')->update(['owner' => $request->client_name, 'property_status' => 'Sold','receipt_id'=>$request->receipt_id]);                }
            }
        } else {
            DB::table('inventories')->where('property_id', $request->property_id)->where('sub_property_type', $request->selected_label)->where('property_name', $request->product_name)->where('property_status', 'Available')->update(['owner' => $request->client_name]);
        }
        if ($request->hasFile("Supporting_docs")) {
            $file = $request->file('Supporting_docs');
            $filename = uniqid() . $file->getClientOriginalName();
            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory

            $voucher->Supporting_docs = 'documents/' . $filename;
        } else {
            $voucher->Supporting_docs = '';
        }


        $voucher->save();

        $receiptJournal = new ReceiptJournal;
        $receiptJournal->receipt_id = $request->receipt_id;
        $receiptJournal->receipt_type = "Credit";
        $receiptJournal->product_name = $request->product_name;
        $receiptJournal->product_amount = $request->product_amount;
        $receiptJournal->client_name = $request->client_name;
        $receiptJournal->client_name_type = "Debit";
        $receiptJournal->due = $request->due;
        $receiptJournal->paid = $request->total_amount;
        $receiptJournal->receipt_date = $request->basic_date;
        $receiptJournal->project = $request->selectedProject;
        $receiptJournal->financialYear = $request->financialYear;
        $receiptJournal->building_name = $request->building_name;

        if ($request->selectedPaymentType == "Cheque") {

            $receiptJournal->bank = $request->cash_bank_account;
            $receiptJournal->bank_type = "Debit";
            $receiptJournal->cash = null;
            $receiptJournal->cash_type = null;
        }
        if ($request->selectedPaymentType == "Cash") {
            $receiptJournal->bank = null;
            $receiptJournal->bank_type = null;
            $receiptJournal->cash = "Cash";
            $receiptJournal->cash_type = "Debit";
        }
        $receiptJournal->save();
        if (intval($request->product_amount) > intval($request->total_amount)) {
            $receipt_payable_journal = new ReceiptPayableJournal;
            $receipt_payable_journal->receipt_id = $request->receipt_id;
            $receipt_payable_journal->client_name = $request->client_name;
            $receipt_payable_journal->product_name = $request->product_name;

            $receipt_payable_journal->client_name_type = "Credit";
            $receipt_payable_journal->due = $request->due;
            if ($request->selectedPaymentType == "Cheque") {
                $receipt_payable_journal->bank = $request->cash_bank_account;
                $receipt_payable_journal->bank_type = "Debit";
                $receipt_payable_journal->cash = null;
                $receipt_payable_journal->cash_type = null;
            }
            if ($request->selectedPaymentType == "Cash") {
                $receipt_payable_journal->bank = null;
                $receipt_payable_journal->bank_type = null;
                $receipt_payable_journal->cash = "Cash";
                $receipt_payable_journal->cash_type = "Debit";
            }
            $receipt_payable_journal->building_name = $request->building_name;

            $receipt_payable_journal->paid = $request->due;
            $receipt_payable_journal->receipt_date = $request->basic_date;
            $receipt_payable_journal->financialYear = $request->financialYear;
            $receipt_payable_journal->project = $request->selectedProject;
            $receipt_payable_journal->save();
        }
        $updateInventory = DB::table("inventories")->where('property_name', $request->product_name)->update(["property_status" => "Sold"

        ,'receipt_id'=>$request->receipt_id]);


        //sales ledger
        $salesLedger = new SellsLedger;
        $salesLedger->client_name = $request->client_name;
        $salesLedger->receipt_id = $request->receipt_id;
        $salesLedger->product_name = $request->product_name;
        $salesLedger->paid = -intval($request->total_amount);
        $salesLedger->due = -intval($request->due);

        if ($request->selectedPaymentType == "Cheque") {
            $salesLedger->bank = $request->cash_bank_account;

            $salesLedger->cash = null;

        }
        if ($request->selectedPaymentType == "Cash") {
            $salesLedger->bank = null;

            $salesLedger->cash = "Cash";

        }
        $salesLedger->date = $request->basic_date;
        $salesLedger->client_id = $request->client_id;
        $salesLedger->return_amount = 0;
        $salesLedger->total_balance = -intval($request->product_amount);
        $salesLedger->financialYear = $request->financialYear;
        $salesLedger->save();

        //receipt payable ledgers
        if (intval($request->due) > 0) {
            $rpLedger = new RPLedger;
            $rpLedger->client_name = $request->client_name;
            $rpLedger->receipt_id = $request->receipt_id;
            $rpLedger->product_name = $request->product_name;
            $rpLedger->paid =0;
            $rpLedger->due = intval($request->due);

            if ($request->selectedPaymentType == "Cheque") {
                $rpLedger->bank = $request->cash_bank_account;
                $rpLedger->cash = null;
            }
            if ($request->selectedPaymentType == "Cash") {
                $rpLedger->bank = null;
                $rpLedger->cash = "Cash";
            }
            $rpLedger->date = $request->basic_date;
            $rpLedger->account_type = $request->account_type;
            $rpLedger->return_amount = 0;
            $rpLedger->financialYear = $request->financialYear;
            $rpLedger->save();
        }


        //bank ledger && cash ledger
        if (intval($request->total_amount) != 0) {


            if ($request->selectedPaymentType == 'Cheque') {
                $bankledger = new BankLedger;
                $bankledger->supplier_name = $request->client_name;
                $bankledger->payment_id = $request->receipt_id;
                $bankledger->product_name = $request->product_name;
                $bankledger->receipt_paid = intval($request->total_amount);
                $bankledger->receipt_due = 0;
                $bankledger->cash = "";
                $bankledger->bank = "Bank - " . $request->cash_bank_account;
                $bankledger->date = $request->basic_date;
                $bankledger->account_type = $request->account_type;
                $bankledger->financialYear = $request->financialYear;

                if ($request->due > 0) {
                    $bankledger->payment_status = 0;
                } else if ($request->due == 0) {
                    $bankledger->payment_status = 1;
                }
                $bankledger->save();
            } else if ($request->selectedPaymentType == 'Cash') {

                $cashledger = new CashLedger;
                $cashledger->supplier_name = $request->client_name;
                $cashledger->payment_id = $request->receipt_id;
                $cashledger->product_name = $request->product_name;
                $cashledger->receipt_paid = intval($request->total_amount);
                $cashledger->receipt_due = 0;
                $cashledger->cash = "Cash";
                $cashledger->bank = "";
                $cashledger->date = $request->basic_date;
                $cashledger->account_type = $request->account_type;
                $cashledger->financialYear = $request->financialYear;
                if ($request->due > 0) {
                    $cashledger->payment_status = 0;
                } else if ($request->due == 0) {
                    $cashledger->payment_status = 1;
                }


                $cashledger->save();

            }
        }



        return response()->json(["updateInventory" => $updateInventory, "receipt_journal" => $receiptJournal]);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $index = ReceiptVoucher::find($id);
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
    public function receiptUpdate(Request $request)
    {

        
        $voucher = ReceiptVoucher::find($request->id);
        $voucher->financialYear = $request->financialYear;
        $voucher->basic_date = $request->basic_date;
        $voucher->selectedPaymentType = $request->selectedPaymentType;
        $voucher->received_by = $request->received_by;

        if ($request->cash_bank_account != null) {
            $voucher->cash_bank_account = $request->cash_bank_account;
        } else {
            $voucher->cash_bank_account = "";
        }
        $voucher->client_name = $request->client_name;
        $voucher->selectedProject = $request->selectedProject;

        if ($request->client_tin != null) {
            $voucher->client_tin = $request->client_tin;
        } else {
            $voucher->client_tin = "";
        }
        if ($request->client_phone != null) {
            $voucher->client_phone = $request->client_phone;
        } else {
            $voucher->client_phone = "";
        }
        if ($request->client_email != null) {
            $voucher->client_email = $request->client_email;
        } else {
            $voucher->client_email = "";
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
        $voucher->receipt_id = $request->receipt_id;
        if ($request->payto != null) {
            $voucher->payto = $request->payto;
        } else {
            $voucher->payto = "";
        }

        if ($request->payees_account_no != null) {
            $voucher->payees_account_no = $request->payees_account_no;
        } else {
            $voucher->payees_account_no = "";
        }
        if ($request->payment_receipt_details != null) {
            $voucher->payment_receipt_details = $request->payment_receipt_details;
        } else {
            $voucher->payment_receipt_details = "";
        }
        if ($request->client_id) {
            $voucher->client_id = $request->client_id;
        } else {
            $voucher->client_id = "";
        }

        if ($request->hasFile("Supporting_docs")) {
            $file = $request->file('Supporting_docs');
            $filename = uniqid() . $file->getClientOriginalName();
            // $path = $file->storeAs('AdminPanel/Documents/',$filename);
            //test


            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory


            //
            $database_doc = DB::table('receipt_vouchers')->where('id', $request->id)->first();
            if ($database_doc->Supporting_docs != "") {
                $old_doc = public_path($voucher->Supporting_docs);

                unlink($old_doc);
                $voucher->Supporting_docs = 'documents/' . $filename;
            } else if ($database_doc->Supporting_docs == "") {

                $voucher->Supporting_docs = 'documents/' . $filename;
            }
        } else {
            $database_doc = DB::table('receipt_vouchers')->where('id', $request->id)->first();
            $voucher->Supporting_docs = $database_doc->Supporting_docs;
        }
        $voucher->due = $request->due;
        $voucher->product_amount = $request->product_amount;
        $voucher->initial_total_amount = $request->product_amount;
        $voucher->account_type = $request->account_type;
        $voucher->property_type = $request->property_type;
        $voucher->property_id = $request->property_id;
        $voucher->sub_property_id = $request->sub_property_id;
        //update inventories

        if (strtolower($request->old_property_type) == 'land') {
            if (strtolower($request->property_type) == 'land') {
                $old_sub_property_id = $request->old_sub_property_id;
                if ($old_sub_property_id != $request->sub_property_id) {
                    DB::table('inventories')->where('sub_property_id', $request->old_sub_property_id)->update(['property_status' => 'Available', 'owner' => "",'receipt_id'=>""]);
                    DB::table('inventories')->where('sub_property_id', $request->sub_property_id)->update(['property_status' => 'Sold', 'owner' => $request->client_name,'receipt_id'=>$request->receipt_id]);
                }
            } else if (strtolower($request->property_type) != 'land') {
                DB::table('inventories')->where('sub_property_id', $request->old_sub_property_id)->update(['property_status' => 'Available', 'owner' => "",'receipt_id'=>""]);
                if ($request->selected_label == 'all') {
                    $inventory_length = DB::table('inventories')->where('property_id', $request->property_id)->get();
                    if ($inventory_length) {
                        foreach ($inventory_length as $il) {
                            DB::table('inventories')->where('property_id', $il->property_id)->where('property_status', 'Available')->update(['owner' => $request->client_name, 'property_status' => 'Sold','receipt_id'=>$request->receipt_id]);
                        }
                        $voucher->building_name = $request->building_name;
                        $voucher->selected_label = $request->selected_label;
                    }
                } else {
                    DB::table('inventories')->where('sub_property_id', $request->sub_property_id)->update(['owner' => $request->client_name, 'property_status' => 'Sold','receipt_id'=>$request->receipt_id]);
                    $voucher->building_name = $request->building_name;
                    $voucher->selected_label = $request->selected_label;

                }
            }
        } else if (strtolower($request->old_property_type) != 'land') {
            if (strtolower($request->property_type) == 'land') {
                if(strtolower($request->old_label)=='all'){
                    if(strtolower($request->selected_label !='all')){
                         $old_inventory= DB::table('inventories')->where('property_id', $request->old_property_id)->where('owner',$request->old_owner)->get();
                         if($old_inventory){
                            foreach($old_inventory as $oi){
                                DB::table('inventories')->where('property_id', $oi->property_id)->where('owner',$request->old_owner)->update(['property_status' => 'Available', 'owner' => "",'receipt_id'=>""]);
                            }
                         }

                    }
                }
                // $old_sub_property_id = $request->old_sub_property_id;
                // DB::table('inventories')->where('sub_property_id', $request->old_sub_property_id)->update(['property_status' => 'Available', 'owner' => "",'receipt_id'=>""]);
                 $voucher->building_name = "";
                 $voucher->selected_label = "";

                 DB::table('inventories')->where('sub_property_id', $request->sub_property_id)->update(['property_status' => 'Sold', 'owner' => $request->client_name,'receipt_id'=>$request->receipt_id]);

            } else if (strtolower($request->property_type) != 'land') {

                if ($request->old_property_id != $request->property_id) {
                    if ($request->old_label == 'all') {
                        $inventory_length2 = DB::table('inventories')->where('property_id', $request->old_property_id)->where('owner', $request->client_name)->get();
                        if ($inventory_length2) {
                            foreach ($inventory_length2 as $il) {
                                DB::table('inventories')->where('property_id', $il->property_id)->where('owner', $request->client_name)->update(['owner' => "", 'property_status' => 'Available','receipt_id'=>""]);
                            }
                            $voucher->building_name = "";
                            $voucher->selected_label = "";

                        }
                        if ($request->selected_label == 'all') {
                            $inventory_length = DB::table('inventories')->where('property_id', $request->property_id)->get();
                            if ($inventory_length) {
                                foreach ($inventory_length as $il) {
                                    DB::table('inventories')->where('property_id', $il->property_id)->where('property_status', 'Available')->update(['owner' => $request->client_name, 'property_status' => 'Sold','receipt_id'=>$request->receipt_id]);
                                }
                                $voucher->building_name = $request->building_name;
                                $voucher->selected_label = $request->selected_label;

                            }
                        } else {
                            DB::table('inventories')->where('sub_property_id', $request->sub_property_id)->update(['owner' => $request->client_name, 'property_status' => 'Sold','receipt_id'=>$request->receipt_id]);
                            $voucher->building_name = $request->building_name;
                            $voucher->selected_label = $request->selected_label;

                        }

                        //end
                    } else {
                        DB::table('inventories')->where('sub_property_id', $request->old_sub_property_id)->update(['owner' => "", 'property_status' => 'Available','receipt_id'=>""]);
                        $voucher->building_name = "";
                        $voucher->selected_label = "";

                        if ($request->selected_label == 'all') {
                            $inventory_length = DB::table('inventories')->where('property_id', $request->property_id)->get();
                            if ($inventory_length) {
                                foreach ($inventory_length as $il) {
                                    DB::table('inventories')->where('property_id', $il->property_id)->where('property_status', 'Available')->update(['owner' => $request->client_name, 'property_status' => 'Sold','receipt_id'=>$request->receipt_id]);
                                }
                                $voucher->building_name = $request->building_name;
                                $voucher->selected_label = $request->selected_label;

                            }

                        } else {
                            DB::table('inventories')->where('sub_property_id', $request->sub_property_id)->update(['owner' => $request->client_name, 'property_status' => 'Sold','receipt_id'=>$request->receipt_id]);
                            $voucher->building_name = $request->building_name;
                            $voucher->selected_label = $request->selected_label;

                        }
                    }
                }else{
                    DB::table('inventories')->where('sub_property_id', $request->sub_property_id)->update(['owner' => $request->client_name, 'property_status' => 'Sold','receipt_id'=>$request->receipt_id]);

                }
            }
        }
        //if no selected label choose, just name or other info
         DB::table('inventories')->where('receipt_id', $request->receipt_id)->update(['owner' => $request->client_name, 'property_status' => 'Sold','receipt_id'=>$request->receipt_id]);

        if($request->old_sub_property_id != $request->sub_property_id){
            DB::table('inventories')->where('sub_property_id', $request->old_sub_property_id)->update(['owner' => "", 'property_status' => 'Available','receipt_id'=>$request->receipt_id]);
            DB::table('inventories')->where('sub_property_id', $request->sub_property_id)->update(['owner' => $request->client_name, 'property_status' => 'Sold','receipt_id'=>$request->receipt_id]);
        }




        $voucher->save();
        //edit journal & receivable
        $receiptJournal = array();
        // $receiptJournal =  ReceiptJournal::find($request->receipt_id);
        $receiptJournal['receipt_id'] = $request->receipt_id;
        $receiptJournal['receipt_type'] = "Credit";
        $receiptJournal['product_name'] = $request->product_name;
        $receiptJournal['product_amount'] = $request->product_amount;
        $receiptJournal['client_name'] = $request->client_name;
        $receiptJournal['client_name_type'] = "Debit";
        $receiptJournal['due'] = $request->due;
        $receiptJournal['paid'] = $request->total_amount;
        $receiptJournal['receipt_date'] = $request->basic_date;
        $receiptJournal['project'] = $request->selectedProject;
        $receiptJournal['financialYear'] = $request->financialYear;
        $receiptJournal['building_name'] = $request->building_name;

        if ($request->selectedPaymentType == "Cheque") {
            $receiptJournal['bank'] = $request->cash_bank_account;
            $receiptJournal['bank_type'] = "Debit";
            $receiptJournal['cash'] = null;
            $receiptJournal['cash_type'] = null;
        }
        if ($request->selectedPaymentType == "Cash") {
            $receiptJournal['bank'] = null;
            $receiptJournal['bank_type'] = null;
            $receiptJournal['cash'] = "Cash";
            $receiptJournal['cash_type'] = "Debit";
        }
        DB::table('receipt_journals')->where('receipt_id', $request->receipt_id)->update($receiptJournal);
        if (intval($request->product_amount) > intval($request->total_amount)) {
            $checkRPJ = DB::table('receipt_payable_journals')->where('receipt_id', $request->receipt_id)->first();
            if ($checkRPJ) {
                $receipt_payable_journal = array();
                $receipt_payable_journal['receipt_id'] = $request->receipt_id;
                $receipt_payable_journal['client_name'] = $request->client_name;
                $receipt_payable_journal['client_name_type'] = "Credit";
                $receipt_payable_journal['product_name'] = $request->product_name;
                $receipt_payable_journal['due'] = $request->due;
                if ($request->selectedPaymentType == "Cheque") {
                    $receipt_payable_journal['bank'] = $request->cash_bank_account;
                    $receipt_payable_journal['bank_type'] = "Debit";
                    $receipt_payable_journal['cash'] = null;
                    $receipt_payable_journal['cash_type'] = null;
                }
                if ($request->selectedPaymentType == "Cash") {
                    $receipt_payable_journal['bank'] = null;
                    $receipt_payable_journal['bank_type'] = null;
                    $receipt_payable_journal['cash'] = "Cash";
                    $receipt_payable_journal['cash_type'] = "Debit";
                }
                $receiptJournal['building_name'] = $request->building_name;

                $receipt_payable_journal['paid'] = $request->due;
                $receipt_payable_journal['receipt_date'] = $request->basic_date;
                $receipt_payable_journal['financialYear'] = $request->financialYear;
                $receipt_payable_journal['project'] = $request->selectedProject;
                DB::table('receipt_payable_journals')->where('receipt_id', $request->receipt_id)->update($receipt_payable_journal);
            } else {
                $receipt_payable_journal = new ReceiptPayableJournal;
                $receipt_payable_journal->receipt_id = $request->receipt_id;
                $receipt_payable_journal->client_name = $request->client_name;
                $receipt_payable_journal->product_name = $request->product_name;
                $receipt_payable_journal->client_name_type = "Credit";
                $receipt_payable_journal->due = $request->due;
                $receipt_payable_journal->building_name = $request->building_name;

                if ($request->selectedPaymentType == "Cheque") {
                    $receipt_payable_journal->bank = $request->cash_bank_account;
                    $receipt_payable_journal->bank_type = "Debit";
                    $receipt_payable_journal->cash = null;
                    $receipt_payable_journal->cash_type = null;
                }
                if ($request->selectedPaymentType == "Cash") {
                    $receipt_payable_journal->bank = null;
                    $receipt_payable_journal->bank_type = null;
                    $receipt_payable_journal->cash = "Cash";
                    $receipt_payable_journal->cash_type = "Debit";
                }

                $receipt_payable_journal->paid = $request->due;
                $receipt_payable_journal->receipt_date = $request->basic_date;
                $receipt_payable_journal->financialYear = $request->financialYear;
                $receipt_payable_journal->project = $request->selectedProject;
                $receipt_payable_journal->save();
            }

        } else if ($request->due == 0) {
            DB::table('receipt_payable_journals')->where('receipt_id', $request->receipt_id)->delete();
        }


        //update all ledgers

        //sales ledger
        $sales_ledger = array();
        $sales_ledger['client_name'] = $request->client_name;
        $sales_ledger['client_id'] = $request->client_id;
        $sales_ledger['receipt_id'] = $request->receipt_id;
        $sales_ledger['product_name'] = $request->product_name;
        $sales_ledger['paid'] = -intval($request->total_amount);
        $sales_ledger['due'] = -intval($request->due);
        $sales_ledger['date'] = $request->basic_date;
        $sales_ledger['total_balance'] = -intval($request->product_amount);
        $sales_ledger['financialYear'] = $request->financialYear;

        if ($request->selectedPaymentType == 'Cash') {
            $sales_ledger['cash'] = "Cash";
            $sales_ledger['bank'] = null;
        } else if ($request->selectedPaymentType == 'Cheque') {
            $sales_ledger['cash'] = null;
            $sales_ledger['bank'] = "Bank - " . $request->cash_bank_account;

        }
        DB::table('sells_ledgers')->where('receipt_id', $request->receipt_id)->update($sales_ledger);

        //receipt payable ledgers
        if (intval($request->due) == 0) {
            DB::table('r_p_ledgers')->where('receipt_id', $request->receipt_id)->delete();
            $checkInCash = DB::table('cash_ledgers')->where('payment_id', $request->receipt_id)->get();
            if ($checkInCash) {
                DB::table('cash_ledgers')->where('payment_id', $request->receipt_id)->update(['payment_status' => 1]);
            }
            $checkInBank = DB::table('bank_ledgers')->where('payment_id', $request->receipt_id)->get();
            if ($checkInBank) {
                DB::table('cash_ledgers')->where('payment_id', $request->receipt_id)->update(['payment_status' => 1]);
            }
        } else if (intval($request->due) > 0) {
            $checkRPL = DB::table('r_p_ledgers')->where('receipt_id', $request->receipt_id)->get();

            if ($checkRPL) {

                $rpLedger = array();
                $rpLedger['client_name'] = $request->client_name;
                $rpLedger['receipt_id'] = $request->receipt_id;
                $rpLedger['product_name'] = $request->product_name;
                $rpLedger['paid'] = 0;
                $rpLedger['due'] = intval($request->due);

                if ($request->selectedPaymentType == "Cheque") {
                    $rpLedger['bank'] = $request->cash_bank_account;
                    $rpLedger['cash'] = null;
                }
                if ($request->selectedPaymentType == "Cash") {
                    $rpLedger['bank'] = null;
                    $rpLedger['cash'] = "Cash";
                }
                $rpLedger['date'] = $request->basic_date;
                $rpLedger['account_type'] = $request->account_type;
                $rpLedger['financialYear'] = $request->financialYear;
                DB::table('r_p_ledgers')->where('account_type', $request->account_type)->update($rpLedger);
            } else {

                $rpLedger = new RPLedger;
                $rpLedger->client_name = $request->client_name;
                $rpLedger->receipt_id = $request->receipt_id;
                $rpLedger->product_name = $request->product_name;
                $rpLedger->paid = 0;
                $rpLedger->due = intval($request->due);

                if ($request->selectedPaymentType == "Cheque") {
                    $rpLedger->bank = $request->cash_bank_account;
                    $rpLedger->cash = null;
                }
                if ($request->selectedPaymentType == "Cash") {
                    $rpLedger->bank = null;
                    $rpLedger->cash = "Cash";
                }
                $rpLedger->date = $request->basic_date;
                $rpLedger->account_type = $request->account_type;
                $rpLedger->return_amount = 0;
                $rpLedger->financialYear = $request->financialYear;
                $rpLedger->save();
            }

        }



        //cash ledgers && bank ledgers
        if (intval($request->total_amount) > 0) {
            if ($request->selectedPaymentType == 'Cheque') {
                $hasBankPI = DB::table('bank_ledgers')->where('account_type', $request->account_type)->first();
                if ($hasBankPI) {
                    //update all bank names
                    $updateAllName = DB::table('bank_ledgers')->where('payment_id', $request->receipt_id)->get();
                    if ($updateAllName) {
                        foreach ($updateAllName as $ula) {
                            DB::table('bank_ledgers')->where('payment_id', $request->receipt_id)->update(['supplier_name' => $request->client_name, 'product_name' => $request->product_name]);
                        }
                    }

                    //update all cash names
                    $updateAllName2 = DB::table('cash_ledgers')->where('payment_id', $request->receipt_id)->get();
                    if ($updateAllName2) {
                        foreach ($updateAllName2 as $ula) {
                            DB::table('cash_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->client_name, 'product_name' => $request->product_name]);
                        }
                    }

                    //update bank
                    $bankledger = array();
                    $bankledger['supplier_name'] = $request->client_name;
                    $bankledger['payment_id'] = $request->receipt_id;
                    $bankledger['product_name'] = $request->product_name;
                    $bankledger['receipt_paid'] = intval($request->total_amount);
                    $bankledger['paid']=null;
                    $bankledger['receipt_due'] = 0;
                    $bankledger['cash'] = "";
                    $bankledger['bank'] = "Bank-" . $request->cash_bank_account;
                    $bankledger['date'] = $request->basic_date;
                    $bankledger['financialYear'] = $request->financialYear;
                    if ($request->due == 0) {
                        $bankledger['payment_status'] = 1;
                    }else{
                        $bankledger['payment_status'] = 0;
                    }
                    DB::table('bank_ledgers')->where('account_type', $request->account_type)->update($bankledger);


                    //end if of bank pi
                } else {
                    //delete from cash
                    DB::table('cash_ledgers')->where('account_type', $request->account_type)->delete();


                    //before create bank data entry update supplier_name,product_name etc.

                    $updateAllName = DB::table('bank_ledgers')->where('payment_id', $request->receipt_id)->get();
                    if ($updateAllName) {

                        foreach ($updateAllName as $ula) {

                            DB::table('bank_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->client_name, 'product_name' => $request->product_name]);
                        }
                    }
                    $updateAllName2 = DB::table('cash_ledgers')->where('payment_id', $request->receipt_id)->get();
                    if ($updateAllName2) {

                        foreach ($updateAllName2 as $ula) {

                            DB::table('cash_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->client_name, 'product_name' => $request->product_name]);
                        }
                    }
                    //create bank
                    $bankledger = new BankLedger;
                    $bankledger->supplier_name = $request->client_name;
                    $bankledger->payment_id = $request->receipt_id;
                    $bankledger->product_name = $request->product_name;
                    $bankledger->receipt_paid = intval($request->total_amount);
                    $bankledger->receipt_due = 0;
                    $bankledger->cash = "";
                    $bankledger->bank = "Bank-" . $request->cash_bank_account;
                    $bankledger->date = $request->basic_date;
                    $bankledger->account_type = $request->account_type;
                    $bankledger->paid=null;

                    $bankledger->financialYear = $request->financialYear;
                    if (intval($request->due) > 0) {
                        $bankledger->payment_status = 0;
                    } else if (intval($request->due == 0)) {
                        $bankledger->payment_status = 1;
                    }
                    $bankledger->save();

                    //end else
                }

            } else if ($request->selectedPaymentType == "Cash") {
                $hasCashPI = DB::table('cash_ledgers')->where('account_type', $request->account_type)->first();

                if ($hasCashPI) {
                    //update all cash names

                    $updateAllName = DB::table('cash_ledgers')->where('payment_id', $request->receipt_id)->get();
                    if ($updateAllName) {
                        foreach ($updateAllName as $ula) {
                            DB::table('cash_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->client_name, 'product_name' => $request->product_name]);
                        }
                    }
                    //update all bank names
                    $updateAllName2 = DB::table('bank_ledgers')->where('payment_id', $request->receipt_id)->get();
                    if ($updateAllName2) {
                        foreach ($updateAllName2 as $ula) {
                            DB::table('bank_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->client_name, 'product_name' => $request->product_name]);
                        }
                    }


                    //update cash
                    $cashledger = array();
                    $cashledger['supplier_name'] = $request->client_name;
                    $cashledger['payment_id'] = $request->receipt_id;
                    $cashledger['product_name'] = $request->product_name;
                    $cashledger['receipt_paid'] = intval($request->total_amount);
                    $cashledger['receipt_due'] = 0;
                    $cashledger['cash'] = "Cash";
                    $cashledger['bank'] = "";
                    $cashledger['paid']=null;

                    $cashledger['date'] = $request->basic_date;
                    $cashledger['financialYear'] = $request->financialYear;
                    if ($request->due == 0) {
                        $cashledger['payment_status'] = 1;
                    }else{
                        $cashledger['payment_status'] = 0;
                    }
                    DB::table('cash_ledgers')->where('account_type', $request->account_type)->update($cashledger);




                    //end
                } else {
                    //delete from bank
                    DB::table('bank_ledgers')->where('account_type', $request->account_type)->delete();

                    //before create cash data entry update supplier_name, product_name etc.

                    $updateAllName = DB::table('cash_ledgers')->where('payment_id', $request->receipt_id)->get();
                    if ($updateAllName) {

                        foreach ($updateAllName as $ula) {

                            DB::table('cash_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->client_name, 'product_name' => $request->product_name]);
                        }
                    }

                    $updateAllName2 = DB::table('bank_ledgers')->where('payment_id', $request->receipt_id)->get();
                    if ($updateAllName2) {

                        foreach ($updateAllName2 as $ula) {

                            DB::table('bank_ledgers')->where('payment_id', $ula->payment_id)->update(['supplier_name' => $request->client_name, 'product_name' => $request->product_name]);
                        }
                    }
                    //create cash
                    $cashledger = new CashLedger;
                    $cashledger->supplier_name = $request->client_name;
                    $cashledger->payment_id = $request->receipt_id;
                    $cashledger->product_name = $request->product_name;
                    $cashledger->receipt_paid = intval($request->total_amount);
                    $cashledger->receipt_due = 0;
                    $cashledger->cash = "Cash";
                    $cashledger->bank = "";
                    $cashledger->paid=null;

                    $cashledger->date = $request->basic_date;
                    $cashledger->account_type = $request->account_type;
                    $cashledger->financialYear = $request->financialYear;
                    if (intval($request->due) > 0) {
                        $cashledger->payment_status = 0;
                    } else if (intval($request->due == 0)) {
                        $cashledger->payment_status = 1;
                    }
                    $cashledger->save();


                }
            }
        }

        if (intval($request->total_amount) == 0) {

            if ($request->selectedPaymentType == 'Cheque') {
                DB::table('bank_ledgers')->where('account_type', $request->account_type)->delete();
            } else if ($request->selectedPaymentType == "Cash") {
                DB::table('cash_ledgers')->where('account_type', $request->account_type)->delete();
            }
        }


        $test = DB::table('cash_ledgers')->where('payment_id', $request->receipt_id)->first();

        //update receipe voucher based on receipt due
        $updatePayable = array();
        $updatePayable['due'] = intval($request->due);
        $getPay_Payable = DB::table('pay_receivables')->where('receipt_id',$request->receipt_id)->first();
        if($getPay_Payable){
                $updatePayable['due'] = intval($request->due);

                $updatePayable['second_due'] = intval($request->due) - intval($getPay_Payable->receive_amount);

                DB::table('pay_receivables')->where('account_type',$getPay_Payable->account_type)->update($updatePayable);

            }

              //receipt voucher based on receipt payable
              $pmntVoucher = array();
              $totalPayablePaid = 0;
              $getPayable1 = DB::table('pay_receivables')->where('receipt_id',$request->receipt_id)->get();
              if($getPayable1){
                  foreach($getPayable1 as $gpv){
                      $totalPayablePaid+= intval($gpv->receive_amount);
                  }
              }
              $getPaymentVoucher = DB::table('receipt_vouchers')->where('receipt_id',$request->receipt_id)->first();

              $pmntVoucher['total_amount'] = intval($totalPayablePaid) + intval($getPaymentVoucher->total_amount);
              $pmntVoucher['due'] =  intval($getPaymentVoucher->due)-intval($totalPayablePaid) ;
              DB::table('receipt_vouchers')->where('receipt_id',$request->receipt_id)->update($pmntVoucher);

              //update receipt payable journal

        $pbljournal = array();
        $totalPayablePaid2 = 0;
        $totalPayablePaid3 = 0;

        $getPayable2 = DB::table('pay_receivables')->where('receipt_id',$request->receipt_id)->get();
        if($getPayable2){
            foreach($getPayable2 as $gpv){
                $totalPayablePaid2+= intval($gpv->receive_amount);
            }
        }
        $getPayableJournal = DB::table('receipt_payable_journals')->where('receipt_id',$request->receipt_id)->get();
        foreach($getPayableJournal as $gp){
            $totalPayablePaid3 =  intval($gp->due)-intval($totalPayablePaid2) ;
            $pbljournal['due']= $totalPayablePaid3;
            $pbljournal['paid']= $totalPayablePaid3;

            DB::table('receipt_payable_journals')->where('receipt_id',$request->receipt_id)->update($pbljournal);


        }
               //update pay receivable
               $receiptPayable = array();
               // $receiptPayable =  receiptPayable::find($request->receipt_id);
               $receiptPayable['receipt_id'] = $request->receipt_id;
               $receiptPayable['product_name'] = $request->product_name;
               $receiptPayable['supplier_name'] = $request->client_name;
               $receiptPayable['basic_date'] = $request->basic_date;
               $receiptPayable['financialYear'] = $request->financialYear;

                DB::table('pay_receivables')->where('receipt_id',$request->receipt_id)->update($receiptPayable);

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
        //
                //inventories
                $pv1 = DB::table('receipt_vouchers')->where('receipt_id', $id)->first();
                 DB::table('inventories')->where('receipt_id',$id)->update(['property_status'=>'Available','owner'=> "",'receipt_id'=>""]);
                // delete from payment voucher
                $pv = DB::table('receipt_vouchers')->where('receipt_id', $id)->delete();
                //delete from apledger
                $al = DB::table('r_p_ledgers')->where('receipt_id', $id)->delete();

                //delete from cash ledger
                $cl = DB::table('cash_ledgers')->where('payment_id', $id)->delete();

                //delete from bank ledger
                $bl = DB::table('bank_ledgers')->where('payment_id', $id)->delete();

                //delete from purchase ledger
                $pl = DB::table('sells_ledgers')->where('receipt_id', $id)->delete();

                //delete from purchase journal
                $pj = DB::table('receipt_journals')->where('receipt_id', $id)->delete();

                //delete from payable journal
                $payj = DB::table('receipt_payable_journals')->where('receipt_id', $id)->delete();

                //delete from pay payable
                $paypay = DB::table('pay_receivables')->where('receipt_id', $id)->delete();

                //
                $rh= DB::table('receipt_histories')->where('receipt_id',$id)->delete();




                // $allDelete = $pl && $pj && $payj && $paypay && $pr && $st && $pv && $al && $cl && $bl;

    }
}

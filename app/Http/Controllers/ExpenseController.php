<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\Expense;
use Carbon\Carbon;
class ExpenseController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $expense =  Expense::all();
        return response()->json($expense);
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
        $expense = new Expense;
        $expense->category_name = $request->category_name;
        $expense->category_id = $request->category_id;
        $expense->financialYear = $request->financialYear;
        $expense->basic_date = $request->basic_date;
        $expense->selectedPaymentType = $request->selectedPaymentType;
        $expense->selectedProject = $request->selectedProject;
        $expense->product_name = $request->product_name;
        $expense->receive_amount = $request->receive_amount;
        $expense->payment_id = $request->payment_id;
        $expense->building_name = $request->building_name;
        if ($request->selectedPaymentType == 'Cheque') {
            $expense->bank_cheque_no = $request->bank_cheque_no;
            $expense->bank_cheque_date = $request->bank_cheque_date;
            $expense->bank_name = $request->bank_name;
            $expense->bank_branch = $request->bank_branch;
            $expense->cash_bank_account  = $request->cash_bank_account;
        } else if ($request->selectedPaymentType == 'Cash') {
            $expense->bank_cheque_no = null;
            $expense->bank_cheque_date = null;
            $expense->bank_name = null;
            $expense->bank_branch = null;
            $expense->cash_bank_account  = null;
        }
        if ($request->hasFile("Supporting_docs")) {
            $file = $request->file('Supporting_docs');
            $filename = uniqid() . $file->getClientOriginalName();
            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory

            $expense->Supporting_docs = 'documents/' . $filename;
        } else {
            $expense->Supporting_docs = '';
        }
        $expense->expense_voucher = $request->expense_voucher;
        $expense->note = $request->note;
         $expense->save();

        //end expense


        //end
        return response()->json($request);

    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $expense = Expense::find($id);
        return response()->json($expense);
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

    }
    public function updateExpense(Request $request){

        $expense =  Expense::find($request->id);
        $expense->category_name = $request->category_name;
        $expense->category_id = $request->category_id;
        $expense->financialYear = $request->financialYear;
        $expense->basic_date = $request->basic_date;
        $expense->selectedPaymentType = $request->selectedPaymentType;
        $expense->selectedProject = $request->selectedProject;
        $expense->product_name = $request->product_name;
        $expense->receive_amount = $request->receive_amount;
        $expense->payment_id = $request->payment_id;
        $expense->building_name = $request->building_name;
        if ($request->selectedPaymentType == 'Cheque') {
            $expense->bank_cheque_no = $request->bank_cheque_no;
            $expense->bank_cheque_date = $request->bank_cheque_date;
            $expense->bank_name = $request->bank_name;
            $expense->bank_branch = $request->bank_branch;
            $expense->cash_bank_account  = $request->cash_bank_account;

        } else if ($request->selectedPaymentType == 'Cash') {
            $expense->bank_cheque_no = null;
            $expense->bank_cheque_date = null;
            $expense->bank_name = null;
            $expense->bank_branch = null;
            $expense->cash_bank_account  = null;

        }
        if ($request->hasFile("Supporting_docs")) {
            $file = $request->file('Supporting_docs');
            $filename = uniqid() . $file->getClientOriginalName();
            // $path = $file->storeAs('AdminPanel/Documents/',$filename);
            //test


            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory


            //
            $database_doc = DB::table('expenses')->where('id', $request->id)->first();
            if ($database_doc->Supporting_docs != "") {
                $old_doc = public_path($expense->Supporting_docs);

                unlink($old_doc);
                $expense->Supporting_docs = 'documents/' . $filename;
            } else if ($database_doc->Supporting_docs == "") {

                $expense->Supporting_docs = 'documents/' . $filename;
            }
        } else {
            $database_doc = DB::table('expenses')->where('id', $request->id)->first();
            $expense->Supporting_docs = $database_doc->Supporting_docs;
        }
        $expense->expense_voucher = $request->expense_voucher;

        $expense->note = $request->note;
        $expense->save();
    }

    public function totalExpense(Request $request){
        $startdate = Carbon::createFromFormat('Y-m-d',$request->startDate);
        $enddate = Carbon::createFromFormat('Y-m-d',$request->endDate);
        $index = DB::table('expenses')->select('expenses.*')->whereBetween('basic_date',[$startdate,$enddate])->get();
        $totalBalance = 0;
       if($index){
        foreach($index as $ind){
            $totalBalance = $totalBalance+ intval($ind->receive_amount);
        }
       }
       $data =[ 'totalExpense'=>$totalBalance];
        return response()->json($data);
    }
    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        DB::table('expenses')->where('id',$id)->delete();
    }
}

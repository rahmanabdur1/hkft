<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\Salary;
use Carbon\Carbon;
class SalaryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index = Salary::all();
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
        $salary = new Salary;
        $salary->employee_name = $request->employee_name;
        $salary->basic_date = $request->basic_date;
        $salary->selectedPaymentType=$request->selectedPaymentType;
        $salary->employee_phone=$request->employee_phone;

        if ($request->selectedPaymentType == 'Cheque') {
            $salary->cash_bank_account = $request->cash_bank_account;
            $salary->bank_name = $request->bank_name;
            $salary->bank_branch = $request->bank_branch;
            $salary->bank_cheque_no = $request->bank_cheque_no;
            $salary->bank_cheque_date = $request->bank_cheque_date;
        } else if ($request->selectedPaymentType == 'Cash') {
            $salary->cash_bank_account = null;
            $salary->bank_name = null;
            $salary->bank_branch = null;
            $salary->bank_cheque_no = null;
            $salary->bank_cheque_date = null;

        }
        $salary->selectedBuilding = $request->building_name;

        $salary->selectedProject = $request->selectedProject;
        $salary->employee_id = $request->employee_id;
       if($request->commission !=''){
        $salary->commission = $request->commission;
       }else{
        $salary->commission=0;
       }
        $salary->basic_salary = $request->basic_salary;
        $salary->paid_month = $request->paid_month;
        $salary->paid_year = $request->paid_year;
        $salary->save();
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $index = Salary::find($id);
        return response()->json($index);
    }
    public function getSalaryHistory($employee_id)
    {
        $index = DB::table('salaries')->where('employee_id', $employee_id)->get();
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
        $salary =  Salary::find($id);
        $salary->employee_name = $request->employee_name;
        $salary->basic_date = $request->basic_date;
        $salary->employee_phone=$request->employee_phone;

        $salary->selectedPaymentType=$request->selectedPaymentType;
        if ($request->selectedPaymentType == 'Cheque') {
            $salary->cash_bank_account = $request->cash_bank_account;
            $salary->bank_name = $request->bank_name;
            $salary->bank_branch = $request->bank_branch;
            $salary->bank_cheque_no = $request->bank_cheque_no;
            $salary->bank_cheque_date = $request->bank_cheque_date;
        } else if ($request->selectedPaymentType == 'Cash') {
            $salary->cash_bank_account = null;
            $salary->bank_name = null;
            $salary->bank_branch = null;
            $salary->bank_cheque_no = null;
            $salary->bank_cheque_date = null;

        }
        $salary->selectedBuilding = $request->building_name;
        $salary->selectedProject = $request->selectedProject;
        $salary->employee_id = $request->employee_id;
        if($request->commission !=''){
            $salary->commission = $request->commission;
           }else{
            $salary->commission=0;
           }
        $salary->basic_salary = $request->basic_salary;
        $salary->paid_month = $request->paid_month;
        $salary->paid_year = $request->paid_year;
        $salary->save();
    }

    public function totalSalary (Request $request){
        $startdate = Carbon::createFromFormat('Y-m-d',$request->startDate);
        $enddate = Carbon::createFromFormat('Y-m-d',$request->endDate);
        $index = DB::table('salaries')->select('salaries.*')->whereBetween('basic_date',[$startdate,$enddate])->get();
        $totalBalance = 0;
       if($index){
        foreach($index as $ind){
            $totalBalance = $totalBalance+ intval($ind->basic_salary)+ intval($ind->commission);
        }
       }
       $data =[ 'totalSalary'=>$totalBalance];
        return response()->json($data);

    }
    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        DB::table('salaries')->where('id',$id)->delete();
    }
}

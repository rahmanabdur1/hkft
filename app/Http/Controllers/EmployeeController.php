<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Employee;
use Illuminate\Support\Facades\DB;
class EmployeeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $employee = Employee::all();
        return response()->json($employee);
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
        $employee = new Employee;
        $employee->employee_name = $request->employee_name;
        $employee->employee_address = $request->employee_address;
        $employee->employee_designation = $request->employee_designation;
        $employee->employee_phone = $request->employee_phone;
        $employee->basic_salary = $request->basic_salary;
        $employee->employee_id = $request->employee_id;
        $employee->selectedProject = $request->selectedProject;
        $employee->building_name = $request->building_name;
        if ($request->hasFile("cv")) {
            $file = $request->file('cv');
            $filename = uniqid().$file->getClientOriginalName();
            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory

            $employee->cv = 'documents/'.$filename;
        } else {
            $employee->cv = '';
        }
        $employee->save();
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $index = Employee::find($id);
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
    public function updateEmployee(Request $request){
        $employee =  Employee::find($request->id);
        $employee->employee_name = $request->employee_name;
        $employee->employee_address = $request->employee_address;
        $employee->employee_designation = $request->employee_designation;
        $employee->employee_phone = $request->employee_phone;
        $employee->basic_salary = $request->basic_salary;
        $employee->employee_id = $request->employee_id;
        $employee->selectedProject = $request->selectedProject;
        $employee->building_name = $request->building_name;

        if ($request->hasFile("cv")) {
            $file = $request->file('cv');
            $filename = uniqid() . $file->getClientOriginalName();
            // $path = $file->storeAs('AdminPanel/Documents/',$filename);
            //test


            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory


            //
            $database_doc = DB::table('employees')->where('id',$request->id)->first();
            if ($database_doc->cv != "") {
                $old_doc = public_path($employee->cv);

                unlink($old_doc);
                $employee->cv = 'documents/' . $filename;
            } else if ($database_doc->cv == "") {

                $employee->cv = 'documents/' . $filename;
            }

        } else {
            $database_doc = DB::table('employees')->where('id',$request->id)->first();
            $employee->cv = $database_doc->cv;
        }

        $employee->save();
        return response()->json($request);
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
        DB::table('employees')->where('id',$id)->delete();
    }
}

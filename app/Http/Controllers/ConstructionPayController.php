<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\ConstructionPay;
class ConstructionPayController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index = ConstructionPay::all();
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
        $getConstructionId = DB::table('construction_requireds')->where('id',$request->id)->first();

        $construction = new ConstructionPay;
        $construction->basic_date = $request->basic_date;
        $construction->due_date = $request->due_date;
        $construction->client_name = $request->client_name;
        $construction->client_id = $request->client_id;
        $construction->selectedProject = $request->selectedProject;
        $construction->selectedBuilding = $request->selectedBuilding;
        $construction->paid_amount = $request->paid_amount;
        $construction->note = $request->note;
        $construction->receieved_by = $request->receieved_by;

        
        $construction->construction_id = $getConstructionId->construction_id;

        $construction->physical_voucher = $request->physical_voucher;
        $construction->selectedPaymentType = $request->selectedPaymentType;
        $construction->cash_bank_account = $request->cash_bank_account;
        $construction->bank_cheque_no = $request->bank_cheque_no;
        $construction->bank_cheque_date = $request->bank_cheque_date;
        $construction->bank_name = $request->bank_name;
        if ($request->bank_branch != null) {
            $construction->bank_branch = $request->bank_branch;
        } else {
            $construction->bank_branch = "";
        }
        if ($request->hasFile("Supporting_docs")) {
            $file = $request->file('Supporting_docs');
            $filename = uniqid() . $file->getClientOriginalName();
            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory

            $construction->Supporting_docs = 'documents/' . $filename;
        } else {
            $construction->Supporting_docs = '';
        }





         $construction->save();




    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $index = ConstructionPay::find($id);
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
        $construction =  ConstructionPay::find($id);
        $construction->basic_date = $request->basic_date;
        $construction->due_date = $request->due_date;

        $construction->client_name = $request->client_name;
        $construction->client_id = $request->client_id;
        $construction->selectedProject = $request->selectedProject;
        $construction->selectedBuilding = $request->selectedBuilding;
        $construction->paid_amount = $request->paid_amount;
        $construction->note = $request->note;
        $construction->receieved_by = $request->receieved_by;
   
        $construction->selectedPaymentType = $request->selectedPaymentType;
        $construction->cash_bank_account = $request->cash_bank_account;
        $construction->bank_cheque_no = $request->bank_cheque_no;
        $construction->bank_cheque_date = $request->bank_cheque_date;
        $construction->bank_name = $request->bank_name;
        $construction->physical_voucher = $request->physical_voucher;

        if ($request->bank_branch != null) {
            $construction->bank_branch = $request->bank_branch;
        } else {
            $construction->bank_branch = "";
        }


        if ($request->hasFile("Supporting_docs")) {
            $file = $request->file('Supporting_docs');
            $filename = uniqid() . $file->getClientOriginalName();
            // $path = $file->storeAs('AdminPanel/Documents/',$filename);
            //test


            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory


            //
            $database_doc = DB::table('construction_pays')->where('id', $request->id)->first();
            if ($database_doc->Supporting_docs != "") {
                $old_doc = public_path($construction->Supporting_docs);

                unlink($old_doc);
                $construction->Supporting_docs = 'documents/' . $filename;
            } else if ($database_doc->Supporting_docs === "") {

                $construction->Supporting_docs = 'documents/' . $filename;
            }

        } else {
            $database_doc = DB::table('construction_pays')->where('id', $request->id)->first();
            $construction->Supporting_docs = $database_doc->Supporting_docs;
        }

        $construction->save();


    }

    public function construction_pays_update(Request $request){
        $construction =  ConstructionPay::find($request->id);
        $construction->basic_date = $request->basic_date;
        $construction->client_name = $request->client_name;
        $construction->client_id = $request->client_id;
        $construction->selectedProject = $request->selectedProject;
        $construction->selectedBuilding = $request->selectedBuilding;
        $construction->paid_amount = $request->paid_amount;
        $construction->note = $request->note;
        $construction->receieved_by = $request->receieved_by;

        $construction->selectedPaymentType = $request->selectedPaymentType;
        $construction->cash_bank_account = $request->cash_bank_account;
        $construction->bank_cheque_no = $request->bank_cheque_no;
        $construction->bank_cheque_date = $request->bank_cheque_date;
        $construction->bank_name = $request->bank_name;
        $construction->physical_voucher = $request->physical_voucher;

        if ($request->bank_branch != null) {
            $construction->bank_branch = $request->bank_branch;
        } else {
            $construction->bank_branch = "";
        }


        if ($request->hasFile("Supporting_docs")) {
            $file = $request->file('Supporting_docs');
            // $filename = uniqid() . $file->getClientOriginalName();
            $filename = uniqid();
            // $path = $file->storeAs('AdminPanel/Documents/',$filename);
            //test


            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory


            //
            $database_doc = DB::table('construction_pays')->where('id', $request->id)->first();
            if ($database_doc->Supporting_docs != "") {
                $old_doc = public_path($construction->Supporting_docs);

                unlink($old_doc);
                $construction->Supporting_docs = 'documents/' . $filename;
            } else if ($database_doc->Supporting_docs === "") {

                $construction->Supporting_docs = 'documents/' . $filename;
            }

        } else {
            $database_doc = DB::table('construction_pays')->where('id', $request->id)->first();
            $construction->Supporting_docs = $database_doc->Supporting_docs;
        }

        $construction->save();

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        // $index = DB::table('construction_pays')->where('id',$id)->first();
        // $afterDelete = DB::table('construction_pays')->where('client_id',$index->client_id)->where('selectedProject',$index->selectedProject)->where('selectedBuilding',$index->selectedBuilding)->first();
        // $totalPay = 0;
        // $pays = DB::table('construction_pays')->where('client_id',$index->client_id)->where('selectedProject',$index->selectedProject)->where('selectedBuilding',$index->selectedBuilding)->get();
        // if($afterDelete){
        //     foreach($pays as $pay){
        //         $totalPay+= intval($pay->paid_amount);
        //     }
        //     $required = DB::table('construction_requireds')->where('client_id',$index->client_id)->where('selectedProject',$index->selectedProject)->where('selectedBuilding',$index->selectedBuilding)->first();
        //     if(intval($totalPay)>intval($required->required_amount)){
        //         $extra_amount = intval($totalPay) - intval($required->required_amount);
        //         $paid_amount = intval($totalPay);
        //         $due_amount = 0;
        //         DB::table('construction_requireds')->where('client_id',$index->client_id)->where('selectedProject',$index->selectedProject)->where('selectedBuilding',$index->selectedBuilding)->update(['paid_amount'=>$paid_amount,'extra_amount'=>$extra_amount,'due_amount'=>$due_amount]);
        //         DB::table('construction_requireds')->where('id',"!=",$required->id)->delete();

        //     }else{
        //         $extra_amount = 0;
        //         $paid_amount = intval($totalPay);
        //         $due_amount =  intval($required->required_amount) -intval($totalPay) ;
        //         DB::table('construction_requireds')->where('id',"!=",$required->id)->delete();

        //         DB::table('construction_requireds')->where('client_id',$index->client_id)->where('selectedProject',$index->selectedProject)->where('selectedBuilding',$index->selectedBuilding)->update(['paid_amount'=>$paid_amount,'extra_amount'=>$extra_amount,'due_amount'=>$due_amount]);

        //     }
        // }else{
        //     $data=DB::table('construction_requireds')->where('client_id',$index->client_id)->where('selectedProject',$index->selectedProject)->where('selectedBuilding',$index->selectedBuilding)->first();
        //     DB::table('construction_requireds')->where('client_id',$index->client_id)->where('selectedProject',$index->selectedProject)->where('selectedBuilding',$index->selectedBuilding)->update(['paid_amount'=>0,'extra_amount'=>0,'due_amount'=>$data->required_amount]);

        // }
        DB::table('construction_pays')->where('id',$id)->delete();


    }
}

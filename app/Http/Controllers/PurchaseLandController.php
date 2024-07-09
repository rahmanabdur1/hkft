<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\PurchaseLand;
class PurchaseLandController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index = PurchaseLand::all();
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
        $PurchaseLand = new PurchaseLand;
        $PurchaseLand->land_office = $request->land_office;
        $PurchaseLand->moujar = $request->moujar;
        $PurchaseLand->thana = $request->thana;
        $PurchaseLand->district = $request->district;
        $PurchaseLand->owner_name = $request->owner_name;
        $PurchaseLand->holding_number = $request->holding_number;
        $PurchaseLand->land_class = $request->land_class;
        $PurchaseLand->ledger_no = $request->ledger_no;
        $PurchaseLand->dag_no = $request->dag_no;
        if ($request->hasFile("Supporting_docs")) {
            $file = $request->file('Supporting_docs');
            $filename = uniqid() . $file->getClientOriginalName();
            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory

            $PurchaseLand->Supporting_docs = 'documents/' . $filename;
        } else {
            $PurchaseLand->Supporting_docs = '';
        }
        $PurchaseLand->save();

        return response()->json($request);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $index = PurchaseLand::find($id);
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
        $PurchaseLand =  PurchaseLand::find($id);
        $PurchaseLand->land_office = $request->land_office;
        $PurchaseLand->moujar = $request->moujar;
        $PurchaseLand->thana = $request->thana;
        $PurchaseLand->district = $request->district;
        $PurchaseLand->owner_name = $request->owner_name;
        $PurchaseLand->holding_number = $request->holding_number;
        $PurchaseLand->land_class = $request->land_class;
        $PurchaseLand->ledger_no = $request->ledger_no;
        $PurchaseLand->dag_no = $request->dag_no;
        $PurchaseLand->save();

        return response()->json($request);

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}

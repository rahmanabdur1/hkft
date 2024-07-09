<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\StockTransfer;
use Illuminate\Support\Facades\DB;
use App\Models\Stock;
class StockTransferController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index = StockTransfer::all();
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
        $transfer = new StockTransfer();
        $transfer->product_name=$request->product_name;
        $transfer->selectedProject=$request->selectedProject;
        $transfer->quanity=$request->transferQuantity;
        $transfer->note=$request->note;
        $transfer->purpose=$request->purpose;
        $transfer->selectedBuilding=$request->selectedBuilding;
        $transfer->fromProject=$request->fromProject;
        $transfer->fromBuilding=$request->fromBuilding;
        $transfer->unit=$request->unit;
        $transfer->basic_date=$request->basic_date;
        if ($request->hasFile("Supporting_docs")) {
            $file = $request->file('Supporting_docs');
            $filename = uniqid() . $file->getClientOriginalName();
            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory

            $transfer->Supporting_docs = 'documents/' . $filename;
        } else {
            $transfer->Supporting_docs = '';
        }
        $transfer->save();

        $checkTransferTo = DB::table('stocks')->where('project',$request->selectedProject)->where('selectedBuilding',$request->selectedBuilding)->where('product_name',$request->product_name)->first();
        if($checkTransferTo){
           $productReduction = intval($request->total_quantity)-intval($request->transferQuantity);
           $productIncrement = intval($checkTransferTo->quantity)+intval($request->transferQuantity);
           $firstItem = DB::table('stocks')->where('project',$request->fromProject)->where('selectedBuilding',$request->fromBuilding)->where('product_name',$request->product_name)->where('quantity','>',0)->first();

           DB::table('stocks')->where('id',$firstItem->id)->update(['quantity'=>$productReduction]);
           DB::table('stocks')->where('project',$request->selectedProject)->where('selectedBuilding',$request->selectedBuilding)->where('product_name',$request->product_name)->update(['quantity'=>$productIncrement]);

        }else{
            $transfers = new Stock();
            $transfers->product_name=$request->product_name;
            $transfers->project=$request->selectedProject;
            $transfers->quantity=$request->transferQuantity;
            $transfers->selectedBuilding=$request->selectedBuilding;
            $transfers->item_unit = $request->unit;
            $transfers->stock_date = $request->basic_date;
            $transfers->payment_id= 'Transfered -'.$request->payment_id;
            $transfers->item_id = $request->item_id;
            $transfers->save();
            // $index = DB::table('stocks')->where('project',$request->fromProject)->where('selectedBuilding',$request->fromBuilding)->where('product_name',$request->product_name)->first();
            $productReduction = intval($request->total_quantity)-intval($request->transferQuantity);

            DB::table('stocks')->where('project',$request->fromProject)->where('selectedBuilding',$request->fromBuilding)->where('product_name',$request->product_name)->update(['quantity'=>$productReduction]);

        }
    }
    public function stock_transfer_update(Request $request){
  //
  $transfer =  StockTransfer::find($request->id);
  $transfer->product_name=$request->product_name;
  $transfer->selectedProject=$request->selectedProject;
  $transfer->quanity=$request->quanity;
  $transfer->note=$request->note;
  $transfer->purpose=$request->purpose;
  $transfer->selectedBuilding=$request->selectedBuilding;
  $transfer->fromProject=$request->fromProject;
  $transfer->fromBuilding=$request->fromBuilding;
  $transfer->unit=$request->unit;
  $transfer->basic_date=$request->basic_date;
  if ($request->hasFile("Supporting_docs")) {
      $file = $request->file('Supporting_docs');
      $filename = uniqid() . $file->getClientOriginalName();
      $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory

      $transfer->Supporting_docs = 'documents/' . $filename;
  } else {
      $transfer->Supporting_docs = '';
  }
  $transfer->save();

  $checkTransferTo = DB::table('stocks')->where('project',$request->selectedProject)->where('selectedBuilding',$request->selectedBuilding)->where('product_name',$request->product_name)->first();
  if($checkTransferTo){
     $productReduction = intval($request->total_quantity)-intval($request->quanity)+intval($request->oldQuantity);
     $productIncrement = intval($checkTransferTo->quantity)+intval($request->quanity)-intval($request->oldQuantity);
     $firstItem = DB::table('stocks')->where('project',$request->fromProject)->where('selectedBuilding',$request->fromBuilding)->where('product_name',$request->product_name)->where('quantity','>',0)->first();

     DB::table('stocks')->where('id',$firstItem->id)->update(['quantity'=>$productReduction]);
     DB::table('stocks')->where('project',$request->selectedProject)->where('selectedBuilding',$request->selectedBuilding)->where('product_name',$request->product_name)->update(['quantity'=>$productIncrement]);

  }else{
      $transfers = new Stock();
      $transfers->product_name=$request->product_name;
      $transfers->project=$request->selectedProject;
      $transfers->quantity=$request->quanity;
      $transfers->selectedBuilding=$request->selectedBuilding;
      $transfers->item_unit = $request->unit;
      $transfers->stock_date = $checkTransferTo->basic_date;
      $transfers->payment_id= 'Transfered -'.$checkTransferTo->payment_id;
      $transfers->item_id = $checkTransferTo->item_id;
      $transfers->save();
      // $index = DB::table('stocks')->where('project',$request->fromProject)->where('selectedBuilding',$request->fromBuilding)->where('product_name',$request->product_name)->first();
      $productReduction = intval($request->total_quantity)-intval($request->transferQuantity);

      DB::table('stocks')->where('project',$request->fromProject)->where('selectedBuilding',$request->fromBuilding)->where('product_name',$request->product_name)->update(['quantity'=>$productReduction]);

  }
    }
    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        return StockTransfer::find($id);
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
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $checkTransferTo = DB::table('stock_transfers')->where('id',$id)->first();
        $increaseTransferFrom = DB::table('stocks')->where('project',$checkTransferTo->fromProject)->where('selectedBuilding',$checkTransferTo->fromBuilding)->where('product_name',$checkTransferTo->product_name)->first();
        $decreaseTransferTo = DB::table('stocks')->where('project',$checkTransferTo->selectedProject)->where('selectedBuilding',$checkTransferTo->selectedBuilding)->where('product_name',$checkTransferTo->product_name)->first();


           $productIncrement = intval($increaseTransferFrom->quantity)+intval($checkTransferTo->quanity);
           $productDecrement = intval($decreaseTransferTo->quantity)-intval($checkTransferTo->quanity);
           $firstFrom = DB::table('stocks')->where('project',$checkTransferTo->fromProject)->where('selectedBuilding',$checkTransferTo->fromBuilding)->where('product_name',$checkTransferTo->product_name)->first();
           DB::table('stocks')->where('id',$firstFrom->id)->update(['quantity'=>$productIncrement]);
           $secondTo= DB::table('stocks')->where('project',$checkTransferTo->selectedProject)->where('selectedBuilding',$checkTransferTo->selectedBuilding)->where('product_name',$checkTransferTo->product_name)->first();
           DB::table('stocks')->where('id',$secondTo->id)->update(['quantity'=>$productDecrement]);
           DB::table('stock_transfers')->where('id',$id)->delete();

        if(intval($productDecrement)==0){
            DB::table('stocks')->where('id',$secondTo->id)->delete();
            return response()->json($secondTo);

        }

    }
}

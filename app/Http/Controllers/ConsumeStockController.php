<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\ConsumeStock;
use App\Models\StockJournal;
use App\Models\Notification;
class ConsumeStockController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index = ConsumeStock::all();


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
        //store in consume stock


        $index = DB::table('notifications')->latest('created_at')->first();

           if($index){
                $notification = array();
                $notification['notification'] = intval($index->notification)+ intval($request->notification);
                DB::table('notifications')->latest('created_at')->where('id',$index->id)->update($notification);
           }else{
             $notification = new Notification;
            $notification->notification = intval($request->notification);
            $notification->save();
           }

        $stock = new ConsumeStock;
        $stock->product_name = $request->product_name;
        $stock->selectedProject = $request->selectedProject;
        $stock->building_name = $request->selectedBuilding;
        $stock->basic_date = $request->basic_date;

        $stock->Description = $request->Description;
        $stock->consumeQuantity = $request->consumeQuantity;
        $stock->save();
        //update stock journal
        $remainStock = intval($request->total_quantity) - intval($request->consumeQuantity);
        DB::table('stocks')->where('product_name',$request->product_name)->where('project',$request->selectedProject)->where('selectedBuilding',$request->selectedBuilding)->update(['quantity'=>$remainStock]);
            return response()->json($request->notification);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $index = ConsumeStock::find($id);
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
          //store in consume stock
          $stock =  ConsumeStock::find($id);
          $stock->product_name = $request->product_name;
          $stock->selectedProject = $request->selectedProject;
          $stock->Description = $request->Description;
          $stock->building_name = $request->selectedBuilding;
          $stock->basic_date = $request->basic_date;

          $stock->consumeQuantity = $request->consumeQuantity;
          $stock->save();
          //update prev product name stock journal
          $old_Product_Stock  = DB::table('stocks')->where('project',$request->oldSelectedProject)->where('selectedBuilding',$request->oldSelectedBuilding)->where('product_name',$request->old_product_name)->first();
          $remainStock1 = intval($old_Product_Stock->quantity) + intval($request->old_consumeQuantity);
          DB::table('stocks')->where('project',$request->oldSelectedProject)->where('selectedBuilding',$request->oldSelectedBuilding)->where('product_name',$request->old_product_name)->update(['quantity'=>$remainStock1]);
          //update stock journal
          $new_Product_Stock  = DB::table('stocks')->where('project',$request->selectedProject)->where('selectedBuilding',$request->selectedBuilding)->where('product_name',$request->product_name)->first();
            if($request->old_product_name != $request->product_name){
                $remainStock = $new_Product_Stock->quantity - intval($request->consumeQuantity);
                $index = DB::table('stocks')->where('project',$request->selectedProject)->where('selectedBuilding',$request->selectedBuilding)->where('product_name',$request->product_name)->update(['quantity'=>$remainStock]);
                return response()->json($index);
            }else{
                $remainStock = $remainStock1 - intval($request->consumeQuantity);
                DB::table('stocks')->where('project',$request->selectedProject)->where('selectedBuilding',$request->selectedBuilding)->where('product_name',$request->product_name)->update(['quantity'=>$remainStock]);

            }
          return response()->json($request);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //product in requisition
        $getProduct = DB::table('consume_stocks')->where('id',$id)->first();
        $getProductName = $getProduct->product_name;
        $productConsumedQty = $getProduct->consumeQuantity;

        //product from stock journal
        $getStockProduct = DB::table('stocks')->where('product_name',$getProductName)->where('project',$getProduct->selectedProject)->where('selectedBuilding',$getProduct->building_name)->first();
        if($getStockProduct){
            $stockTotal = $getStockProduct->quantity;
            $backPrevState = intval($stockTotal) + intval($productConsumedQty);

            //delete requisition
            DB::table('consume_stocks')->where('id',$id)->delete();

            //update stock journal
            DB::table('stocks')->where('project',$getProduct->selectedProject)->where('selectedBuilding',$getProduct->building_name)->where('product_name',$getProductName)->update(['quantity'=>$backPrevState]);
            return response()->json($backPrevState);

        }else{
             //delete requisition
             DB::table('consume_stocks')->where('id',$id)->delete();
        }
    }
}

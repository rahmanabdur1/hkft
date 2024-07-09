<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Inventory;
use Illuminate\Support\Facades\DB;
class InventoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index =Inventory::all();
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
        $inventory = new Inventory;
        $inventory->property_name = $request->property_name;
        $inventory->location = $request->location;
        if($request->property_project){
            $inventory->property_project = $request->property_project;
        }else{
            $inventory->property_project = "";
        }
        $inventory->property_amount = $request->property_amount;
        $inventory->property_type = $request->property_type;
        $inventory->sub_property_type = $request->sub_property_type;
        $inventory->property_id = $request->property_id;
        $inventory->squareft = $request->squareft;
        $inventory->property_status = $request->property_status;
        $inventory->property_details = $request->property_details;
        $inventory->building_name = $request->building_name;
        $inventory->size = $request->size;
        $inventory->daag_no = $request->daag_no;
        $inventory->sub_property_id = $request->sub_property_id;
        if($request->floor_level){
            $inventory->floor_level = $request->floor_level;
        }else{
            $inventory->floor_level = "";
        }
        $checkInventory = DB::table('inventories')->where('property_project',$request->property_project)->where('property_type',$request->property_type)->where('property_name',$request->property_name)->where('sub_property_type',$request->sub_property_type)->first();
        if($checkInventory){
            $exist = "This record has already exists!";
            return response()->json(['exist'=>$exist]);
        }
        else{
            $inventory->save();
        return response()->json($inventory);
        }
    }

    public function building(Request $request){
        $request->validate([
            'property_project'=>'required',
            'selectedBuilding'=>'required',
            'flat.*'=>'required',
        ]);
        $length = count($request->flat);
       if($length>0){
        $count = 0;
        $floor = $request->floor;
        for($f=1;$f<=$floor;$f++){
            for($i = 0;$i<$length;$i++){
                $count++;
                $inventory = new Inventory;
                $inventory->property_name = $f.$request->flat[$i];
                $inventory->property_details = $request->property_details[$i];
                $inventory->size = $request->flat_size[$i];
                $inventory->location = $request->location;
                if($request->property_project){
                    $inventory->property_project = $request->property_project;
                }else{
                    $inventory->property_project = "";
                }
                $inventory->property_type = 'Building';
                $inventory->sub_property_type = 'flat';
                $inventory->property_id = $request->property_id;
                $inventory->squareft = $request->squareft;
                $inventory->property_status = "Available";
                $inventory->building_name = $request->selectedBuilding;
                // random unique sub property
                $characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
                $charactersLength = strlen($characters);
                $randomString = '';
                for ($j = 0; $j < 4; $j++) {
                    $randomString .= $characters[rand(0, $charactersLength - 1)];
                }
                $numbers = '0123456789';
                $numbersLength = strlen($numbers);
                $randomNumber = '';
                for ($k = 0; $k < 6; $k++) {
                    $randomNumber .= $numbers[rand(0, $numbersLength - 1)];
                }
               
                $inventory->sub_property_id =  $randomString."-". $randomNumber;
                $property = $randomString."-". $randomNumber;
              
                // end
                $inventory->floor_level = $f;
                $inventory->property_amount = $request->property_amount;
                $checkInventory = DB::table('inventories')->where('property_name',$request->floor.$request->flat[$i])->where('sub_property_type',$property)->first();
               
                if($checkInventory){
                    $exist = "This record has already exists!";
                    return response()->json(['exist'=>$exist]);
                }
                else{
                      $inventory->save();
               
                }
              
            }
        }
     
       }else{
        return response()->json(["errors" => "Create Flat Name"],);
       }
        return response()->json("Success");
    }
    public function fetch_property($building){
        return DB::table('inventories')->where('building_name',$building)->get();
    }
    public function sales_fetch_flat_name($flat){
        return DB::table('inventories')->where('property_name',$flat)->get();

    }
    public function fetch_sales_project_report($buildiing){
        $data = DB::table('inventories')->where('building_name',$buildiing)->where('property_type','Building')->orderByRaw('building_name,CAST(floor_level AS UNSIGNED), property_name')->get();
        return response()->json($data);
    }
    public function fetch_sales_project_report_floor($buildiing){
        $data = DB::table('inventories')->where('building_name',$buildiing)->where('property_type','Building')->select('floor_level')->groupBy('floor_level')->get();
        return response()->json($data);
    }
    public function fetch_sales_project_report_floor_name($buildiing){
        $collection = DB::table('inventories')->where('building_name',$buildiing)->where('property_type','Building')->get();
        $data = $collection->map(function($item){
              $flat = $item->property_name;
              $count = strlen($flat);
              $item->flat_name = $flat[$count-1];
              return ['id'=>$item->id,'flat_name'=>$item->flat_name];
            })->unique('flat_name')->values()->toArray();
        return response()->json($data);
    }

    public function sales_project(){
        return DB::table('inventories')->where('property_type','Building')->get();
    }
    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $index = Inventory::find($id);
        return response()->json($index);
    }
    public function modifySales(Request $request){
        // $info = DB::table('inventories')->where('id',$request->id)->where('property_status','Available')->first();
        // $checkInReceipt = DB::table('receipt_vouchers')->where('sub_property_id',$info->sub_property_id)->first();
        // if($checkInReceipt){
        //     DB::table('receipt_vouchers')->where('sub_property_id',$info->sub_property_id)->update(['product_amount'=>$request->amount,'due'=>intval($request->amount)-intval($checkInReceipt->total_amount)]);
        // }
        $data = DB::table('inventories')->where('id',$request->id)->where('property_status','Available')->update(['property_amount'=>$request->amount]);
        return response()->json($data);
    }
    
    public function addSales(Request $request){
        $update= DB::table('inventories')->where('id',$request->id)->update(['add_money'=>$request->amount]);

        $data = DB::table('inventories')->where('id',$request->id)->where('property_status','Sold')->first();
       if($data){
        $cons = DB::table('construction_requiredes')->where('client_name',$data->owner)->where('selectedBuilding',$data->building_name)->first();
        if($cons){
            $amount = $cons->required_amount+$request->amount;
        }
        DB::table('construction_requiredes')->where('client_name',$data->owner)->where('selectedBuilding',$data->building_name)->update(['required_amount'=>$amount,'add_money'=>$request->amount]);
       }
       
        return response()->json($update);
    }
    
    public function lessSales(Request $request){
        $update= DB::table('inventories')->where('id',$request->id)->update(['less_money'=>$request->amount]);

        $data = DB::table('inventories')->where('id',$request->id)->where('property_status','Sold')->first();
       if($data){
        $cons = DB::table('construction_requiredes')->where('client_name',$data->owner)->where('selectedBuilding',$data->building_name)->first();
        if($cons){
            $amount = $cons->required_amount-$request->amount;
        }
        DB::table('construction_requiredes')->where('client_name',$data->owner)->where('selectedBuilding',$data->building_name)->update(['required_amount'=>$amount,'less_money'=>$request->amount]);
       }
       
        return response()->json($update);
    }
    public function sales_fetch_project($project){
        return  DB::table('inventories')->where('property_project',$project)->get();
    }
    public function fetchAllProject(){
        return DB::table('inventories')->select('property_project')->groupBy('property_project')->get();
    }
    public function sales_fetch_building($project){
        return DB::table('inventories')->where('property_project',$project)->select('building_name')->groupBy('building_name')->get();

    }
    public function sales_fetch_project_building($building){
        return  DB::table('inventories')->where('building_name',$building)->get();

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
        $inventory =  Inventory::find($id);
        $inventory->property_name = $request->property_name;
        $inventory->location = $request->location;
        if($request->property_project){
            $inventory->property_project = $request->property_project;
        }else{
            $inventory->property_project = "";
        }
        $inventory->property_amount = $request->property_amount;
        $inventory->property_type = $request->property_type;
        $inventory->sub_property_type = $request->sub_property_type;
        $inventory->property_id = $request->property_id;
        $inventory->squareft = $request->squareft;
        $inventory->property_status = $request->property_status;
        $inventory->property_details = $request->property_details;
        $inventory->building_name = $request->building_name;
        $inventory->size = $request->size;
        if($request->floor_level){
            $inventory->floor_level = $request->floor_level;
        }else{
            $inventory->floor_level = "";
        }

            $inventory->save();

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}

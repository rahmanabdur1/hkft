<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\ConstructionRequired;
class ConstructionRequiredController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index= DB::table('construction_requireds')->where('select_type','one')->get();
        return response()->json($index);
    }
    public function constructionOne($project){
        // $index= DB::table('construction_requireds')->where('select_type','one')->where('selectedProject',$project)->get();
        // return response()->json($index);
        $collection= DB::table('construction_requireds')->join('clients','construction_requireds.client_id','=','clients.client_id')->where('select_type','one')->where('selectedProject',$project)->select(DB::raw('MIN(construction_requireds.id) as id'),DB::raw('GROUP_CONCAT(construction_requireds.selectedProject) as selectedProject'),DB::raw('GROUP_CONCAT(construction_requireds.selectedBuilding) as selectedBuilding'),DB::raw('GROUP_CONCAT(construction_requireds.due_date) as due_date'),DB::raw('GROUP_CONCAT(construction_requireds.share) as share'),DB::raw('GROUP_CONCAT(construction_requireds.client_name) as client_name'),DB::raw('MIN(construction_requireds.basic_date) as basic_date'),DB::raw('MIN(construction_requireds.construction_id) as construction_id'),DB::raw('MIN(construction_requireds.required_amount) as required_amount'),DB::raw('MIN(construction_requireds.client_id) as client_id'),DB::raw('GROUP_CONCAT(clients.phone) as phone'))->groupBy('construction_id')->orderBy('id','DESC')->get();
        $indexes = $collection->filter(function($item){
            $paidData = DB::table('construction_pays')->where('construction_id',$item->construction_id)->sum('paid_amount');
             if($item->required_amount > $paidData){
                $item->due = $item->required_amount- $paidData;
                return $item;
             }
         })->values();
        return response()->json($collection);
    }

    public function constructionAll($project){
        $index= DB::table('construction_requireds')->where('select_type','all')->where('selectedProject',$project)->whereIn('id',function($query){
            $query->select(DB::raw('MIN(id)'))->from('construction_requireds')->groupBy('construction_id');
        })->get();
        return response()->json($index);
    }
   public function mergeConstruction(){
    $index = DB::table('construction_requireds')->where('select_type','all')
        ->whereIn('id',function($query){
            $query->select(DB::raw('MIN(id)'))->from('construction_requireds')->where('client_name','!=',null)->groupBy('construction_id');
        })
        ->get();

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


        //
        if($request->all_client=='all'){
            $allclients = DB::table('clients')->where('clientUnderProject',$request->selectedProject)->where('selectedBuilding',$request->selectedBuilding)->get();
            foreach($allclients as $cl){
                //

                        $construction = new ConstructionRequired;
                        $construction->basic_date = $request->basic_date;
                        $construction->selectedProject = $request->selectedProject;
                        $construction->selectedBuilding = $request->selectedBuilding;
                        $client = $cl->client_id;
                        $fetchShare = DB::table('clients')->where('client_id',$client)->select('share')->first();
                        $construction->share =$fetchShare->share;
                        $construction->required_amount = intval($request->amount) * floatval($fetchShare->share);
                        $construction->paid_amount = 0;
                        $construction->due_amount = 0;
                        $construction->extra_amount = 0;

                        $construction->construction_id =$request->construction_id;
                        $construction->select_type ="all";

                        $construction->client_name = $cl->name;
                        $construction->client_id =$cl->client_id;
                        $construction->due_date = $request->due_date;
                        $construction->note = $request->note;
                        $construction->save();

            }
        }else if($request->all_client==''){

                $construction = new ConstructionRequired;
                $construction->basic_date = $request->basic_date;
                $construction->selectedProject = $request->selectedProject;
                $construction->selectedBuilding = $request->selectedBuilding;
                $fetchShare = DB::table('clients')->where('client_id',$request->client_id)->select('share')->first();
                $construction->share =$fetchShare->share;

                $construction->required_amount = intval($request->amount) * floatval($fetchShare->share);
                $construction->paid_amount = 0;
                $construction->due_amount = 0;
                $construction->extra_amount = 0;

                $construction->construction_id =$request->construction_id;
                $construction->select_type ="one";

                $construction->client_name = $request->client_name;
                $construction->client_id =$request->client_id;
                $construction->due_date = $request->due_date;
                $construction->note = $request->note;

                $construction->save();

                return response()->json( $construction->required_amount);

        }



    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $construction = ConstructionRequired::find($id);
        return response()->json($construction);
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
        if($request->all_client=='all'){
            $allclients = $request->clients;
            foreach($allclients as $cl){
                $construction =  ConstructionRequired::find($id);
                $construction->basic_date = $request->basic_date;
                $construction->selectedProject = $request->selectedProject;
                $construction->selectedBuilding = $request->selectedBuilding;
                $client = $cl->client_id;
                $fetchShare = DB::table('clients')->where('client_id',$client)->select('share')->first();
                $construction->share =$fetchShare->share;

                $construction->required_amount = intval($request->required_amount) * intval($fetchShare->share);
                $construction->paid_amount = 0;
                $construction->due_amount = 0;
                $construction->extra_amount = 0;
                $construction->note = $request->note;

                $construction->client_name = $cl['name'];
                $construction->client_id =$cl['client_id'];
                $construction->due_date = $request->due_date;

                $construction->save();

            }
        }else if($request->all_client==''){
            $construction = ConstructionRequired::find($id);
            $construction->basic_date = $request->basic_date;
            $construction->selectedProject = $request->selectedProject;
            $construction->selectedBuilding = $request->selectedBuilding;
            $fetchShare = DB::table('clients')->where('client_id',$request->client_id)->select('share')->first();
            $construction->share =$fetchShare->share;

            $construction->required_amount = intval($request->required_amount)*intval($fetchShare->share);
            $construction->paid_amount = 0;
            $construction->due_amount =0;
            $construction->extra_amount = 0;
            $construction->note = $request->note;

            $construction->due_date = $request->due_date;

            $construction->client_name = $request->client_name;
            $construction->client_id =$request->client_id;

            $construction->save();
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $index = DB::table('construction_requireds')->where('id',$id)->first();
        DB::table('construction_pays')->where('construction_id',$index->construction_id)->delete();
    //  DB::table('construction_pays')->where('client_id',$index->client_id)->where('selectedProject',$index->selectedProject)->where('selectedBuilding',$index->selectedBuilding)->delete();
        //  $getConstructionId = DB::table('construction_pays')->where('construction_id',$index->construction_id)->first();
     DB::table('construction_requireds')->where('id',$id)->delete();
        // return response()->json($getConstructionId);
    }
}

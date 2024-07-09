<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

use App\Models\Client;
use Illuminate\Support\Facades\Validator;
use Image;
class ClientInfoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $clients = Client::all();

        return response()->json($clients);
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
        $validator = Validator::make($request->all(), [
            'clientUnderProject'=> 'required|min:2',
            'name'=>'required',
            'phone' =>'required',

        ],
    [
        'birth_date.before' => 'The birthdate cannot be today\'s date.',
        'clientUnderProject.required' => 'Please select project',
        'name.required' => 'The name is required',

    ]);
       if($validator->fails()){
        return response()->json($validator->errors()->toJson(),400);
       }
            //nid image
            $client = new Client();
            $image = $request->nid_img;// abc/jpg;dfdsfsa
           if($image){
            $index_position = strpos($image,';');
            $substr = substr($image,0,$index_position);
            $ext = explode('/',$substr)[1];
            $uniqueName = hexdec(uniqid()).".".$ext;
            $imgFile = Image::make($image);
            $upload_path = 'AdminPanel/img/';
            $imageUrl = $upload_path.$uniqueName;
            $imgFile->save($imageUrl);
            $client->nid_img = $imageUrl;

           }

             //passport image
             $image1 = $request->passport_img;// abc/jpg;dfdsfsa
             if($image1){
                $index_position1 = strpos($image1,';');
                $substr1 = substr($image1,0,$index_position1);
                $ext1 = explode('/',$substr1)[1];
                $uniqueName1 = hexdec(uniqid()).".".$ext1;
                $imgFile1 = Image::make($image1);
                $upload_path1 = 'AdminPanel/img/';
                $imageUrl1 = $upload_path1.$uniqueName1;
                $imgFile1->save($imageUrl1);
                $client->passport_img = $imageUrl1;

             }else{
                $client->passport_img = "";

             }



            //tin image

             $image2 = $request->tin_img;// abc/jpg;dfdsfsa
             if($image2){
                $index_position2 = strpos($image2,';');
                $substr2 = substr($image2,0,$index_position2);
                $ext2 = explode('/',$substr2)[1];
                $uniqueName2 = hexdec(uniqid()).".".$ext2;
                $imgFile2 = Image::make($image2);
                $upload_path2 = 'AdminPanel/img/';
                $imageUrl2 = $upload_path2.$uniqueName2;
                $imgFile2->save($imageUrl2);
                $client->tin_img = $imageUrl2;
             }else{
                $client->tin_img = "";
             }

             $image3 = $request->profile_photos;// abc/jpg;dfdsfsa
             if($image3){
                $index_position3 = strpos($image3,';');
                $substr3 = substr($image3,0,$index_position3);
                $ext3 = explode('/',$substr3)[1];
                $uniqueName3 = hexdec(uniqid()).".".$ext3;
                $imgFile3 = Image::make($image3);
                $upload_path3 = 'AdminPanel/img/';
                $imageUrl3 = $upload_path3.$uniqueName3;
                $imgFile3->save($imageUrl3);
                $client->profile_photos = $imageUrl3;
             }else{
                $client->profile_photos = "";
             }

           
            $client->name = $request->name;
            $client->father_name = $request->input("father_name","");
            $client->mother_name = $request->input("mother_name","");
            $client->husban_wife_name = $request->input("husban_wife_name","");
            $client->birth_date = $request->input("birth_date","");
            $client->religion = $request->input("religion","");
            $client->occupation = $request->input("occupation","");
            $client->nationality = $request->input("nationality","");
            $client->national_id_no = $request->input("national_id_no","");
            $client->permanent_location = $request->input("permanent_location","");
            $client->permanent_post_office = $request->input("permanent_post_office","");
            $client->permanent_thana = $request->input("permanent_thana","");
            $client->permanent_district = $request->input("permanent_district","");
            $client->temprorary_location = $request->input("temprorary_location","");
            $client->temprorary_post_office = $request->input("temprorary_post_office","");
            $client->temprorary_thana = $request->input("temprorary_thana","");
            $client->temprorary_district = $request->input("temprorary_district","");
            $client->tin = $request->input("tin","");
            $client->phone = $request->phone;
            $client->email = $request->input("email","");
            $client->client_id = $request->client_id;
            $client->clientUnderProject = $request->clientUnderProject;
            $client->selectedBuilding = $request->selectedBuilding;
            $client->share  = $request->share;
            $client->save();
            return response()->json($client);





    }
    public function storeExist(Request $request){
            $client = new Client();
            $client->name = $request->name;
            $client->father_name = $request->input("father_name") ==='null' ? "" : $request->input("father_name");
            $client->mother_name = $request->input("mother_name")  ==='null' ? "" :$request->input("mother_name");
            $client->husban_wife_name = $request->input("husban_wife_name")  ==='null' ? "" :$request->input("husban_wife_name");
            $client->birth_date = $request->input("birth_date")  ==='null' ? "" :$request->input("birth_date");
            $client->religion = $request->input("religion")  ==='null' ? "" :$request->input("religion");
            $client->occupation = $request->input("occupation")  ==='null' ? "" :$request->input("occupation");
            $client->nationality = $request->input("nationality")  ==='null' ? "" : $request->input("nationality");
            $client->national_id_no = $request->input("national_id_no")  ==='null' ? "" :$request->input("national_id_no");
            $client->permanent_location = $request->input("permanent_location")  ==='null' ? "" :$request->input("permanent_location");
            $client->permanent_post_office = $request->input("permanent_post_office")  ==='null' ? "" :$request->input("permanent_post_office");
            $client->permanent_thana = $request->input("permanent_thana")  ==='null' ? "" :$request->input("permanent_thana")  ==='null';
            $client->permanent_district = $request->input("permanent_district")  ==='null' ? "" :$request->input("permanent_district") ;
            $client->temprorary_location = $request->input("temprorary_location")  ==='null' ? "" :$request->input("temprorary_location");
            $client->temprorary_post_office = $request->input("temprorary_post_office")  ==='null' ? "" :$request->input("temprorary_post_office") ;
            $client->temprorary_thana = $request->input("temprorary_thana")  ==='null' ? "" : $request->input("temprorary_thana") ;
            $client->temprorary_district = $request->input("temprorary_district")  ==='null' ? "" : $request->input("temprorary_district") ;
            $client->tin = $request->input("tin")  ==='null' ? "" :  $request->input("tin")  ==='null';
            $client->phone = $request->phone;
            $client->email = $request->input("email")  ==='null' ? "" : $request->input("email") ;
            $client->nid_img = $request->nid_img;
            $client->tin_img = $request->tin_img;
            $client->passport_img = $request->passport_img;
            $client->clientUnderProject = $request->clientUnderProject;
            $client->profile_photos = $request->profile_photos;
            $client->client_id = $request->client_id;
            $client->selectedBuilding = $request->selectedBuilding;
            $client->share  = $request->share;

            $client->save();
            return response()->json($client);
    }
    public function getProjectFromClientInfo($client_nid){
        $nid = $client_nid;

        $getProject = DB::table('clients')->select('clients.clientUnderProject')->where('client_id',$nid)->distinct()->get();
        return response()->json($getProject);
    }

    public function getClientInfo($client_id){
        $id = $client_id;
        $getClient = DB::table('clients')->select('clients.*')->where('client_id',$id)->first();
        return response()->json($getClient);
    }
    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $client = Client::find($id);
        return response()->json($client);
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
    public function updateClient(Request $request){

        $client = array();
        $client['name']= $request->name;
        $client['father_name']= $request->father_name;
        $client['mother_name']= $request->mother_name;
        $client['husban_wife_name']= $request->husban_wife_name;
        $client['religion']= $request->religion;
        $client['birth_date']= $request->birth_date;
        $client['occupation']= $request->occupation;
        $client['email']= $request->email;
        $client['phone']= $request->phone;
        $client['tin']= $request->tin;
        $client['nationality']= $request->nationality;
        $client['national_id_no']= $request->national_id_no;
        $client['permanent_location']= $request->permanent_location;
        $client['permanent_post_office']= $request->permanent_post_office;
        $client['permanent_thana']= $request->permanent_thana;
        $client['permanent_district']= $request->permanent_district;
        $client['temprorary_location']= $request->temprorary_location;
        $client['temprorary_post_office']= $request->temprorary_post_office;
        $client['temprorary_thana']= $request->temprorary_thana;
        $client['temprorary_district']= $request->temprorary_district;
        $client['clientUnderProject']= $request->clientUnderProject;
        $client['client_id']= $request->client_id;
        $client['selectedBuilding'] = $request->selectedBuilding;
        $client['share']  = $request->share;

        $imgNid= $request->new_nid_img;
        if($imgNid){
            $index_position = strpos($imgNid,';');
            $substr = substr($imgNid,0,$index_position);
            $ext = explode('/',$substr)[1];
            $uniqueName = hexdec(uniqid()).".".$ext;
            $img = Image::make($imgNid);
            $path = 'AdminPanel/img/';
            $imgUrl = $path.$uniqueName;
            $imgSave = $img->save($imgUrl);
                if($imgSave){
                    $client['nid_img'] = $imgUrl;
                    $database_photo = DB::table('clients')->where('id',$request->id)->first();
                   if($database_photo->nid_img){
                    $old_photo = $database_photo->nid_img;
                   if(file_exists($old_photo)){
                    unlink($old_photo);
                   }
                   }


                }
        }else{
            $old_photo = $request->nid_img;
            $client['nid_img'] = $old_photo;

        }

        //passport
        $imgPassport= $request->new_passport_img;
        if($imgPassport){
            $index_position = strpos($imgPassport,';');
            $substr = substr($imgPassport,0,$index_position);
            $ext = explode('/',$substr)[1];
            $uniqueName = hexdec(uniqid()).".".$ext;
            $img = Image::make($imgPassport);
            $path = 'AdminPanel/img/';
            $imgUrl = $path.$uniqueName;
            $imgSave = $img->save($imgUrl);
                if($imgSave){
                    $client['passport_img'] = $imgUrl;
                    $database_photo = DB::table('clients')->where('id',$request->id)->first();
                   if($database_photo->passport_img){
                    $old_photo = $database_photo->passport_img;
                    if(file_exists($old_photo)){
                        unlink($old_photo);
                       }
                   }


                }
        }else{
            $old_photo = $request->passport_img;
            $client['passport_img'] = $old_photo;

        }

        //tin
        $imgTin= $request->new_tin_img;
        if($imgTin){
            $index_position = strpos($imgTin,';');
            $substr = substr($imgTin,0,$index_position);
            $ext = explode('/',$substr)[1];
            $uniqueName = hexdec(uniqid()).".".$ext;
            $img = Image::make($imgTin);
            $path = 'AdminPanel/img/';
            $imgUrl = $path.$uniqueName;
            $imgSave = $img->save($imgUrl);
                if($imgSave){
                    $client['tin_img'] = $imgUrl;
                    $database_photo = DB::table('clients')->where('id',$request->id)->first();
                   if($database_photo->tin_img){
                    $old_photo = $database_photo->tin_img;
                    if(file_exists($old_photo)){
                        unlink($old_photo);
                       }
                   }


                }
        }else{
            $old_photo = $request->tin_img;
            $client['tin_img'] = $old_photo;

        }
        //profile photo
        $imgProfile= $request->new_profile_photos;
        if($imgProfile){
            $index_position = strpos($imgProfile,';');
            $substr = substr($imgProfile,0,$index_position);
            $ext = explode('/',$substr)[1];
            $uniqueName = hexdec(uniqid()).".".$ext;
            $img = Image::make($imgProfile);
            $path = 'AdminPanel/img/';
            $imgUrl = $path.$uniqueName;
            $imgSave = $img->save($imgUrl);
                if($imgSave){
                    $client['profile_photos'] = $imgUrl;
                    $database_photo = DB::table('clients')->where('id',$request->id)->first();
                   if($database_photo->profile_photos){
                    $old_photo = $database_photo->profile_photos;
                    if(file_exists($old_photo)){
                        unlink($old_photo);
                       }
                   }


                }
        }else{
            $old_photo = $request->profile_photos;
            $client['profile_photos'] = $old_photo;

        }


        $getConstruction = DB::table('construction_requireds')->where('client_id',$request->client_id)->where('selectedBuilding',$request->selectedBuilding)->get();
        $getConstruction->map(function ($item) use($request){
            $newShare = $request->share;
            $newRequired_amount = intval($request->share) * $item->required_amount;
            DB::table('construction_requireds')->where('id',$item->id)->update([
                'share'=>$newShare,
                'required_amount'=>$newRequired_amount,
            ]);
        });
        $user =DB::table('clients')->where('id',$request->id)->update($client);
        return response()->json($client);
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
    }
}

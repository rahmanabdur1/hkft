<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

use JWTAuth;
use Auth;
use Tymon\JWTAuth\Exceptions\JWTException;
use App\Models\Manager;

class ManagerUserController extends Controller
{
    public function __construct(){
        \Config::set('auth.defaults.guard','manager');
    }
    public function authenticate(Request $request)
    {
        $credentials = $request->only('username', 'password');

        try {
            if (! $token = JWTAuth::attempt($credentials,['guard' => 'manager'])) {
                return response()->json(['error' => 'invalid_credentials'], 400);
            }
        } catch (JWTException $e) {
            return response()->json(['error' => 'could_not_create_token'], 500);
        }
        $getUser = Manager::where('username',$request->username)->first();
        $guard = $getUser->guard;
        $username  = $getUser->username;
        return response()->json(compact('token','username','guard'));
    }

    public function register(Request $request)
    {
            $validator = Validator::make($request->all(), [
            'username' => 'required|string|min:4|unique:managers,username',
            'email'=>'required|string|max:40|unique:managers,email',
            'password' => 'required|string|min:6',
        ]);

        if($validator->fails()){
                return response()->json($validator->errors()->toJson(), 400);
        }
        $existUser = DB::table('admins')->where('username',$request->username)->exists();
        if(!$existUser){
            $user = Manager::create([
                'username' => $request->get('username'),
                'email'=>$request->get('email'),
                'password' => Hash::make($request->get('password')),
            ]);
            $getUser= Manager::where('email',$request->email)->first();
            $username= $getUser->username;
    
            $token = JWTAuth::fromUser($user);
            $guard = $getUser->guard;
            return response()->json(compact('username','token','guard'),201);
        }
       
    }

    public function getAuthenticatedUser()
        {
                try {

                        if (! $user = JWTAuth::parseToken()->authenticate()) {
                                return response()->json(['user_not_found'], 404);
                        }

                } catch (Tymon\JWTAuth\Exceptions\TokenExpiredException $e) {

                        return response()->json(['token_expired'], $e->getStatusCode());

                } catch (Tymon\JWTAuth\Exceptions\TokenInvalidException $e) {

                        return response()->json(['token_invalid'], $e->getStatusCode());

                } catch (Tymon\JWTAuth\Exceptions\JWTException $e) {

                        return response()->json(['token_absent'], $e->getStatusCode());

                }

                return response()->json(compact('user'));
        }
        public function logout()
        {
            auth()->logout();
    
            return response()->json(['message' => 'Successfully logged out']);
        }
}
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

use Illuminate\Support\Facades\Validator;
use JWTAuth;
use Auth;
use Tymon\JWTAuth\Exceptions\JWTException;
use App\Models\Admin;

    class UserController extends Controller
    {
        public function __construct(){
            \Config::set('auth.defaults.guard','admin');
        }
        public function authenticate(Request $request)
        {
            $credentials = $request->only('username', 'password');

            try {
                if (! $token = JWTAuth::attempt($credentials,['guard' => 'admin'])) {
                    return response()->json(['error' => 'Invalid Username or Password'], 400);
                }
            } catch (JWTException $e) {
                return response()->json(['error' => 'could_not_create_token'], 500);
            }
            $getUser = Admin::where('username',$request->username)->first();
            $guard = $getUser->guard;
            $username  = $getUser->username;
            return response()->json(compact('username','token','guard'));
        }

        public function register(Request $request)
        {
                $validator = Validator::make($request->all(), [
                'username'=>'required|string|min:4|unique:admins,username',
                'email' => 'required|string|max:255|unique:admins,email',
                'password' => 'required|string|min:6',
            ]);

            if($validator->fails()){
                    return response()->json($validator->errors()->toJson(), 400);
            }
            $existUser = DB::table('managers')->where('username',$request->username)->exists();
            if(!$existUser){
                $user = Admin::create([
                    'username'=>$request->get('username'),
                    'email' => $request->get('email'),
                    'password' => Hash::make($request->get('password')),

                ]);
            
                $getUser= Admin::where('email',$request->email)->first();
                $username= $getUser->username;
                $token = JWTAuth::fromUser($user);
                $guard = $getUser->guard;
                if($user){
                    return response()->json(compact('username','token','guard'),201);
                }
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
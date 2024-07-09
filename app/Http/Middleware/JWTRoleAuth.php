<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Tymon\JWTAuth\Facades\JWTAuth;
class JWTRoleAuth
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle($request, Closure $next, $role=null)
    {
        try {
           $token_role=$this->auth->parseToken()->getClaim('role');
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }
        if($token_role !=$role){
            return response()->json(['error' => 'Unauthorized'], 401);
        }
        return $next($request);
    }
}

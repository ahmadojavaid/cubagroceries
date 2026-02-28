<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureUserIsRider
{
    public function handle(Request $request, Closure $next): Response
    {
        if (! $request->user() || $request->user()->role !== 'rider') {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized. Rider access only.',
            ], 403);
        }

        return $next($request);
    }
}

<?php

namespace App\Domain\Controllers;
use App\Domain\Resources\UserResource;
use App\Domain\Rules\PhoneRule;
use App\Domain\Services\AuthService;
use Illuminate\Http\Request;

class AuthController extends BaseController
{
    protected $resource = UserResource::class;
    /**
     * @var AuthService
     */
    protected $service = AuthService::class;

    // TODO: Implement the login method
    public function login(Request $request)
    {
        if (! $token = auth()->attempt(request(['email', 'password']))) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return $this->respondWithToken($token);
    }

    /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function me()
    {
        return response()->json(auth()->user());
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'Successfully logged out']);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken(auth()->refresh());
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token)
    {
        return response()->json([
            'token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60
        ]);
    }

    protected function register(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
            'first_name' => 'required',
            'last_name' => 'required',
            'phone' => ['nullable', new PhoneRule],
        ]);

        return $this->service->create($request->all());
    }
}
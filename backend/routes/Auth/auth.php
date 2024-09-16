<?php

use App\Domain\Controllers\AuthController;
use Illuminate\Support\Facades\Route;

Route::post('/register', 'AuthController@register')->name('register');

Route::post('login', 'AuthController@login')->name('login');
Route::post('logout', 'AuthController@logout')->name('logout');
Route::post('refresh', 'AuthController@refresh')->name('refresh');
Route::post('me', 'AuthController@me')->name('me');
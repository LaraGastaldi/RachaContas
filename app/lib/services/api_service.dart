import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rachacontas/services/env_service.dart';

class ApiService {
  Future<Response> fetch(String uri,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      String method = 'GET',
      bool retry = false}) async {
    try {
      log('Fetching $uri', name: 'API Request');
      final response = await Dio().request(
        "${await EnvService.get('API_URL')}/$uri",
        queryParameters: queryParameters,
        data: data,
        options: Options(
          method: method,
          validateStatus: (status) {
            return status! < 500;
          },
          contentType: Headers.jsonContentType,
          headers: {
            'Accept-Language': const Locale('pt', 'BR').toLanguageTag().replaceAll('-', '_'),
            'Authorization2': await EnvService.get('API_AUTHORIZATION'),
            'Authorization': "Bearer ${await const FlutterSecureStorage().read(key: 'token')}"
          },
        ),
      );
      log(response.data.toString(), name: 'API Response');
      if (response.statusCode == 401 && !retry) {
        Response refresh = await Dio().request(
          "${await EnvService.get('API_URL')}/refresh",
          options: Options(
            method: 'POST',
            validateStatus: (status) {
              return status! < 500;
            },
            contentType: Headers.jsonContentType,
            headers: {
              'Accept-Language': const Locale('pt', 'BR').toLanguageTag().replaceAll('-', '_'),
              'Authorization2': await EnvService.get('API_AUTHORIZATION'),
              'Authorization': "Bearer ${await const FlutterSecureStorage().read(key: 'token')}"
            },
          ),
        );
        if (refresh.statusCode == 200) {
          return fetch(uri,
              queryParameters: queryParameters,
              data: data,
              method: method,
              retry: true);
        }
        return refresh;
      }
      return response;
    } catch (e) {
      log('Error on fetch: $e', name: 'API Request');
      rethrow;
    }
  }

  Future<ApiResponse> login(String email, String password) async {
    try {
      final response = await fetch('login',
          data: {'email': email, 'password': password}, method: 'POST');
      if (response.statusCode != 200) {
        return ApiResponse(
            success: false,
            data: response.data,
            message: 'Erro ao efetuar login');
      }
      await const FlutterSecureStorage().write(key: 'token', value: response.data['token']);
      return ApiResponse(
          success: true,
          data: response.data,
          message: 'Login efetuado com sucesso');
    } catch (e) {
      return ApiResponse(
          success: false, data: null, message: 'Erro ao efetuar login');
    }
  }
}

class ApiResponse {
  final bool success;
  final dynamic data;
  final String message;

  ApiResponse(
      {required this.success, required this.data, required this.message});
}

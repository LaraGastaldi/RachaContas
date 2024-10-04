import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get/get.dart';
import 'package:rachacontas/providers.dart';
import 'package:rachacontas/services/api_service.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validator(String value) {
    if (value.isEmpty) {
      return FlutterI18n.translate(
          Get.context!, 'screens.login_screen.email.required');
    }
    return null;
  }

  void login() {
    if (loginFormKey.currentState!.validate()) {
      getIt<ApiService>()
          .login(emailController.text, passwordController.text)
          .then((auth) {
        if (auth.success) {
          Get.snackbar('Login', FlutterI18n.translate(Get.context!, "screens.login.login.success"), backgroundColor: Colors.greenAccent);
        } else {
          log('Error on login: ${auth.data}');
          Get.snackbar('Login', FlutterI18n.translate(Get.context!, "screens.login.login.error"), backgroundColor: Colors.redAccent);
        }
      }).catchError((e) {
        log('Error on login: $e');
        Get.snackbar('Login', 'Error on login');
      });
    }
  }
}

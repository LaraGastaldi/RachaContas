import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rachacontas/providers.dart';
import 'package:rachacontas/services/api_service.dart';

class RegisterController extends GetxController {
  final registerFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  bool loading = false;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  void register() {
    if (passwordController.value.text != confirmPasswordController.value.text) {
      Get.snackbar('Registro', 'Senhas não conferem',
          backgroundColor: Colors.redAccent);
      return;
    }

    if (registerFormKey.currentState!.validate()) {
      eventhub.fire('loading', true);
      loading = true;
      InternetConnection().hasInternetAccess.then((val) {
        if (!val) {
          Get.snackbar('Login', 'Sem conexão com a internet',
              backgroundColor: Colors.redAccent);
          eventhub.fire('loading', false);
          loading = false;
          return;
        }
        getIt<ApiService>()
            .register(
                nameController.text,
                lastNameController.text,
                emailController.text,
                passwordController.text)
            .then((auth) {
          if (auth.success) {
            Get.snackbar('Login', 'Logado com sucesso',
                backgroundColor: Colors.greenAccent);
            Get.offAllNamed('/home');
          } else {
            log('Error on login: ${auth.data}');
            Get.snackbar('Login', 'Credenciais incorretas',
                backgroundColor: Colors.redAccent);
          }
        }).catchError((e) {
          log('Error on login: $e');
          Get.snackbar('Registro', 'Erro no registro');
        }).whenComplete(() {
          eventhub.fire('loading', false);
          loading = false;
        });
      });
    } else {
      Get.snackbar('Registro', 'Preencha os campos corretamente',
          backgroundColor: Colors.redAccent);
    }
  }
}

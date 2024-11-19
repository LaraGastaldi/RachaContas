import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rachacontas/providers.dart';
import 'package:rachacontas/services/api_service.dart';
import 'package:rachacontas/services/controllers/user_debt_controller.dart';

class AddDebtController extends GetxController {
  final addDebtFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final valueController = TextEditingController();
  final maxPayDateController = TextEditingController();

  final userController = [];

  bool loading = false;

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    valueController.dispose();
    maxPayDateController.dispose();
    userController.every((element) {
      element.dispose();
      return true;
    });
    super.onClose();
  }

  String? validator(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  bool send() {
    if (addDebtFormKey.currentState!.validate()) {

      print(userController.map((e) => e.toJson()).toList());
      return true;
    }
    Get.snackbar('Falha', 'Preencha todos os campos');
    return false;
  }
}

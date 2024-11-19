import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserDebtController extends GetxController {
  final userDebtFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final valueController = TextEditingController();
  final relationshipController = TextEditingController();
  final emailController = TextEditingController();

  Map<String, dynamic> toJson() {
    return {
      'name': nameController.text,
      'value': valueController.text,
      'relationship': relationshipController.text,
      'email': emailController.text,
    };
  }
}

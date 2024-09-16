import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rachacontas_app/services/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: loginController.emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
                autocorrect: false,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
              ),
              TextField(
                controller: loginController.passwordController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print(loginController.emailController.text);
                  print(loginController.passwordController.text);
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:rachacontas/services/controllers/login_controller.dart';
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
          child: Form(
            key: loginController.loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: loginController.emailController,
                  decoration: InputDecoration(
                    labelText: FlutterI18n.translate(
                        context, "screens.login.email.label"),
                  ),
                  autocorrect: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return FlutterI18n.translate(
                          context, "screens.login.email.required");
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: loginController.passwordController,
                  decoration: InputDecoration(
                    labelText: FlutterI18n.translate(
                        context, "screens.login.password.label"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return FlutterI18n.translate(
                          context, "screens.login.password.required");
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    loginController.login();
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

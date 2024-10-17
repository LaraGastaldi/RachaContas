import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rachacontas/providers.dart';
import 'package:rachacontas/services/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  LoginController loginController = Get.put(LoginController());

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;

  @override
  void initState() {
    eventhub.on('loading', (loading) {
      print('chegou');
      setState(() {
        this.loading = loading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: widget.loginController.loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: widget.loginController.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Insira seu e-mail',
                  ),
                  autocorrect: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'O e-mail é requirido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: widget.loginController.passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Insira sua senha',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'A senha é requirida';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: loading
                      ? null
                      : () {
                          widget.loginController.login();
                        },
                  child: loading
                      ? const SizedBox(
                          child: CircularProgressIndicator(),
                          width: 20,
                          height: 20,
                        )
                      : const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

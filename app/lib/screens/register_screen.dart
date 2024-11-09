import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rachacontas/providers.dart';
import 'package:rachacontas/services/controllers/register_controller.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  RegisterController loginController = Get.put(RegisterController());

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool loading = false;

  @override
  void initState() {
    eventhub.on('loading', (loading) {
      setState(() {
        this.loading = loading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: <Widget>[
              const Divider(
                color: Colors.transparent,
                height: 90,
              ),
              const Text(
                'Registrar',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              Form(
                key: widget.loginController.registerFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      CupertinoTextField(
                        placeholder: 'Primeiro nome',
                        controller: widget.loginController.nameController,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z\s]')),
                        ],
                      ),
                      const Divider(
                        color: Colors.transparent,
                        height: 30,
                      ),
                      CupertinoTextField(
                        placeholder: 'Sobrenome',
                        controller: widget.loginController.lastNameController,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z\s]')),
                        ],
                      ),
                      const Divider(
                        color: Colors.transparent,
                        height: 30,
                      ),
                      CupertinoTextField(
                        placeholder: 'E-mail',
                        controller: widget.loginController.emailController,
                      ),
                      const Divider(
                        color: Colors.transparent,
                        height: 30,
                      ),
                      CupertinoTextField(
                        placeholder: 'Senha',
                        obscureText: true,
                        controller: widget.loginController.passwordController,
                      ),
                      const Divider(
                        color: Colors.transparent,
                        height: 30,
                      ),
                      CupertinoTextField(
                        placeholder: 'Confirmar senha',
                        obscureText: true,
                        controller: widget.loginController.confirmPasswordController,
                      ),
                      const Divider(
                        color: Colors.transparent,
                        height: 30,
                      ),
                      CupertinoButton(
                        onPressed: loading
                            ? null
                            : () {
                          widget.loginController.register();
                        },
                        color: Colors.green,
                        child: loading
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        )
                            : const Text('Login'),
                      ),
                      const Divider(
                        color: Colors.transparent,
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

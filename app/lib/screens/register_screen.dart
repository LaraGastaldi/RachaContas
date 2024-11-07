import 'package:flutter/cupertino.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Register'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(child: Column(
              children: [
                CupertinoTextField(
                  placeholder: 'Name',
                ),
                CupertinoTextField(
                  placeholder: 'E-mail',
                ),
                CupertinoTextField(
                  placeholder: 'Password',
                  obscureText: true,
                ),
                CupertinoTextField(
                  placeholder: 'Confirm password',
                  obscureText: true,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
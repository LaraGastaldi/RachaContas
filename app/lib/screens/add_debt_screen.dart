import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDebtScreen extends StatefulWidget {
  const AddDebtScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddDebtScreenState();
}

class _AddDebtScreenState extends State<AddDebtScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            child: Column(
              children: [
                CupertinoTextField(
                  placeholder: 'Nome da dívida',
                ),
                const Divider(
                    color: Colors.transparent,
                    height: 30.0
                ),
                CupertinoTextField(
                  placeholder: 'Nome da dívida',
                ),
                const Divider(
                    color: Colors.transparent,
                    height: 30.0
                ),
                CupertinoTextField(
                  placeholder: 'Nome da dívida',
                ),
                const Divider(
                    color: Colors.transparent,
                    height: 30.0
                ),
                CupertinoTextField(
                  placeholder: 'Nome da dívida',
                ),
                const Divider(
                    color: Colors.transparent,
                    height: 30.0
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}

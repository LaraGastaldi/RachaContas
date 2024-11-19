import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rachacontas/services/controllers/add_debt_controller.dart';
import 'package:get/get.dart';
import 'package:rachacontas/services/controllers/user_debt_controller.dart';

class AddDebtScreen extends StatefulWidget {
  AddDebtScreen({super.key});

  AddDebtController addDebtController = Get.put(AddDebtController());

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
          key: widget.addDebtController.addDebtFormKey,
          child: Column(
            children: [
              CupertinoTextField(
                placeholder: 'Nome da dívida',
                controller: widget.addDebtController.nameController,
              ),
              const Divider(color: Colors.transparent, height: 30.0),
              SizedBox(
                height: 100.0,
                child: CupertinoTextField(
                  controller: widget.addDebtController.descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  placeholder: 'Descrição',
                ),
              ),
              const Divider(color: Colors.transparent, height: 30.0),
              CupertinoTextField(
                placeholder: 'Valor',
                prefix: const Text('R\$ '),
                controller: widget.addDebtController.valueController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                ],
              ),
              const Divider(color: Colors.transparent, height: 30.0),
              CupertinoTextField(
                placeholder: 'Nome da dívida',
              ),
              const Divider(color: Colors.transparent, height: 30.0),
              ListView.builder(
                itemBuilder: (context, index) {
                  Dialog dialog = Dialog(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CupertinoTextField(
                            placeholder: 'Nome do usuário',
                            controller: widget.addDebtController
                                .userController[index].nameController,
                          ),
                          const Divider(
                              color: Colors.transparent, height: 20.0),
                          CupertinoTextField(
                            placeholder: 'E-mail do usuário',
                            controller: widget.addDebtController
                                .userController[index].emailController,
                          ),
                          const Divider(
                              color: Colors.transparent, height: 20.0),
                          CupertinoTextField(
                            placeholder:
                                'Valor da dívida (opcional se único usuário)',
                            controller: widget.addDebtController
                                .userController[index].valueController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9,]')),
                            ],
                          ),
                          const Divider(
                              color: Colors.transparent, height: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {});
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          )
                        ],
                      ),
                    ),
                  );
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          const Divider(
                              color: Colors.transparent, height: 10.0),
                          Text(widget.addDebtController.userController[index]
                                      .nameController.text !=
                                  ''
                              ? widget.addDebtController.userController[index]
                                  .nameController.text
                              : 'Usuário ${index + 1}'),
                          Expanded(child: Container()),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => dialog);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: const Text('Remover usuário'),
                                        content: const Text(
                                            'Deseja realmente remover esse usuário da dívida?'),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Não')),
                                          ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  widget.addDebtController
                                                      .userController
                                                      .removeAt(index);
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: const Text('Sim')),
                                        ]);
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.addDebtController.userController.length,
              ),
              const Divider(color: Colors.transparent, height: 20.0),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.addDebtController.userController
                          .add(UserDebtController());
                    });
                  },
                  child: const Text('Adicionar usuário')),
              const Divider(color: Colors.transparent, height: 30.0),
              ElevatedButton(onPressed: () {
                widget.addDebtController.send();
              }, child: const Text('Criar'))
            ],
          ),
        ),
      )),
    );
  }
}

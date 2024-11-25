import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rachacontas/providers.dart';
import 'package:rachacontas/services/controllers/add_debt_controller.dart';
import 'package:get/get.dart';
import 'package:rachacontas/services/controllers/proof_controller.dart';
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
  void initState() {
    eventhub.on('loading', (loading) {
      setState(() {
        this.loading = loading;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text('Adicionar dívida'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: loading ? null : () {
            widget.addDebtController.send();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.all(20.0),
          ),
          child: loading ? const CircularProgressIndicator() :
          const Text('Criar',
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: widget.addDebtController.addDebtFormKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                CupertinoTextFormFieldRow(
                  placeholder: 'Nome da dívida',
                  controller: widget.addDebtController.nameController,
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                const Divider(color: Colors.transparent, height: 30.0),
                CupertinoTextFormFieldRow(
                  controller: widget.addDebtController.descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  placeholder: 'Descrição',
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const Divider(color: Colors.transparent, height: 30.0),
                CupertinoTextFormFieldRow(
                  placeholder: 'Valor',
                  prefix: const Text('R\$ '),
                  controller: widget.addDebtController.valueController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                  ],
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                const Divider(color: Colors.transparent, height: 30.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.shade700,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.addDebtController.userController
                            .add(UserDebtController());
                      });
                    },
                    child: const Text('Adicionar usuário', style: TextStyle(color: Colors.white))),

                const Divider(color: Colors.transparent, height: 20.0),
                ListView.builder(
                  itemBuilder: (context, index) {
                    Dialog dialog = Dialog(
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            CupertinoTextFormFieldRow(
                              placeholder: 'Nome do usuário',
                              controller: widget.addDebtController
                                  .userController[index].nameController,
                              padding: const EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                                return null;
                              },
                            ),
                            const Divider(
                                color: Colors.transparent, height: 20.0),
                            CupertinoTextFormFieldRow(
                              placeholder: 'E-mail do usuário',
                              controller: widget.addDebtController
                                  .userController[index].emailController,
                              padding: const EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                                return null;
                              },
                            ),
                            const Divider(
                                color: Colors.transparent, height: 20.0),
                            CupertinoTextFormFieldRow(
                              placeholder:
                                  'Valor da dívida',
                              controller: widget.addDebtController
                                  .userController[index].valueController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9,]')),
                              ],
                              padding: const EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                                return null;
                              },
                            ),
                            const Text('O valor é opcional se for o único pagador ou se for uma testemunha'),
                            const Divider(
                                color: Colors.transparent, height: 20.0),
                            Row(children: [
                              Expanded(
                                child: DropdownButton<String>(
                                    padding: const EdgeInsets.all(5.0),
                                    menuWidth: 200.0,
                                    value: widget
                                        .addDebtController
                                        .userController[index]
                                        .relationshipController
                                        .text,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    // underline: Container(
                                    //   height: 2,
                                    //   color: Colors.deepPurpleAccent,
                                    // ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        widget
                                            .addDebtController
                                            .userController[index]
                                            .relationshipController
                                            .text = value!;
                                      });
                                    },
                                    items: const [
                                      DropdownMenuItem<String>(
                                        value: 'payer',
                                        child: Text('Pagador'),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: 'receiver',
                                        child: Text('Credor'),
                                      ),
                                      DropdownMenuItem<String>(
                                          value: 'witness',
                                          child: Text('Testemunha'))
                                    ]),
                              )
                            ]),
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
                const Divider(color: Colors.transparent, height: 10.0),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.addDebtController.proofController
                            .add(ProofController());
                      });
                    },
                    child: const Text('Adicionar comprovantes')),
                const Divider(color: Colors.transparent, height: 20.0),
                ListView.builder(
                  itemBuilder: (context, index) {
                    Dialog dialog = Dialog(
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: const Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add_a_photo),
                                          Text('Adicionar foto')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: const Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add_photo_alternate),
                                          Text('Selecionar foto')
                                        ],
                                      ),
                                    ),
                                  )
                                )
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
                            const Icon(Icons.photo),
                            const Divider(
                                color: Colors.transparent, height: 10.0),
                            Text('Comprovante ${index + 1}'),
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
                                          title: const Text('Remover comprovante'),
                                          content: const Text(
                                              'Deseja realmente remover esse comprovante?'),
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
                                                        .proofController
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
                  itemCount: widget.addDebtController.proofController.length,
                ),
                const Divider(color: Colors.transparent, height: 30.0),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

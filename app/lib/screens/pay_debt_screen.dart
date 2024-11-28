import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rachacontas/models/Debt.dart';
import 'package:rachacontas/models/UserToDebt.dart';
import 'package:get/get.dart';
import 'package:rachacontas/providers.dart';
import 'package:rachacontas/services/api_service.dart';

class PayDebtScreen extends StatefulWidget {
  const PayDebtScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PayDebtScreenState();
}

class _PayDebtScreenState extends State<PayDebtScreen> {
  @override
  Widget build(BuildContext context) {
    final debt = ModalRoute.of(context)!.settings.arguments as Debt;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagar dívida'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: ()  {
                  getIt<ApiService>().totalPay(debt.id!)
                      .then((value) {
                    if (value.success) {
                      Get.snackbar('Sucesso', 'Dívida paga',
                          backgroundColor: Colors.green);
                      Get.offAllNamed('/debt', arguments: debt);
                    } else {
                      Get.snackbar('Falha', 'Erro ao pagar dívida',
                          backgroundColor: Colors.red);
                    }
                  }).catchError((error) {
                    Get.snackbar('Falha', 'Erro ao pagar dívida',
                        backgroundColor: Colors.red);
                  });
                },
                child: const Text('Pagar total',
                    style: TextStyle(
                        color: Colors.green)),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.greenAccent.shade200,
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(debt.name!, style: const TextStyle(fontSize: 24)),
                      Text(debt.description ?? 'Sem descrição'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Form(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Text('Usuários'),
                  ...debt.userToDebt!.where((user) => user.relationship == Relationship.PAYER).map((e) =>
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.name!),
                          Text(e.email!),
                          Text('Valor total: ${e.value ?? debt.totalValue}'),
                          Text('Valor pendente: ${(e.value ?? debt.totalValue)! - (e.paidValue ?? 0)}'),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          showDialog(context: context, builder: (context) {
                            final TextEditingController valueController = TextEditingController();
                            return AlertDialog(
                              title: const Text('Pagar'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Valor pendente: ${oCcy.format((e.value ?? debt.totalValue)! - (e.paidValue ?? 0))}'),
                                  TextFormField(
                                    controller: valueController,
                                    decoration: const InputDecoration(
                                      labelText: 'Valor',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // getIt<ApiService>().payDebt(debt.id!, e.id!, valueController.text)
                                    //     .then((value) {
                                    //   if (value.success) {
                                    //     Get.snackbar('Sucesso', 'Dívida paga',
                                    //         backgroundColor: Colors.green);
                                    //     Get.offAllNamed('/debt', arguments: debt);
                                    //   } else {
                                    //     Get.snackbar('Falha', 'Erro ao pagar dívida',
                                    //         backgroundColor: Colors.red);
                                    //   }
                                    // }).catchError((error) {
                                    //   Get.snackbar('Falha', 'Erro ao pagar dívida',
                                    //       backgroundColor: Colors.red);
                                    // });
                                  },
                                  child: const Text('Pagar',
                                      style: TextStyle(
                                          color: Colors.green)),
                                ),
                              ],
                            );
                          });
                        },
                        child: const Text('Pagar',
                            style: TextStyle(
                                color: Colors.green)),
                      ),
                    ],
                  ),),),
                  const Text('Valor total'),
                  Text(oCcy.format(debt.totalValue!)),
                  const Text('Valor pendente'),
                  Text(debt.getPendingValue().toString()),
                  const Text('Data máxima para pagamento'),
                  Text(debt.maxPayDate ?? 'Sem data máxima'),
                ],
              )
          )
        ],
      ),
    );
  }
}

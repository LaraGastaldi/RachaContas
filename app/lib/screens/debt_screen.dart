import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rachacontas/models/Debt.dart';
import 'package:rachacontas/models/UserToDebt.dart';
import 'package:get/get.dart';

class DebtScreen extends StatefulWidget {
  const DebtScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DebtScreenState();
}

class _DebtScreenState extends State<DebtScreen> {
  @override
  Widget build(BuildContext context) {
    final debt = ModalRoute.of(context)!.settings.arguments as Debt;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dívida'),
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
                onTap: !debt.isVerified()
                    ? () {
                        Get.showSnackbar(const GetSnackBar(
                          title: 'Falha',
                          message:
                              'Não é possível pagar uma dívida não confirmada',
                          backgroundColor: Colors.red,
                        ));
                      }
                    : (debt.getPendingValue() == 0
                        ? () {
                            Get.showSnackbar(const GetSnackBar(
                                title: 'Falha',
                                message: 'Dívida já paga',
                                backgroundColor: Colors.red));
                          }
                        : () {
                      Get.toNamed('/pay-debt', arguments: debt);
                }),
                child: Text('Pagar',
                    style: TextStyle(
                        color: !debt.isVerified() || debt.getPendingValue() == 0
                            ? Colors.grey
                            : Colors.green)),
              ),
              InkWell(
                onTap: () {},
                child:
                    const Text('Excluir', style: TextStyle(color: Colors.red)),
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
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Data da dívida'),
                Text(debt.debtDate ?? 'Sem data'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Data máxima para pagamento'),
                Text(debt.maxPayDate ?? 'Sem data'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text('Valor total'),
                  Text(oCcy.format(debt.totalValue)),
                ],
              ),
              Column(
                children: [
                  const Text('Valor pago'),
                  Text(oCcy.format(debt.getPaidValue())),
                ],
              ),
              Column(
                children: [
                  const Text('Valor pendente'),
                  Text(oCcy.format(debt.getPendingValue()),
                      style: TextStyle(
                          color: debt.getPendingValue() > 0
                              ? Colors.red
                              : Colors.green)),
                ],
              ),
            ],
          ),
          const Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: debt.userToDebt!.length,
            itemBuilder: (context, index) {
              final userToDebt = debt.userToDebt![index];
              return Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userToDebt.name!),
                            Text(userToDebt.email!,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            userToDebt.relationship == 'payer'
                                ? Text(
                                    'Valor a pagar: ${oCcy.format(userToDebt.value ?? debt.totalValue)}')
                                : SizedBox(),
                            Text(Relationship.getRelationship(
                                userToDebt.relationship!)),
                          ]),
                      Row(
                        children: [
                          userToDebt.relationship == Relationship.PAYER
                              ? Column(
                                  children: [
                                    userToDebt.verifiedAt != null
                                        ? const Icon(Icons.check_circle,
                                            color: Colors.green)
                                        : const Icon(Icons.error,
                                            color: Colors.red),
                                    Text(
                                        userToDebt.paidValue ==
                                                (userToDebt.value ??
                                                    debt.totalValue)
                                            ? 'Pago'
                                            : userToDebt.verifiedAt != null
                                                ? 'Confirmado'
                                                : 'Não confirmado',
                                        style: const TextStyle(fontSize: 12)),
                                  ],
                                )
                              : SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: InkWell(
                                onTap: () {}, child: const Icon(Icons.edit)),
                          )
                        ],
                      )
                    ],
                  ));
              return ListTile(
                title: Text(userToDebt.name!),
                subtitle: Text(oCcy.format(userToDebt.paidValue ?? 0)),
              );
            },
          ),
        ],
      ),
    );
  }
}

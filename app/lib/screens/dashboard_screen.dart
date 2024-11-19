import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rachacontas/models/Debt.dart';
import 'package:rachacontas/providers.dart';
import 'package:rachacontas/services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  List<Debt> debts = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();

    getIt<ApiService>().getDebts().then((value) {
      if (value.success) {
        setState(() {
          debts = value.data.map((e) => Debt.fromJson(e)).cast<Debt>().toList();
        });
      } else {
        Get.snackbar('Dívidas', 'Erro ao buscar dívidas',
            backgroundColor: Colors.redAccent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas dívidas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: DraggableHome(
        title: const Text("RachaContas"),
        headerWidget: headerWidget(context),
        headerBottomBar: headerBottomBarWidget(),
        body: [
          debts.length == 0 ? Text('Sem dívidas a mostrar')
          : listView(debts),
        ],
        fullyStretchable: true,
        expandedBody: Container(
          color: Colors.greenAccent,
        ),
        backgroundColor: Colors.white,
        appBarColor: Colors.greenAccent.shade200,
      ),
    );
  }

  Row headerBottomBarWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/add-debt');
          },
          child: Text("Nova dívida"),
        ),
      ],
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      color: Colors.greenAccent.shade200,
      child: Center(),
    );
  }

  ListView listView(List<Debt> debts) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: debts.length,
      shrinkWrap: true,
      itemBuilder: (context, index) =>  Card(
        color: Colors.white70,
        child: ListTile(
          title: Text(debts[index].name ?? ''),
          subtitle: Text((debts[index].description ?? '') + '\n' + (debts[index].totalValue).toString()),
        ),
      ),
    );
  }
}

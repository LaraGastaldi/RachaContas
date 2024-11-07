import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:rachacontas/providers.dart';
import 'package:rachacontas/screens/dashboard_screen.dart';
import 'package:rachacontas/screens/login_screen.dart';
import 'package:rachacontas/screens/register_screen.dart';

String? jwt;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerProviders();

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    jwt = await const FlutterSecureStorage().read(key: 'token');
    runApp(const MyApp());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => jwt != null ? DashboardScreen() : LoginScreen(),
        '/home': (context) => DashboardScreen(),
        '/register': (context) => RegisterScreen(),
      },
      initialRoute: '/',
    );
  }
}
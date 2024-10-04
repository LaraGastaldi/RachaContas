import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:rachacontas/providers.dart';
import 'package:rachacontas/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerProviders();
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
        '/': (context) => LoginScreen(),
      },
      initialRoute: '/',
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            forcedLocale: const Locale('pt', 'BR'),
            useCountryCode: true,
          ),
          missingTranslationHandler: (key, locale) {
            print("--- Missing Key: $key, languageCode: ${locale?.languageCode} ${locale?.countryCode}");
          },
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      builder: FlutterI18n.rootAppBuilder()
    );
  }
}
import 'package:get_it/get_it.dart';
import 'package:rachacontas/services/api_service.dart';
import 'package:rachacontas/services/env_service.dart';

final getIt = GetIt.instance;
void registerProviders() {

  getIt.registerSingleton<EnvService>(EnvService());
  getIt.registerSingleton<ApiService>(ApiService());
}
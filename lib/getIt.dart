import 'package:flutter_tech_sales/provider/login_provider.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<LoginProvider>(LoginProvider());
}

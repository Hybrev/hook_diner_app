import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/login/login_view.dart';
import 'package:hook_diner/app/shared/theme.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const HookDinerApp());
}

class HookDinerApp extends StatelessWidget {
  const HookDinerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: StackedService.navigatorKey,
      theme: ThemeData(
        colorScheme: defaultScheme,
      ),
      home: const LoginView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/login/login_view.dart';
import 'package:hook_diner/app/routes/index.dart';
import 'package:hook_diner/app/shared/theme.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HookDinerApp());
}

class HookDinerApp extends StatelessWidget {
  const HookDinerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const ScrollBehavior().copyWith(scrollbars: false),
      title: 'Flutter Demo',
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: generateRoute,
      theme: ThemeData(
        colorScheme: defaultScheme,
      ),
      home: const LoginView(),
    );
  }
}

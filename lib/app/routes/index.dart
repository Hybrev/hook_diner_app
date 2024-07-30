import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/orders/customer_orders_view.dart';
import 'package:hook_diner/app/modules/home/home_view.dart';
import 'package:hook_diner/app/modules/login/login_view.dart';
import 'package:hook_diner/app/modules/menu/order_menu_view.dart';
import 'package:hook_diner/app/modules/sales/sales_view.dart';
import 'package:hook_diner/app/routes/route_names.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loginRoute:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case homeRoute:
      return _getPageRoute(routeName: homeRoute, viewToShow: const HomeView());
    case inventoryRoute:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case customerRoute:
      return MaterialPageRoute(builder: (_) => const CustomerView());
    case menuRoute:
      return MaterialPageRoute(builder: (_) => const OrderMenuView());
    case salesRoute:
      return MaterialPageRoute(builder: (_) => const SalesView());
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute(
    {required String routeName, required Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/customers/customer_view.dart';
import 'package:hook_diner/app/modules/home/home_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/inventory_view.dart';
import 'package:hook_diner/app/modules/menu/menu_view.dart';
import 'package:hook_diner/app/modules/sales/sales_view.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 150),
          reverse: model.reverse,
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
          child: getViewForIndex(model.currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: appTheme.colorScheme.primary,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: const IconThemeData(size: 28),
          showUnselectedLabels: true,
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          items: const [
            BottomNavigationBarItem(
              label: 'Sales',
              icon: Icon(Icons.receipt_long_rounded),
              activeIcon: Icon(Icons.receipt_long),
            ),
            BottomNavigationBarItem(
              label: 'Inventory',
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Customers',
              icon: Icon(Icons.people_alt_outlined),
              activeIcon: Icon(Icons.people_alt_rounded),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return const SalesView();
    case 1:
      return const InventoryView();
    case 2:
      return const CustomerView();
    default:
      return const MenuView();
  }
}

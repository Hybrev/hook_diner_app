import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/customer%20orders/customer_orders_view.dart';
import 'package:hook_diner/app/modules/home/home_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/inventory_view.dart';
import 'package:hook_diner/app/modules/order%20menu/order_menu_view.dart';
import 'package:hook_diner/app/modules/sales/sales_view.dart';
import 'package:hook_diner/app/modules/users/users_view.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<HomeViewModel>.reactive(
      onViewModelReady: (model) => model.initialize(),
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
          selectedItemColor: appTheme.colorScheme.onSurface,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: const IconThemeData(size: 28),
          showUnselectedLabels: true,
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          items: [
            const BottomNavigationBarItem(
              label: 'Order Menu',
              icon: Icon(Icons.receipt_long_rounded),
              activeIcon: Icon(Icons.receipt_long),
            ),
            const BottomNavigationBarItem(
              label: 'Customers',
              icon: Icon(Icons.people_alt_outlined),
              activeIcon: Icon(Icons.people_alt_rounded),
            ),
            if (model.currentUser?.role != "cashier")
              const BottomNavigationBarItem(
                label: 'Inventory',
                icon: Icon(Icons.inventory_2_outlined),
                activeIcon: Icon(Icons.inventory_2_rounded),
              ),
            if (model.currentUser?.role != "cashier")
              const BottomNavigationBarItem(
                label: 'Sales',
                icon: Icon(Icons.receipt_long_rounded),
                activeIcon: Icon(Icons.receipt_long),
              ),
            if (model.currentUser?.role == "admin")
              const BottomNavigationBarItem(
                label: 'Users',
                icon: Icon(Icons.supervised_user_circle_outlined),
                activeIcon: Icon(Icons.supervised_user_circle_rounded),
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
      return const OrderMenuView();
    case 1:
      return const CustomerView();
    case 2:
      return const InventoryView();
    case 3:
      return const SalesView();
    case 4:
      return const UsersView();
    default:
      return const OrderMenuView();
  }
}

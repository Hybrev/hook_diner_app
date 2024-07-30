import 'package:get_it/get_it.dart';
import 'package:hook_diner/app/modules/customer%20orders/customer_orders_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/app/modules/login/login_viewmodel.dart';
import 'package:hook_diner/app/modules/order%20menu/order_menu_viewmodel.dart';
import 'package:hook_diner/app/modules/sales/sales_viewmodel.dart';
import 'package:hook_diner/app/modules/users/users_viewmodel.dart';
import 'package:hook_diner/core/services/auth_service.dart';
import 'package:hook_diner/core/services/date_service.dart';
import 'package:hook_diner/core/services/database_service.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => InventoryViewModel());
  locator.registerLazySingleton(() => SalesViewModel());
  locator.registerLazySingleton(() => OrderMenuViewModel());
  locator.registerLazySingleton(() => CustomerOrdersViewModel());
  locator.registerLazySingleton(() => LoginViewModel());
  locator.registerLazySingleton(() => UsersViewModel());

  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => DateService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => DatabaseService());
  // Add other services as needed
}

import 'package:hook_diner/core/locator.dart';
import 'package:hook_diner/core/services/auth_service.dart';
import 'package:hook_diner/core/services/date_service.dart';
import 'package:hook_diner/core/services/db_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SharedViewModel extends BaseViewModel {
  final NavigationService _navigator = locator<NavigationService>();
  final SnackbarService _snackbar = locator<SnackbarService>();
  final AuthService _auth = locator<AuthService>();
  final DateService _date = locator<DateService>();
  final DialogService _dialog = locator<DialogService>();
  final DatabaseService _database = locator<DatabaseService>();

  NavigationService get navigator => _navigator;
  SnackbarService get snackbar => _snackbar;
  AuthService get auth => _auth;
  DateService get date => _date;
  DialogService get dialog => _dialog;
  DatabaseService get database => _database;
}
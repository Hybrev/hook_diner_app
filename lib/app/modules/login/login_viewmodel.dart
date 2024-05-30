import 'package:hook_diner/app/routes/route_names.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigator = locator<NavigationService>();

  void initialize() async {}

  void toMainMenu() {
    _navigator.pushNamedAndRemoveUntil(homeRoute);
  }
}

// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/login/login_viewmodel.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final mediaData = MediaQuery.of(context);

    return ViewModelBuilder<LoginViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.initialize(),
      fireOnViewModelReadyOnce: true,
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image(
                      image: AssetImage('lib/app/assets/img/banner.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: appTheme.textTheme.titleLarge?.fontSize,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appTheme.colorScheme.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: mediaData.size.width * 0.15,
                      vertical: 12,
                    ),
                    foregroundColor: appTheme.colorScheme.onPrimary,
                    shadowColor: appTheme.colorScheme.secondary,
                    textStyle: appTheme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                    elevation: 4,
                  ),
                  onPressed: () => model.toMainMenu(),
                  child: const Text("LOGIN"),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => locator<LoginViewModel>(),
    );
  }
}

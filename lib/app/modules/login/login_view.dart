// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/login/login_viewmodel.dart';
import 'package:hook_diner/app/modules/login/widgets/login_section.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final mediaData = MediaQuery.sizeOf(context);

    return ViewModelBuilder<LoginViewModel>.reactive(
      fireOnViewModelReadyOnce: true,
      onViewModelReady: (viewModel) => viewModel.streamAuth(),
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: mediaData.width > 600
                  ? Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: mediaData.height * 0.6,
                          ),
                          child: const AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image(
                              image:
                                  AssetImage('lib/app/assets/img/banner.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: LoginSection(),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: mediaData.height * 0.6,
                          ),
                          child: const AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image(
                              image:
                                  AssetImage('lib/app/assets/img/banner.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: appTheme.textTheme.titleLarge?.fontSize,
                        ),
                        const LoginSection(),
                      ],
                    ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => locator<LoginViewModel>(),
    );
  }
}

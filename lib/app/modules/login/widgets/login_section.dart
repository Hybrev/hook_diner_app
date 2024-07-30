import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/login/login_viewmodel.dart';
import 'package:hook_diner/app/modules/login/widgets/input_field.dart';
import 'package:hook_diner/app/shared/widgets/base_button.dart';
import 'package:stacked/stacked.dart';

class LoginSection extends ViewModelWidget<LoginViewModel> {
  const LoginSection({super.key});

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    final appTheme = Theme.of(context);
    final mediaData = MediaQuery.sizeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: mediaData.width * 0.75,
          child: InputField(
            controller: viewModel.usernameController,
            label: 'Username',
          ),
        ),
        SizedBox(
          height: appTheme.textTheme.titleLarge?.fontSize,
        ),
        SizedBox(
          width: mediaData.width * 0.75,
          child: InputField(
            controller: viewModel.passwordController,
            label: 'Password',
            isPassword: true,
          ),
        ),
        SizedBox(
          height: appTheme.textTheme.titleLarge?.fontSize,
        ),
        BaseButton(
          onPressed: () => viewModel.logIn(
            username: viewModel.usernameController.text.trim(),
            password: viewModel.passwordController.text.trim(),
          ),
          loading: viewModel.isBusy,
          label: 'LOGIN',
          buttonIcon: null,
        ),
      ],
    );
  }
}

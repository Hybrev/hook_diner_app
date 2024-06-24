import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/users/widgets/add/user_row.dart';
import 'package:hook_diner/app/modules/users/widgets/add/add_user_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddUserView extends StatelessWidget {
  const AddUserView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final mediaData = MediaQuery.sizeOf(context);

    return ViewModelBuilder<AddUserViewModel>.reactive(
      viewModelBuilder: () => AddUserViewModel(),
      disposeViewModel: false,
      builder: (context, viewModel, child) => SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ADD USER',
                style: appTheme.textTheme.displaySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
                child: Divider(color: appTheme.colorScheme.primary),
              ),
              UserRow(label: 'Name', controller: viewModel.usernameController),
              UserRow(
                  label: 'Password', controller: viewModel.passwordController),
              UserRow(
                label: 'Role',
                controller: viewModel.roleController,
                onChanged: (role) => viewModel.updateRole(role),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appTheme.colorScheme.error,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                    ),
                    icon: Icon(
                      Icons.close_rounded,
                      color: appTheme.colorScheme.onError,
                    ),
                    label: Text(
                      'Cancel',
                      style: appTheme.textTheme.labelLarge?.copyWith(
                        color: appTheme.colorScheme.onError,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => viewModel.closeModal(),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appTheme.colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                    ),
                    icon: Icon(
                      Icons.add_rounded,
                      color: appTheme.colorScheme.onPrimary,
                    ),
                    label: Text(
                      'Add ',
                      style: appTheme.textTheme.labelLarge?.copyWith(
                        color: appTheme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => viewModel.addUser(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

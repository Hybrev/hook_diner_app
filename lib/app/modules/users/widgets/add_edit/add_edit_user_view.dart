import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/users/widgets/add_edit/user_row.dart';
import 'package:hook_diner/app/modules/users/widgets/add_edit/add_edit_user_viewmodel.dart';
import 'package:hook_diner/core/models/user.dart';

import 'package:stacked/stacked.dart';

class AddEditUserView extends StatelessWidget {
  const AddEditUserView({super.key, required this.editingUser});

  final User? editingUser;
  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<AddEditUserViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.setUpModal(editingUser),
      disposeViewModel: false,
      builder: (context, viewModel, child) => SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                editingUser == null ? 'ADD USER' : 'EDIT USER',
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
                  viewModel.isBusy
                      ? CircularProgressIndicator(
                          color: appTheme.colorScheme.primary,
                        )
                      : ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appTheme.colorScheme.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                          ),
                          icon: viewModel.isBusy
                              ? CircularProgressIndicator(
                                  color: appTheme.colorScheme.onPrimary,
                                )
                              : Icon(
                                  Icons.add_rounded,
                                  color: appTheme.colorScheme.onPrimary,
                                ),
                          label: Text(
                            'Save',
                            style: appTheme.textTheme.labelLarge?.copyWith(
                              color: appTheme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: editingUser == null
                              ? () => viewModel.addUser()
                              : () => viewModel.updateUser(editingUser!),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => AddEditUserViewModel(),
    );
  }
}

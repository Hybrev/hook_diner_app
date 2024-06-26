import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/users/widgets/add_edit/user_row.dart';
import 'package:hook_diner/app/modules/users/widgets/add_edit/add_edit_user_viewmodel.dart';
import 'package:hook_diner/app/shared/widgets/base_button.dart';
import 'package:hook_diner/app/shared/widgets/cancel_button.dart';
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
              SizedBox(
                height: 40,
                child: Divider(color: appTheme.colorScheme.primary),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CancelButton(),
                  viewModel.isBusy
                      ? CircularProgressIndicator(
                          color: appTheme.colorScheme.primary,
                        )
                      : BaseButton(
                          label: 'SAVE',
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

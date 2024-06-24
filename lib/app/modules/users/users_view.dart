// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/users/users_viewmodel.dart';
import 'package:hook_diner/app/modules/users/widgets/add/add_user_view.dart';
import 'package:hook_diner/app/shared/widgets/data_list.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<UsersViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.initialize(),
      fireOnViewModelReadyOnce: true,
      disposeViewModel: false,
      viewModelBuilder: () => locator<UsersViewModel>(),
      builder: (context, model, child) => Scaffold(
        appBar: const BaseAppBar(title: "USERS"),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: DataList(
              title: 'User Name',
              subtitle: 'User Role',
              onEditTap: () {
                print('edit tapped');
              },
              onDeleteTap: () {
                print('delete tapped');
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => model.showActionModal(
            context,
            dialogContent: const AddUserView(),
          ),
          backgroundColor: appTheme.colorScheme.primary,
          label: Text(
            'ADD USER',
            style: appTheme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: appTheme.colorScheme.onPrimary,
            ),
          ),
          icon: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/users/users_viewmodel.dart';
import 'package:hook_diner/app/modules/users/widgets/add_edit/add_edit_user_view.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/app/shared/widgets/data_tile.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<UsersViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.initialize(),
      disposeViewModel: false,
      viewModelBuilder: () => locator<UsersViewModel>(),
      builder: (context, model, child) => Scaffold(
        appBar: const BaseAppBar(title: "USERS"),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: model.users != null
                ? ListView.separated(
                    itemCount: model.users!.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(
                      height: 8,
                      color: appTheme.colorScheme.secondary,
                    ),
                    itemBuilder: (context, index) => DataTile(
                      index,
                      data: model.users!,
                      title: model.users![index].username!,
                      subtitle: model.users![index].password!,
                      onEditTap: () => model.showActionModal(
                        context,
                        dialogContent: AddEditUserView(
                          editingUser: model.users![index],
                          onSave: () => model.updateUser(model.users![index]),
                        ),
                      ),
                      onDeleteTap: () =>
                          model.deleteUser(model.users?[index].id ?? ""),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(appTheme.colorScheme.primary),
                    ),
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => model.showActionModal(
            context,
            dialogContent: AddEditUserView(
              onSave: () => model.addUser(),
            ),
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

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
          child: Column(
            children: [
              Expanded(
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
                            leading: model.users![index].role![0].toUpperCase(),
                            title: model.users![index].username!,
                            subtitle: model.users![index].password!,
                            onEditTap: () => model.showActionModal(
                              context,
                              dialogContent: AddEditUserView(
                                editingUser: model.users![index],
                              ),
                            ),
                            onDeleteTap: () =>
                                model.deleteUser(model.users![index]),
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                appTheme.colorScheme.primary),
                          ),
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'A = admin P = purchaser, C = cashier',
                    style: appTheme.textTheme.titleSmall,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => model.showActionModal(
            context,
            dialogContent: const AddEditUserView(editingUser: null),
          ),
          backgroundColor: appTheme.colorScheme.primary,
          elevation: 2,
          shape: const CircleBorder(),
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}

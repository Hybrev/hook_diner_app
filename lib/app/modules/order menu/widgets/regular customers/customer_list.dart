import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/order%20menu/order_menu_viewmodel.dart';
import 'package:hook_diner/app/modules/order%20menu/widgets/regular%20customers/add_edit_customer_modal.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/app/shared/widgets/data_tile.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return ViewModelBuilder<OrderMenuViewModel>.nonReactive(
        viewModelBuilder: () => locator<OrderMenuViewModel>(),
        builder: (context, viewModel, child) => Scaffold(
              appBar: const BaseAppBar(
                title: "CUSTOMER LIST",
                automaticallyImplyLeading: true,
                centerTitle: true,
              ),
              body: viewModel.customers?.isNotEmpty ?? false
                  ? ListView.builder(
                      itemCount: viewModel.customers?.length ?? 0,
                      itemBuilder: (context, index) => DataTile(
                        index,
                        data: viewModel.customers ?? [],
                        title: viewModel.customers?[index].name ?? '',
                        onEditTap: () => viewModel.showCustomModal(
                          context,
                          dialogContent: AddEditCustomerModal(
                              editingCustomer: viewModel.customers![index]),
                          isAddEdit: true,
                        ),
                        onDeleteTap: () => viewModel
                            .deleteCustomer(viewModel.customers![index]),
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_off_outlined,
                            size: 120,
                            color: appTheme.colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No customers found!',
                            style: appTheme.textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
            ));
  }
}

// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/order/order_viewmodel.dart';
import 'package:hook_diner/app/modules/order/widgets/menu_grid.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ViewModelBuilder<OrderViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.initialize(),
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        appBar: const BaseAppBar(title: 'MENU'),
        body: Center(
          child: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SEARCH BAR FOR FILTERING ITEMS

                SearchBar(
                  trailing: [
                    Tooltip(
                      message: 'Search',
                      child: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ),
                  ],
                  controller: model.searchBarController,
                ),
                const SizedBox(height: 8),
                // GRID OF AVAILABLE ITEMS
                Expanded(
                  child: MenuGrid(),
                ),
                const SizedBox(height: 8),

                // TOTAL PRICE COST OF ORDER
                GestureDetector(
                  onTap: () {
                    print('total price button pressed');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: appTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(
                              0.5), // Adjust color and opacity as needed
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(
                              0, 2), // Adjust offset for shadow position
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Price'),
                          Text('PHP '),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => locator<OrderViewModel>(),
    );
  }
}

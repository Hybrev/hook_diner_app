// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/inventory_viewmodel.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:stacked/stacked.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    // final windowSize = MediaQuery.sizeOf(context);

    return ViewModelBuilder<InventoryViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.initialize(),
      fireOnViewModelReadyOnce: true,
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('CATEGORIES'),
          backgroundColor: appTheme.colorScheme.background,
          titleTextStyle: appTheme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          shadowColor: Colors.black,
          elevation: 4,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 840),
              child: GridView.builder(
                itemCount: model.categories.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 340,
                ),
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 4,
                  child: InkWell(
                    splashColor: appTheme.colorScheme.secondary,
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image(
                                image: AssetImage(
                                  'lib/app/assets/img/categories/${model.categories[index].imageUrl}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            model.categories[index].title!.toUpperCase(),
                            style: appTheme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: appTheme.colorScheme.tertiary,
          child: const Icon(Icons.add),
          onPressed: () => model.incrementCounter(), // Call view model method
        ),
      ),
      viewModelBuilder: () => locator<InventoryViewModel>(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hook_diner/app/modules/inventory/widgets/category/add_edit/add_edit_category_viewmodel.dart';
import 'package:hook_diner/app/modules/inventory/widgets/item/item_text_field.dart';
import 'package:hook_diner/app/shared/widgets/base_button.dart';
import 'package:hook_diner/app/shared/widgets/cancel_button.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:hook_diner/core/models/category.dart';
import 'package:stacked/stacked.dart';

class AddEditCategoryView extends StatelessWidget {
  const AddEditCategoryView({super.key, this.editingCategory});

  final Category? editingCategory;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return ViewModelBuilder<AddEditCategoryViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.setUpModal(editingCategory),
      disposeViewModel: false,
      builder: (context, viewModel, child) => SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                editingCategory == null ? 'ADD CATEGORY' : 'EDIT CATEGORY',
                style: appTheme.textTheme.headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ItemTextField(
                fieldLabel: 'Category Name',
                inputType: TextInputType.text,
                controller: viewModel.categoryController,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CancelButton(),
                  BaseButton(
                    label: 'SAVE',
                    loading: viewModel.isBusy,
                    onPressed: editingCategory == null
                        ? () => viewModel.addCategory()
                        : () => viewModel.updateCategory(editingCategory!),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => locator<AddEditCategoryViewModel>(),
    );
  }
}

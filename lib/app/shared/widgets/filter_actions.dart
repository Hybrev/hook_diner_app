import 'package:flutter/material.dart';
import 'package:hook_diner/core/models/customer.dart';

class FilterActions extends StatelessWidget {
  const FilterActions({
    super.key,
    this.searchBarController,
    this.onSearchBarChanged,
    this.datePickerController,
    this.onDateChanged,
    required this.dropdownItems,
    required this.dropdownController,
    required this.onDropdownChanged,
  });

  final Function(String value)? onSearchBarChanged;
  final TextEditingController? searchBarController;

  final Function(String value)? onDateChanged;
  final TextEditingController? datePickerController;

  final List dropdownItems;
  final TextEditingController dropdownController;
  final Function(String value) onDropdownChanged;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    if (MediaQuery.sizeOf(context).width > 600) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (searchBarController != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                onChanged: (value) => onSearchBarChanged!(value),
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
                hintText: 'Search...',
                trailing: const [
                  Tooltip(
                    message: 'Search',
                    child: Icon(Icons.search),
                  ),
                ],
                controller: searchBarController,
              ),
            ),
          if (datePickerController != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: datePickerController,
                readOnly: true,
                onTap: () => onDateChanged!(datePickerController!.text),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
          DropdownButton<String>(
            value: dropdownController.text,
            style: appTheme.textTheme.labelLarge,
            focusColor: Theme.of(context).colorScheme.tertiary,
            items: dropdownItems is List<Customer?>
                ? dropdownItems
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e.id,
                        child: Text(e.name ?? ''),
                      ),
                    )
                    .toList()
                : dropdownItems
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e.id,
                        child: Text(e.title ?? ''),
                      ),
                    )
                    .toList(),
            onChanged: (value) => onDropdownChanged(value!),
          ),
        ],
      );
    }
    return Column(
      children: [
        if (searchBarController != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              onChanged: (value) => onSearchBarChanged!(value),
              constraints: const BoxConstraints(maxWidth: 480),
              padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
              hintText: 'Search...',
              trailing: const [
                Tooltip(
                  message: 'Search',
                  child: Icon(Icons.search),
                ),
              ],
              controller: searchBarController,
            ),
          ),
        Align(
          alignment: Alignment.topRight,
          child: DropdownButton<String>(
            value: dropdownController.text,
            focusColor: Theme.of(context).colorScheme.tertiary,
            items: dropdownItems is List<Customer?>
                ? dropdownItems
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e.id,
                        child: Text(e.name ?? ''),
                      ),
                    )
                    .toList()
                : dropdownItems
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e.id,
                        child: Text(e.title ?? ''),
                      ),
                    )
                    .toList(),
            onChanged: (value) => onDropdownChanged(value!),
          ),
        ),
      ],
    );
  }
}

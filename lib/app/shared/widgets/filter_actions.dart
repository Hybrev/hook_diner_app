import 'package:flutter/material.dart';

class FilterActions extends StatelessWidget {
  const FilterActions({
    super.key,
    required this.searchBarController,
    required this.onSearchBarChanged,
    required this.dropdownItems,
    required this.dropdownController,
    required this.onDropdownChanged,
  });

  final Function(String value) onSearchBarChanged;
  final TextEditingController searchBarController;

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              onChanged: (value) => onSearchBarChanged(value),
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
          DropdownButton<String>(
            value: dropdownController.text,
            style: appTheme.textTheme.labelLarge,
            focusColor: Theme.of(context).colorScheme.tertiary,
            items: dropdownItems
                .map((e) => DropdownMenuItem<String>(
                      value: e.id,
                      child: Text(e.title!),
                    ))
                .toList(),
            onChanged: (value) => onDropdownChanged(value!),
          ),
        ],
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchBar(
            onChanged: (value) => onSearchBarChanged(value),
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
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.topRight,
          child: DropdownButton<String>(
            value: dropdownController.text,
            focusColor: Theme.of(context).colorScheme.tertiary,
            items: dropdownItems
                .map((e) => DropdownMenuItem<String>(
                      value: e.id,
                      child: Text(e.title ?? ''),
                    ))
                .toList(),
            onChanged: (value) => onDropdownChanged(value!),
          ),
        ),
      ],
    );
  }
}

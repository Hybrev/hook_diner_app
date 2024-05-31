import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.centerTitle = false,
  });

  final String title;
  final List<Widget> actions;
  final bool centerTitle;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      centerTitle: centerTitle,
      elevation: 2,
      surfaceTintColor: appTheme.colorScheme.background,
      shadowColor: appTheme.colorScheme.onBackground.withOpacity(0.25),
      titleTextStyle: appTheme.textTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      actions: actions,
    );
  }
}

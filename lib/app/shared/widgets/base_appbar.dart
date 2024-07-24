import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar(
      {super.key,
      required this.title,
      this.actions = const [],
      this.centerTitle = false,
      this.automaticallyImplyLeading = false,
      this.bottomWidget});

  final String title;
  final List<Widget> actions;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottomWidget;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Text(title),
      centerTitle: centerTitle,
      elevation: 2,
      surfaceTintColor: appTheme.colorScheme.surface,
      shadowColor: appTheme.colorScheme.onSurface.withOpacity(0.25),
      titleTextStyle: appTheme.textTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      actions: actions,
      bottom: bottomWidget,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hook_diner/app/shared/widgets/base_appbar.dart';

class CustomerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomerAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height * 2);

  @override
  Widget build(BuildContext context) {
    return const BaseAppBar(
      title: "CUSTOMERS",
      centerTitle: true,
      bottomWidget: TabBar(
        tabs: [
          Tab(
            text: 'UNPAID',
          ),
          Tab(
            text: 'PAID',
          ),
        ],
      ),
    );
  }
}

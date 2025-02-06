import 'package:flutter/material.dart';
import 'package:my_place/widgets/mp_button_icon.dart';

class MPAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MPAppBar({
    super.key,
    required this.tittle,
    required this.withLeading,
    this.actions = const[],
  });

  final Widget tittle;
  final bool withLeading;
  final List<Widget> actions;

  @override
  Size get preferredSize => Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: preferredSize.height,
        child: AppBar(
          automaticallyImplyLeading: false,
          title: tittle,
          leadingWidth: 40,
          leading: ! withLeading ? null : MPButtonIcon(
            iconData : Icons.chevron_left,
            onTap: () => Navigator.of(context).pop()
          ),
          actions: actions,
        ),
      )
    );
  }
}

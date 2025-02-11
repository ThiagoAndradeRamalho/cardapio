import 'package:flutter/material.dart';
import 'package:my_place/widgets/mp_button_icon.dart';

class MPAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MPAppBar({
    super.key,
    required this.title,
    this.withLeading = true,
    this.actions = const[],
  });

  final Widget title;
  final bool withLeading;
  final List<Widget> actions;

  @override
  Size get preferredSize => Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: preferredSize.height,
        child: AppBar(
          automaticallyImplyLeading: false,
          title: title,
          leadingWidth: 40,
          leading: withLeading ? MPButtonIcon(
            iconData : Icons.chevron_left,
            onTap: () => Navigator.of(context).pop()
          ) : null,
          actions: actions,
        ),
      )
    );
  }
}

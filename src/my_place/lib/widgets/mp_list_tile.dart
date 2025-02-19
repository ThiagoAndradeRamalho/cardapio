import 'package:flutter/material.dart';

class MpListTile extends StatelessWidget {
  const MpListTile({
    super.key,
    this.leading,
    required this.trailing,
    required this.title,
    required this.onTap,
  });

  final Widget? leading;
  final Widget trailing;
  final Widget title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: const Color.fromARGB(255, 243, 237, 237),
      visualDensity: VisualDensity.compact,
      leading: leading == null
          ? null
          : Container(
              alignment: Alignment.center,
              width: 50,
              child: leading,
            ),
      title: title,
      trailing: trailing,
      onTap: () => onTap(),
    );
  }
}

import 'package:flutter/material.dart';

class MpListView extends StatelessWidget {
  const MpListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 243, 237, 237),
      child: ListView.separated(
          itemBuilder: itemBuilder,
          separatorBuilder: (context, i) => Divider(
                height: 10,
                indent: 68,
              ),
          itemCount: itemCount),
    );
  }
}

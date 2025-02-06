import 'package:flutter/material.dart';

class MPButtonIcon extends StatelessWidget {
  const MPButtonIcon({
    super.key,
    required this.iconData,
    required this.onTap,
  });

  final IconData iconData;
  final Function onTap;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 40,
        height: 40,
        child: Icon(iconData),
      ),
      borderRadius: BorderRadius.circular(20),
      onTap: onTap(),
    );
  }
}

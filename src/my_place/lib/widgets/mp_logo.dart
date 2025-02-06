import 'package:flutter/material.dart';

class Mplogo extends StatelessWidget {
  Mplogo({
    super.key,
    this.fontSize = 40,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: fontSize / 3.5),
          child: Text(
            'MyPlace',
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Colors.orange),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Text(
            'admin',
            style: TextStyle(
                fontSize: 40 / 2.5,
                fontWeight: FontWeight.w500,
                color: Colors.orange),
          ),
        ),
      ],
    );
  }
}

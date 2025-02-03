import 'package:flutter/material.dart';

class Mplogo extends StatelessWidget {
  const Mplogo(
    {
      super.key, 
      this.isAdmin = false
    }
  );

  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40 / 3.5),
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

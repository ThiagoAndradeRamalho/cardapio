import 'package:flutter/material.dart';

class MpLoading extends StatelessWidget {
  const MpLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
    );
  }
}
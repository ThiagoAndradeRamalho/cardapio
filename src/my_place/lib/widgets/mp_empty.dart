import 'package:flutter/material.dart';

class MPEmpty extends StatelessWidget {
  const MPEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sem registros',
              style: TextStyle(fontSize: 30),
            ),
            Icon(
              Icons.folder_open,
              size: 100,
              color: Colors.deepOrange,
            )
          ],
        ),
      ),
    );
  }
}

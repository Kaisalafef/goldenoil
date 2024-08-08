import 'package:flutter/material.dart';

class logoauth extends StatelessWidget {
  logoauth({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(
          top: 60,
        ),
        width: 120,
        height: 120,
        child: const Column(
          children: [
            Icon(
              Icons.water_drop,
              size: 50,
              color: Colors.black,
            ),
            Icon(
              Icons.key_rounded,
              size: 50,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

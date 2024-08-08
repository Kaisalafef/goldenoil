import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textappbar extends StatelessWidget {
  const textappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "       Golden",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        Icon(
          Icons.water_drop_outlined,
          color: Colors.yellow,
          size: 35,
        ),
        Text(
          "il ",
          style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
              color: Colors.yellow),
        ),
      ],

    ) ;
  }
}

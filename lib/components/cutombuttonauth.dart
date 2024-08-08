import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final String text;
  final Color  colors ;
  final void Function()? onPressed;

  CustomButtonAuth({super.key, required this.text, required this.colors, this.onPressed});
@override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 50,
      textColor: Colors.white,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Text(
        "$text",
        style: TextStyle(fontSize: 20),
      ),
      color: colors,
    );
  }
}

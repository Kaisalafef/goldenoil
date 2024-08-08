import 'package:flutter/material.dart';

class textformfild extends StatelessWidget {
final String hinttext;
final String? Function(String?)? validet;
final TextEditingController mycontroller;

   const textformfild({super.key, required this.hinttext, required this.mycontroller, this.validet});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validet,
      controller: mycontroller,

      decoration: InputDecoration(isDense: true, filled: true,
       errorStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.red.shade400),
        fillColor: Colors.white24,
        hintText: "$hinttext",
        hintStyle: const TextStyle(color: Colors.black54),
        errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.red, width:2.3)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.yellow, width: 3)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.blue, width: 2.3)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black87, width:2.3)),
      ),
    );
  }
}

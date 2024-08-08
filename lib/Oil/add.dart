

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:goldenoil/Viwe/homepage.dart';
import 'package:goldenoil/components/textformfiled.dart';


class Add extends StatefulWidget {
  Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController nameoil = TextEditingController();

  TextEditingController image = TextEditingController();


  TextEditingController viscosityRatio = TextEditingController();

  TextEditingController price = TextEditingController();

  CollectionReference Oil = FirebaseFirestore.instance.collection('Oil');

  addOil() async {
    if (formState.currentState!.validate()) {
      try {

        // Add oil to Firestore
        DocumentReference respones = await Oil.add( {
          "name oil": nameoil.text,

          "image": image.text,
          "viscosityRatio": viscosityRatio.text,
          "price": price.text,
        });
        Get.off(homepage());
      } catch (e) {
        print("Error $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add",textAlign:TextAlign.center  ,
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body:Form(
    key: formState,child:
         ListView(

          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),

            textformfild(hinttext: "name oil", mycontroller: nameoil),
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),

            textformfild(hinttext: "image", mycontroller: image),
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),

 textformfild(
                hinttext: "viscosity ratio %", mycontroller: viscosityRatio),
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),

            textformfild(hinttext: "price", mycontroller: price),
            Padding(padding: EdgeInsets.symmetric(vertical: 14)),


      MaterialButton(
                onPressed: () => addOil(),
                child: Container(height:20,width:50,child: Text("Add")),
                color: Colors.amber,
                textColor: Colors.white,
              ),

          ],
        ),)

    );
  }
}
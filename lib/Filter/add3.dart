import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:goldenoil/Viwe/homepage.dart';
import 'package:goldenoil/components/textformfiled.dart';

class Add3 extends StatelessWidget {
  Add3({super.key});

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController namefilter = TextEditingController();
  TextEditingController typefilter = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController price = TextEditingController();
  CollectionReference Filter = FirebaseFirestore.instance.collection('Filter');

  addFilter() async {
    if (formState.currentState!.validate()) {
      try {

        // Add oil to Firestore
        DocumentReference respones = await Filter.add({
          "name filter": namefilter.text,
          "type filter": typefilter.text,
          "image": image.text,


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

            textformfild(hinttext: "name filter", mycontroller: namefilter),
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            textformfild(hinttext: "type filter", mycontroller: typefilter),
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),


            textformfild(hinttext: "image", mycontroller: image),
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),



            textformfild(hinttext: "price", mycontroller: price),
            Padding(padding: EdgeInsets.symmetric(vertical: 14)),


            MaterialButton(
              onPressed: () => addFilter(),
              child: Container(height:20,width:50,child: Text("Add")),
              color: Colors.amber,
              textColor: Colors.white,
            ),

          ],
        ),)

    );
  }
}

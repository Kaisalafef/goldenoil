//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldenoil/WidgetsA/Textappbar.dart';
import 'package:goldenoil/auth/booking.dart';
//import 'package:goldenoil/auth/booking.dart';

class FilterDetails extends StatelessWidget {
  var data;

  FilterDetails({super.key, required this.data});

  CollectionReference Cart = FirebaseFirestore.instance.collection('Cart');
  addCart() async {

    try {


      DocumentReference respones = await Cart.add({
        "id " : data.id,"data":data.data(),"uid":FirebaseAuth.instance.currentUser!.uid
      });

    } catch (e) {
      print("Error $e");
    }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: textappbar(),
        ),
        body: Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(padding: EdgeInsets.only(top: 20,bottom: 20))
                ,Container(
                  height: 200, width: 200,
                  child: Image.asset("images/${data['image']}"),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    "the  name filter :${data["name filter"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Type filter :${data["type filter"]}"
                    ,textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    "price : ${data["price"]}\$",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green,fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                    margin: const EdgeInsets.only(top: 0),
                    child:  Container(height: 50,width: 70,
                      margin: EdgeInsets.symmetric(horizontal: 100,vertical: 40),
                      child: MaterialButton(color: Colors.purple,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(50)),
                          textColor: Colors.white,splashColor: Colors.blue,
                          onPressed: () {
                            addCart();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green.shade500,

                                content: Text('Done ',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                            duration: Duration(seconds: 2)));
                          },
                          child:Row(
                            children: [
                              Icon(Icons.add_shopping_cart_rounded,color: Colors.white,),
                              Text('Add to Cart',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                            ],
                          )
                      ),
                    ))],
            )));
  }
}

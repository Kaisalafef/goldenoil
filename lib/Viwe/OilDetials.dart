//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldenoil/WidgetsA/Textappbar.dart';
import 'package:goldenoil/auth/booking.dart';
//import 'package:goldenoil/auth/booking.dart';

class OilDetails extends StatefulWidget {
  var data;

  OilDetails({super.key, required this.data});

  @override
  State<OilDetails> createState() => _OilDetailsState();
}

class _OilDetailsState extends State<OilDetails> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  CollectionReference Cart = FirebaseFirestore.instance.collection('Cart');

  addCart() async {
    try {
      DocumentReference respones = await Cart.add({
        "id ": widget.data?.id,
        "data": widget.data?.data(),
        "uid": FirebaseAuth.instance.currentUser!.uid
      });
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data == null) {
      return Center(
        child: Text('No data available'),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: textappbar(),
        ),
        body: Container(
            child: ListView(
          shrinkWrap: true,
          children: [
            Padding(padding: EdgeInsets.only(top: 20, bottom: 20)),
            Container(
              height: 200,
              width: 200,
              child: Image.asset("images/${widget.data['image']}"),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                "The name oil :${widget.data?["name oil"]}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                "viscosityRatio :${widget.data?["viscosityRatio"]}%",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                "price :${widget.data?["price"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: Container(
                height: 50,
                width: 70,
                margin: EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                child: MaterialButton(
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    textColor: Colors.white,
                    splashColor: Colors.blue,
                    onPressed: () {
                      addCart();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green.shade500,
                          content: Text(
                            'Done ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          duration: Duration(seconds: 2)));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Add to Cart',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    )),
              ),
            )
          ],
        )));
  }
}

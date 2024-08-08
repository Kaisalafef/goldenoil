import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:goldenoil/Controlare/controler_page.dart';
import 'package:goldenoil/Viwe/OilDetials.dart';
import 'package:goldenoil/WidgetsA/Textappbar.dart';
import 'package:goldenoil/auth/booking.dart';

class CartA extends StatefulWidget {
  CartA({super.key});

  @override
  State<CartA> createState() => _CartAState();
}

class _CartAState extends State<CartA> {
  List<QueryDocumentSnapshot> data = [];
  CollectionReference Cart = FirebaseFirestore.instance.collection('Cart');
  int totalPrice = 0;
  var data11;

  Future<void> getData() async {
    try {
      QuerySnapshot querySnapshot = await Cart.where('uid',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      setState(() {
        data = querySnapshot.docs;
        totalPrice = 0; // Reset the total price when data changes
        for (var item in data) {
          totalPrice += int.parse(
              "${item['data']['price']}"); // Calculate the total price

        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: textappbar()),
      body: RefreshIndicator(
        onRefresh: () async {
          await getData();
        },
        child: Column(
          children: [
            Container(
              height: 550,
              width: 400,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 10,
                  crossAxisCount: 2,
                  mainAxisExtent: 160,
                ),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: Duration(milliseconds: 800),
                    columnCount: 2,
                    child: ScaleAnimation(
                        duration: Duration(milliseconds: 1200),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                        child: InkWell(
                    onLongPress: () {
                      Get.defaultDialog(
                          titlePadding: EdgeInsets.all(20),
                          title: "Do you want remove this ?",
                          content: Container(
                            height: 10,
                            width: 10,
                          ),
                          titleStyle: TextStyle(fontWeight: FontWeight.normal,color: Colors.black),
                          buttonColor: Colors.blue,
                          backgroundColor: Colors.white,
                          textConfirm: "Yes",
                          textCancel: "No",
                          onCancel: () => Navigator.of(context).pop(),
                          onConfirm: () async {
                            await FirebaseFirestore.instance
                                .collection("Cart")
                                .doc(data[index].id)
                                .delete();
                            //   Navigator.of(context).push(
                            //       MaterialPageRoute(builder: (context) => CartA()));
                            // },
                            Navigator.of(context).pop();
                            await getData();
                          });
                    },
                    child: Card(
                      child: Container(
                        height: 300,
                        width: 200,
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 5)),
                            // Image.asset(
                            //   "images/${data[index] }",
                            //   height: 100,
                            //   width: 160,
                            //   fit: BoxFit.scaleDown,
                            // ),
                            Image.asset(
                              "images/${data[index]['data']['image']}",
                              height: 100,
                              width: 160,
                              fit: BoxFit.scaleDown,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${data[index]['data']['name oil'] != null ? data[index]['data']['name oil'] : ""}",
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                ),
                                Text(
                                    "${data[index]['data']['name calander'] != null ? data[index]['data']['name calander'] : ""}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                Text(
                                    " ${data[index]['data']['name filter'] != null ? data[index]['data']['name filter'] : "     "}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                              ],
                            ),
                            Text(
                              "${data[index]['data']['price']}\$",
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))));
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(80),color: Colors.blue,),
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              height: 40,
              width: 500,

              child: Text(
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  " The total price : ${totalPrice} \$"),
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(80),color: Colors.red),
                height: 40,
                width: 400,
                margin: EdgeInsets.all(10),
                child: MaterialButton(
                  splashColor: Colors.green,
                  onPressed: () {
                    List<Map<String, dynamic>> bookingData = [];
                    for (var item in data) {
                      bookingData.add(item['data']);
                    }
                    Navigator.of(context).push(
                     FadeRoute1( BookingPage(data: bookingData),
                      ),
                    );
                  },
                  child: Text("Booking"),

                  textColor: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
class FadeRoute1 extends PageRouteBuilder {
  final Widget page;

  FadeRoute1(this.page)
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: page,
        ),
  );
}
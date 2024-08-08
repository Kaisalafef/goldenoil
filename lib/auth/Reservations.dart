import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goldenoil/WidgetsA/Textappbar.dart';

class Reservations extends StatefulWidget {
  Reservations({super.key});

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  List<QueryDocumentSnapshot> data = [];
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getData();
  }

  // Function to get data from the 'bookings' collection
  Future<void> getData() async {
    try {
      final querySnapshot = await db
          .collection('bookings')
          .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      print('Data fetched: ${querySnapshot.docs}');
      setState(() {
        data = querySnapshot.docs;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textappbar(),
      ),
      body: data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
               shrinkWrap: true,
                    scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10), itemExtent:190,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    delay: Duration(milliseconds: 100),
                child: SlideAnimation(
                duration: Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                verticalOffset: -250,
                child: ScaleAnimation(
                duration: Duration(milliseconds: 1500),
                curve: Curves.fastLinearToSlowEaseIn,
                child: Container(margin: EdgeInsets.only(top:10,bottom: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.indigo.shade50,border: Border.all(color: Colors.black,width: 2.2),borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      
                      
                       
                         Container(
                            height: 200,
                            width: 100,
                            alignment: Alignment.center,
                            child: Image.asset(
                              "images/${data[index]['data'][0]['image']}",
                              fit: BoxFit.fill,height: 100,width: 80,alignment: Alignment.topCenter,
                            )),
                         Container(
                           padding: EdgeInsets.all(20),
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Column(
                              children: [
                                Text(
                                  " Time:  ${data[index]['time']}",
                                  style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Text(
                                  " Date :  ${data[index]['date']}",
                                  style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      IconButton(
                        onPressed: () {

                          Get.defaultDialog(radius: 20,
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
                              onCancel: () => Get.back(),
                              onConfirm: () async {
                                await FirebaseFirestore.instance
                                    .collection("bookings")
                                    .doc(data[index].id)
                                    .delete();

                                Get.back();
                                await getData();
                              });
                        },
                        icon: Icon(
                          Icons.remove,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      
                    ],
                  ),
                ))));
              },
            ),
    );
  }
}

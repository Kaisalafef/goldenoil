import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:goldenoil/Controlare/controler_page.dart';
import 'package:goldenoil/Viwe/homepage.dart';
import 'package:goldenoil/WidgetsA/Textappbar.dart';

class BookingPage extends StatefulWidget {
  final dynamic data;

  const BookingPage({super.key, required this.data});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Timer? _timer;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 10, minute: 00);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: 3), (timer) async {
      await deleteOldBookings();
    });
  }

  Future<void> deleteOldBookings() async {
    final cutoffTime = DateTime.now().millisecondsSinceEpoch - 3 * 60 * 1000; // 3 minutes ago
    final oldBookingsQuery = _firestore.collection('bookings').where('timestamp', isLessThan: cutoffTime);
    final oldBookingsSnapshot = await oldBookingsQuery.get();

    for (var doc in oldBookingsSnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> _makeBooking() async {
    final User? user = _auth.currentUser;
    if (user!= null) {
      if (widget.data!= null) {
        try {
    //      final Map<String, dynamic> data = widget.data;
          final List<Map<String, dynamic>> dataMap =widget.data ;
          // for(var item in widget.data) {
          //   dataMap.add(data);
          // }   // Get the first element of the list

           final bookingData = {
            'user_id': user.uid,
            'date': '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',

            'time': '${_selectedTime.hour}:${_selectedTime.minute}',
            'data': dataMap,
            'timestamp': FieldValue.serverTimestamp(),
          };

          final startTime = DateTime.now().millisecondsSinceEpoch +
              (_selectedTime.hour * 60 * 60 * 1000) +
              (_selectedTime.minute * 60 * 1000);
          final endTime = startTime + (30 * 60 * 1000); // 30 minutes

          final existingBookings = await _firestore.
          collection('bookings')
              .where('date', isEqualTo: '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}')
              .where('time', isEqualTo: '${_selectedTime.hour}:${_selectedTime.minute}')
              .get();

          if (existingBookings.docs.isNotEmpty) {

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(backgroundColor: Colors.red,
                  content: Text('A booking with the same time already exists. Please choose a different time.'),
                  duration: Duration(seconds: 3),
                ),
              );


            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.red,
                content: Text('A booking with the same time already exists. Please choose a different time.'),
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            await _firestore.collection('bookings').add(bookingData);
            _navigateToHomepage();
          }
        } catch (e) {
          print("//////////////////////Error making booking: ${e.toString()}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.red,
              content: Text('Error making booking: $e'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid data'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User is not logged in or email is not verified'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _navigateToHomepage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => homepage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: textappbar(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30,right: 20,top: 30),
        child: Column(
          children: [
            Icon(Icons.access_time_outlined,size: 100,color: Colors.lime,),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 100,vertical: 20),
              child: Text(
                'Select a date:',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
            ),
            Container(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey
                  ,elevation: 20,shadowColor: Colors.yellow,),
                child: Text(

                  '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                  style: TextStyle(fontSize: 17,color:  Colors.white),
                ),
                onPressed: () async {
                  final DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2030),
                  );
                  if (newDate != null) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 100,vertical: 20),
              child: Text(
                'Select a time:',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
            ),

            Container(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey
                  ,elevation: 20,shadowColor: Colors.yellow,),
                child: Text(
                  _selectedTime.hour.toString() + ':' + _selectedTime.minute.toString()  ,
                  style: TextStyle(fontSize: 25,color: Colors.white),
                ),
                onPressed: () async {

                  final TimeOfDay? newTime = await showTimePicker(

                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (newTime!= null) {
                    setState(() {
                    });
                    _selectedTime = newTime;

                  }
                },
              ),
            ),
            SizedBox(height: 60,),
            Container(margin: EdgeInsets.only(top: 30),width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green
                  ,elevation: 20,shadowColor: Colors.orange,),
                child: Text('Make Booking',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  Get.defaultDialog(
                      titlePadding: EdgeInsets.all(20),
                      title: "Do you want to confirm booking?",
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
                        _makeBooking();

                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



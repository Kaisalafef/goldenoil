import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldenoil/Calender/add2.dart';
import 'package:goldenoil/Filter/add3.dart';
import 'package:goldenoil/Oil/add.dart';
import 'package:goldenoil/Viwe/About.dart';
import 'package:goldenoil/Viwe/settings.dart';
import 'package:goldenoil/Oil/add.dart';
import 'package:goldenoil/auth/Reservations.dart';
class drawerA extends StatefulWidget {
  const drawerA({super.key});

  @override
  State<drawerA> createState() => _drawerAState();
}

class _drawerAState extends State<drawerA> {
  @override
  Widget build(BuildContext context) {
    return Container
    (
        height: 1000,
        width: 300,
        decoration: BoxDecoration(
            color: Get.isDarkMode?Colors.teal:Colors.white, borderRadius: BorderRadius.circular(20)),
        child: ListView(
          padding: const EdgeInsets.only(top: 50),
          children: [
            const Row(
              children: [
                Text(
                  "    Golden",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Icon(
                  Icons.water_drop_outlined,
                  color: Colors.yellow,
                  size: 45,
                ),
                Text(
                  "il ",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(25)),
            const Padding(padding: EdgeInsets.all(10)),

            Container(

              width: 300, height: 2, color: Colors.black26),
             ListTile(

               onTap: () => Navigator.of(context).push(FadeRoute1( Reservations(),)),
              title: Text(" Reservations "),
              textColor:  Get.isDarkMode?Colors.white:Colors.black,
              iconColor:  Get.isDarkMode?Colors.white:Colors.black,
              leading: Icon(Icons.pending_actions),
            ),
            Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                width: 300,
                height: 2,
                color: Colors.black26),
            ListTile(
               textColor: Get.isDarkMode?Colors.white:Colors.black,
              iconColor:  Get.isDarkMode?Colors.white:Colors.black,
             title: const Text("Settings"),
              leading: const Icon(Icons.settings),
              onTap: () {
                setState(() {
                  Navigator.of(context).push(FadeRoute1( SettingsPage2(),) );

                });
              },
            ),
            Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                width: 300,
                height: 2,
                color: Colors.black26),
             ListTile(
               onTap: () => Navigator.of(context).push(FadeRoute1( About(),)),
              textColor: Get.isDarkMode?Colors.white:Colors.black,
              iconColor:  Get.isDarkMode?Colors.white:Colors.black,
              title: Text("About"),
              leading: Icon(Icons.info_outline),
            ),
          ],
        ),


    );
  }
}class FadeRoute1 extends PageRouteBuilder {
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
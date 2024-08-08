import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:goldenoil/Calender/add2.dart';
import 'package:goldenoil/Controlare/controler_page.dart';
import 'package:goldenoil/Filter/add3.dart';
import 'package:goldenoil/Oil/add.dart';
import 'package:goldenoil/Services/SherdPrefrenceHelper.dart';
import 'package:goldenoil/Viwe/Calanderdaitles.dart';
import 'package:goldenoil/Viwe/CartA.dart';
import 'package:goldenoil/Viwe/Filterdetails.dart';
import 'package:goldenoil/Viwe/OilDetials.dart';
import 'package:goldenoil/WidgetsA/drawerA.dart';

import 'package:goldenoil/WidgetsA/Textappbar.dart';
import 'package:goldenoil/auth/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// ignore: camel_case_types
// Define the homepage class
class homepage extends StatefulWidget {
  const homepage({
    super.key,
  });

  @override
  State<homepage> createState() => _homepageState();
}

// Define the _homepageState class
class _homepageState extends State<homepage> {
  // Initialize the Firebase FireStore instance
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Initialize the GetX controller
  ControlerPage controler = Get.put(ControlerPage());

  // Function to get data from the 'Oil' collection
  Future<void> getData() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Oil').get();
    data.value = querySnapshot.docs;
  }

  // Function to get data from the 'Calander' collection

  Future<void> getData1() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Calander').get();
    data1.value = querySnapshot.docs;
  }

  // Function to get data from the 'Filter' collection

  Future<void> getData2() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Filter').get();
    data2.value = querySnapshot.docs;
  }

  @override
  void initState() {
    super.initState();

    // Initialize the lists to store the retrieved data

    // Call the functions to retrieve data from the Firestore collections
    getData();
    getData1();
    getData2();
  }

  File? file;
  String? name;

  getImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      // Pick an image.
      final XFile? imageGallery =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageGallery != null) {
        final File imageFile = File(imageGallery.path);
        setState(() {
          file = imageFile;
          print(file);
        });
      }
    } catch (e) {
      print("//////////////////////// : $e");
    }
  }

  int selectindex = 0;

  // Initialize the lists to store the retrieved data
  final data = ValueNotifier<List<QueryDocumentSnapshot>>([]);
  final data1 = ValueNotifier<List<QueryDocumentSnapshot>>([]);
  final data2 = ValueNotifier<List<QueryDocumentSnapshot>>([]);

  List<Widget> LisW = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Define the widgets to display on the homepage
    LisW = [
      // ValueListenableBuilder to display the data from the 'Oil' collection
      ValueListenableBuilder(
        valueListenable: data,
        builder: (context, value, child) {
          return SizedBox(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: value.length,
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
                  onTap: () async {
                    // Navigate to the OilDetails page
                    await Navigator.of(context).push(FadeRoute1( OilDetails(
                              data: value[index],
                            )));
                  },
                  child: Card(
                    surfaceTintColor: Colors.red,
                   shadowColor: Colors.red.shade900,
                    child: Container(
                      height: 300,
                      width: 200,
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 5)),
                          Image.asset(
                            "images/${value[index]['image']}",
                            height: 100,
                            width: 160,
                            fit: BoxFit.scaleDown,
                          ),
                          Text('${value[index]['name oil']}',
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16)),
                          Text(
                            '${value[index]['price']}\$',
                            style: const TextStyle(
                                color: Colors.green, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ))));
              },
            ),
          );
        },
      ),

      // FutureBuilder to display the data from the 'Calender' collection
      ValueListenableBuilder(
        valueListenable: data1,
        builder: (context, value, child) {
          return SizedBox(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: value.length,
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
                  onTap: () async {
                    // Navigate to the OilDetails page
                    await Navigator.of(context).push(FadeRoute1( CalanderDetails(
                              data: value[index],
                            )));
                  },
                  child: Card(
                    surfaceTintColor: Colors.yellow,
                    shadowColor: Colors.yellow.shade900,

                    child: Container(
                      height: 300,
                      width: 200,
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 5)),
                          Image.asset(
                            "images/${value[index]['image']}",
                            height: 100,
                            width: 160,
                            fit: BoxFit.scaleDown,
                          ),
                          Text('${value[index]['name calander']}',
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16)),
                          Text(
                            '${value[index]['price']}\$',
                            style: const TextStyle(
                                color: Colors.green, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ))));
              },
            ),
          );
        },
      ),

      // FutureBuilder to display the data from the 'Filter' collection
      ValueListenableBuilder(
        valueListenable: data2,
        builder: (context, value, child) {
          return SizedBox(
            child: GridView.builder(

              shrinkWrap: true,
              itemCount: value.length,
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
                  onTap: () async {
                    // Navigate to the OilDetails page
                    await Navigator.of(context).push(FadeRoute1( FilterDetails(
                              data: value[index],
                            )));
                  },
                  child: Card(

                    surfaceTintColor: Colors.green,
                    color: Colors.white,
                    shadowColor: Colors.green.shade900,
                    child: Container(

                      height: 300,
                      width: 200,
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 5)),
                          Image.asset(
                            "images/${value[index]['image']}",
                            height: 100,
                            width: 160,
                            fit: BoxFit.scaleDown,
                          ),
                          Text(
                            '${value[index]['name filter']}',
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16),
                          ),
                          Text(
                            '${value[index]['price']}\$',
                            style: const TextStyle(
                                color: Colors.green, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ))));
              },
            ),
          );
        },
      ),

      ////////////////////////////////
      //Profile
      ////////////////////////////////
      ListView(
        children: [
          Column(children: [
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(80)),
                margin: EdgeInsets.only(top: 130),
                height: 140,
                width: 140,
                child: InkWell(
                    onTap: () async {
                      await getImage();
                    },
                    child: Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: Colors.grey.shade50,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: file != null
                            ? Image.file(
                                file!,
                                fit: BoxFit.cover,
                                width: 140,
                                height: 140,
                              )
                            : Icon(
                                Icons.person,
                                size: 100,color: Colors.amber
                              ),
                      ),
                    )))
          ]),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.orangeAccent,
                ),
                hintText: "enter your name",
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w500),
                hintMaxLines: 20,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Colors.orangeAccent, width: 2.5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          Container(
            height: 30,
          ),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.car_repair,
                  color: Colors.pinkAccent,
                ),
                hintText: "enter your car",
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w500),
                hintMaxLines: 20,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.pinkAccent, width: 2.5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          Container(
            height: 30,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.format_list_numbered,
                  color: Colors.teal,
                ),
                hintText: "enter your id_car",
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w500),
                hintMaxLines: 20,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.teal, width: 2.5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          Container(
            height: 10,
          ),
          Container(
            height: 10,
          ),
          Container(
            height: 40,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 130, vertical: 30),
            child: MaterialButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              textColor: Colors.white,
              splashColor: Colors.red,
              onPressed: () async {
                Get.defaultDialog(
                    titlePadding: EdgeInsets.all(20),
                    title: "Do you want sgin out ?",
                    content: Container(
                      height: 10,
                      width: 10,
                    ),
                    titleStyle: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black),
                    buttonColor: Colors.blue,
                    backgroundColor: Colors.white,
                    textConfirm: "Yes",
                    textCancel: "No",
                    onCancel: () => Navigator.of(context).pop(),
                    onConfirm: () async {
                      GoogleSignIn googlesignin = GoogleSignIn();
                      googlesignin.disconnect();
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => login()),
                            (Route<dynamic> rout) => false);
                        ;
                      });
                    });
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  height: 50,
                  width: 70,
                  alignment: Alignment.center,
                  child: const Text(
                    "Sign Out",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
          )
        ],
      )
    ];
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
              await Navigator.of(context)
                  .push(FadeRoute1(CartA()));
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.amber,
            ))
      ], centerTitle: true, title: const textappbar()),

      /////////

// Drawer

      /////////
      drawer: const drawerA(),

      /////////

// bottomNavigationBar

      /////////
      bottomNavigationBar: GetBuilder<ControlerPage>(
        init: ControlerPage(),
        builder: (controler) => SalomonBottomBar(
          currentIndex: selectindex,
          onTap: (i) {
            //controler.counter =i;

            selectindex = i;
            controler.update();
          },
          backgroundColor: Get.isDarkMode ? Colors.teal : Colors.white,
          unselectedItemColor: Colors.black,
          items: [
            /// OIl
            SalomonBottomBarItem(
              icon: const Icon(Icons.oil_barrel),
              title: const Text("Oil"),
              selectedColor: Colors.deepOrange,
            ),

            /// CALENDER
            SalomonBottomBarItem(
              icon: const Icon(Icons.settings_input_component_sharp),
              title: const Text("Colander"),
              selectedColor: Colors.amber,
            ),

            /// Filter
            SalomonBottomBarItem(
              icon: const Icon(Icons.settings_input_hdmi),
              title: const Text("Filter"),
              selectedColor: Colors.green,
            ),

            /// PROFILE
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profile"),
              selectedColor: Colors.blue,
            ),
          ],
        ),
      ),

//////////
      // BODY
////////////

      body: RefreshIndicator(
          onRefresh: () async {
            // Call your refresh functions here
            await getData();
            await getData1();
            await getData2();
          },
          child: GetBuilder<ControlerPage>(
              init: ControlerPage(),
              builder: (controler) {
                return Container(child: LisW.elementAt(selectindex));
              })),
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
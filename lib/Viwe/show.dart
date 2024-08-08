import 'package:concentric_transition/concentric_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldenoil/Controlare/controler_page.dart';
import 'package:goldenoil/Viwe/homepage.dart';
import 'package:goldenoil/auth/login.dart';

final pages = [
  PageData(
    icon: Icons.oil_barrel,
    title: "Buy the perfect product for your car",
    bgColor: Color(0xff3b1791),
    textColor: Colors.white,
  ),
  PageData(
    icon: Icons.shopping_bag_outlined,
    title: "Add it to cart",
    bgColor: Color(0xfffab800),
    textColor: Color(0xff3b1790),
  ),
  PageData(
    icon: Icons.drive_eta,
    title: "Book the order and \n Go..",
    bgColor: Color(0xffffffff),
    textColor: Color(0xff3b1790),
  ),
];

class ConcentricAnimationOnboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final controlerPage = Get.put(ControlerPage());

    return Scaffold(
      body: GetBuilder<ControlerPage>(
        builder: (controlerPage) {
          return ConcentricPageView(
            colors: pages.map((p) => p.bgColor).toList(),
            radius: screenWidth * 0.1,
            nextButtonBuilder: (context) => Padding(
              padding: const EdgeInsets.only(left: 3), // visual center
              child: Icon(
                Icons.navigate_next,
                size: screenWidth * 0.08,
              ),
            ),
            itemBuilder: (index) {
              if (index <= 2) {
                final page = pages[index % pages.length];
                return SafeArea(
                  child: _Page(page: page),
                );
              } else if (index == 3) {
                Future.delayed(Duration.zero, () {
                  if(FirebaseAuth.instance.currentUser == null){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => login()),
                  );}else{
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => homepage()));
                  }
                });
                controlerPage.counter++;
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}

class PageData {
  final IconData icon;
  final String title;
  final Color bgColor;
  final Color textColor;

  PageData({
    required this.icon,
    required this.title,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

class _Page extends StatelessWidget {
  final PageData page;

  const _Page({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(shape: BoxShape.circle, color: page.textColor),
          child: Icon(
            page.icon,
            size: screenHeight * 0.1,
            color: page.bgColor,
          ),
        ),
        Text(
          page.title,
          style: TextStyle(
            color: page.textColor,
            fontSize: screenHeight * 0.030,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class About extends StatefulWidget {
  About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),centerTitle: true,
      automaticallyImplyLeading: true,
        backgroundColor: Colors.grey.shade100,
      ),
      body: Stack(
        children: [
          Image.asset(height: 4000,fit: BoxFit.cover,'images/44.jpg'),
          Container(

          ),
          Container(margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              'our application for purchasing car oils, filters, and filters provides users with a convenient and easy way to buy these products efficiently.'
                  ' The application allows users to choose the items they want to purchase from a variety of available oils, filters, and filters.'
                  'When the user selects the products they need, they can specify the quantity required and add them to the shopping cart in the application.'
                  ' Users can also choose the option to schedule a visit to an oil change center or auto workshop to install the products they purchased.'
                  'users can save time and effort in searching for car oil products, filters, and filters,'
                  ' and the application helps them ensure the quality of the products and ease of obtaining them quickly and efficiently.',
              style: TextStyle(
                  color: Colors.grey.shade500,fontWeight: FontWeight.bold,fontSize: 20 // adjust text color based on your background image
              ),
            ),
          ),
        ],
      ),
    );
  }
}
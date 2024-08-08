import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldenoil/Controlare/controler_page.dart';
import 'package:goldenoil/Viwe/homepage.dart';
import 'package:goldenoil/auth/booking.dart';
import 'package:goldenoil/auth/login.dart';
import 'package:goldenoil/firebase_options.dart';
import 'Viwe/show.dart';
import 'WidgetsA/themw.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ControlerPage _controlerPage = Get.put(ControlerPage());

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('////////////User is currently signed out!');
      } else {
        print('////////////User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(



      debugShowCheckedModeBanner: false,
      title: 'Get',

      theme: Thems.customlightThem,
      home:
      ConcentricAnimationOnboarding()


    );

    }
}

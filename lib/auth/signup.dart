import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldenoil/Viwe/homepage.dart';
import 'package:goldenoil/auth/login.dart';
import 'package:goldenoil/components/customlogoauth.dart';
import 'package:goldenoil/components/cutombuttonauth.dart';
import 'package:goldenoil/components/textformfiled.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController idCar = TextEditingController();

    TextEditingController TypeCar = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController email = TextEditingController();
    GlobalKey<FormState> formState = GlobalKey();

    return Scaffold(
        body: Stack(
          children: [
            Image.asset('images/5.jpg',fit: BoxFit.cover,height: 4000,width: 400,),

            Form(
              key: formState,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                      children: [
                Container(
                  height: 40,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Sign Up ",
                    style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Sign Up to Continue Using Tha App",style: TextStyle(color: Colors.white),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Username",
                    style: TextStyle(fontSize: 22,color: Colors.white),
                  ),
                ),
                textformfild(hinttext: "enter your name", mycontroller: username),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 22,color: Colors.white),
                  ),
                ),
                textformfild(hinttext: "enter your email", mycontroller: email),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "ID Car",
                    style: TextStyle(fontSize: 22,color: Colors.white),
                  ),
                ),
                textformfild(hinttext: "enter your id car", mycontroller: idCar),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Type Car",
                    style: TextStyle(fontSize: 22,color: Colors.white),
                  ),
                ),
                textformfild(hinttext: "enter your type car", mycontroller: TypeCar),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                textformfild(hinttext: "enter your password", mycontroller: password),
                Container(height: 40),
                CustomButtonAuth(
                  text: "Sign up",
                  colors: Colors.blue,
                  onPressed: () async {
                    try {
                      final credential =
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      Get.off(login());
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Get.off(login());
                      },
                      child: const Center(
                        child: Text.rich(TextSpan(children: [
                          TextSpan(text: " Have an Acocnut ?  "),
                          TextSpan(
                              text: "\n          Login",
                              style: TextStyle(color: Colors.blue, fontSize: 18))
                        ])),
                      )),
                ),
                      ],
                    ),
              ),
            ),
          ],
        ));
  }
}

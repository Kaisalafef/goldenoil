import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:goldenoil/Controlare/controler_page.dart';
import 'package:goldenoil/Viwe/homepage.dart';
import 'package:goldenoil/auth/signup.dart';
import 'package:goldenoil/components/cutombuttonauth.dart';
import 'package:goldenoil/components/textformfiled.dart';
import 'package:goldenoil/components/customlogoauth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class login extends StatelessWidget {
  login({super.key});

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }

//  Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.off(homepage());
    });
  }

  ControlerPage controlerText = Get.put(ControlerPage());

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(
        'images/5.jpg',
        fit: BoxFit.cover,
        height: 4000,
        width: 400,
      ),
      Container(),
      Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: const Text(
                  "Login ",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Login to continue using the app ",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10),
                child: const Text(
                  "Email ",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              textformfild(
                hinttext: "Enter your email",
                mycontroller: email,
                validet: (p0) {
                  if (p0 == "") return "Can't to be Empty";
                  if (p0 != email) return "Wrong Email";
                },
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                child: const Text(
                  "Password ",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              textformfild(
                hinttext: "Enter your password",
                mycontroller: password,
                validet: (val) {
                  if (val == "") return "Can't to be Empty";
                  if (val != password) return "Wrong Password";
                },
              ),
              InkWell(
                onTap: () async {
                  if (email.text == "") {
                    return Get.defaultDialog(
                      contentPadding: EdgeInsets.all(50),
                      titleStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          height: 2),
                      title: "Error",
                      middleText: "the email is Empty \n write your email",
                      middleTextStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    );
                  }

                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email.text);
                    Get.defaultDialog(
                      contentPadding: EdgeInsets.all(50),
                      titleStyle: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          height: 2),
                      title: "Done",
                      middleText: "The link has been sent to your password",
                      middleTextStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    );
                  } catch (e) {
                    Get.defaultDialog(
                      contentPadding: EdgeInsets.all(50),
                      backgroundColor: Colors.grey,
                      content: Container(
                        height: 80,
                        width: 100,
                        child: Text(
                          "Your email in not found \n pleas write your email correctly",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      titleStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          height: 2),
                      title: "Error",
                    );
                    print(e);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Forget Password ?",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              CustomButtonAuth(
                text: 'Login',
                colors: Colors.blue,
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text);

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Get.off(homepage());
                    });
                  } on FirebaseAuthException catch (e) {
                    if (formState.currentState!.validate()) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "or Login ",
                  textAlign: TextAlign.center,
                ),
              ),
              CustomButtonAuth(
                  text: 'Login with Google ',
                  colors: Colors.red,
                  onPressed: () {
                    signInWithGoogle();
                  }),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                    onTap: () {
                      Get.off(const SignUp());
                    },
                    child: const Center(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(text: "Dont Have an Account ?  "),
                        TextSpan(
                            text: "\n            Rigester",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                      ])),
                    )),
              )
            ],
          ),
        ),
      ),
    ]));
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/authentication/forgot.dart';
import 'package:thriftstore/authentication/registration.dart';
import 'package:thriftstore/widgets.dart';

import 'authenticate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

TextEditingController controllerMail = TextEditingController();
TextEditingController controllerPass = TextEditingController();

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 150,
            ),
            Text(
              "Thriftstore",
              style: GoogleFonts.lato(
                  color: mainColor, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20, top: 100),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10), blurRadius: 7, color: Colors.grey)
                ],
              ),
              child: TextField(
                controller: controllerMail,
                cursorColor: mainColor,
                decoration: InputDecoration(
                  icon: Icon(Icons.email, color: mainColor),
                  hintText: "ENTER THE EMAIL",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 7,
                    color: Colors.grey,
                  )
                ],
              ),
              child: TextField(
                controller: controllerPass,
                cursorColor: mainColor,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.vpn_key, color: mainColor),
                  hintText: "ENTER THE PASSWORD",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Forgot()),
                  );
                },
                child: Text("Forgot your Password?"),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (controllerMail.text.isEmpty ||
                    controllerPass.text.isEmpty) {
                  showdialogue("Error", "fill all the fields", context);
                } else {
                  Map<String, String?> flag = await signinemail(
                      controllerMail.text, controllerPass.text);
                  // ignore: unrelated_type_equality_checks
                  if (flag["status"] != "success") {
                    showdialogue("Error", flag['status']!, context);
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: mainColor,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 20),
                        blurRadius: 6,
                        color: Colors.grey.shade300)
                  ],
                ),
                child: Text(
                  "LOGIN",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have any account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Text(
                      "Register Now",
                      style: TextStyle(color: mainColor),
                    ),
                  )
                ],
              ),
            )
          ]),
        ));
  }
}

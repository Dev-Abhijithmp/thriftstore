import 'package:flutter/material.dart';
import 'package:thriftstore/authentication/authenticate.dart';
import 'package:thriftstore/widgets.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

TextEditingController controllerMail = TextEditingController();
TextEditingController controllerPass = TextEditingController();
TextEditingController controllername = TextEditingController();
TextEditingController controllerRepass = TextEditingController();
TextEditingController controllernum = TextEditingController();

class RegisterState extends State<Register> {
  get flag => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[300],
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 7,
              color: Colors.grey,
            )
          ],
        ),
        child: TextField(
          controller: controllername,
          cursorColor: const Color(0xffF5591F),
          decoration: const InputDecoration(
            icon: Icon(Icons.person, color: mainColor),
            hintText: "ENTER THE NAME",
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[300],
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 5,
              color: Colors.grey,
            )
          ],
        ),
        child: TextField(
          controller: controllerMail,
          cursorColor: mainColor,
          decoration: const InputDecoration(
            icon: Icon(Icons.email, color: mainColor),
            hintText: "ENTER THE EMAIL",
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[300],
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 5,
              color: Colors.grey,
            )
          ],
        ),
        child: TextField(
          controller: controllernum,
          cursorColor: mainColor,
          decoration: const InputDecoration(
            icon: Icon(Icons.call, color: mainColor),
            hintText: "ENTER YOUR PHONE NUMBER",
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[300],
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 5,
              color: Colors.grey,
            )
          ],
        ),
        child: TextField(
          controller: controllerPass,
          cursorColor: mainColor,
          decoration: const InputDecoration(
            icon: Icon(Icons.password, color: mainColor),
            hintText: "ENTER THE PASSWORD?",
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[300],
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 5,
              color: Colors.grey,
            )
          ],
        ),
        child: TextField(
          controller: controllerRepass,
          cursorColor: mainColor,
          decoration: const InputDecoration(
            icon: Icon(Icons.password, color: mainColor),
            hintText: "RE-ENTER THE PAASWORD",
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      GestureDetector(
          onTap: () async {
            if (controllerMail.text.isEmpty ||
                controllerPass.text.isEmpty ||
                controllername.text.isEmpty ||
                controllerRepass.text.isEmpty ||
                controllernum.text.isEmpty) {
              showdialogue("Error", "fill all the fields", context);
            } else {
              if (controllerPass.text == controllerRepass.text) {
                Map<String, String?> flag = await register(
                    controllerMail.text,
                    controllerPass.text,
                    controllername.text,
                    controllernum.text);
                // ignore: unrelated_type_equality_checks
                if (flag["status"] != "success") {
                  showdialogue("Error", flag['status']!, context);
                } else {
                  Navigator.pop(context);
                }
              } else {
                showdialogue("Error", "password didnt match", context);
              }
            }
          },
          child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: mainColor,
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: const Text(
                "REGISTER",
                style: TextStyle(color: Colors.white),
              ))),
      const SizedBox(
        height: 10,
      ),
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Have Already Member?"),
            GestureDetector(
              onTap: () {},
              child: const Text(
                "LOGIN NOW",
                style: TextStyle(color: mainColor),
              ),
            )
          ],
        ),
      ),
    ])));
  }
}

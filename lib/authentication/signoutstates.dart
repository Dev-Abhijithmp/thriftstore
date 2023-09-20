// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:thriftstore/authentication/authenticate.dart';
import 'package:thriftstore/authentication/login.dart';
import 'package:thriftstore/home/navbar.dart';
import 'package:thriftstore/innerscreen/loadingpage.dart';
import 'package:thriftstore/innerscreen/somethingwentwrong.dart';

class Signinout extends StatefulWidget {
  const Signinout({Key? key}) : super(key: key);

  @override
  _SigninoutState createState() => _SigninoutState();
}

class _SigninoutState extends State<Signinout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: StreamBuilder(
          stream: changesign,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Somethingwentwrong();
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Navbar();
            } else if (snapshot.hasData) {
              return Navbar();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Loadingpage();
            } else {
              return LoginPage();
            }
          }),
    );
  }
}

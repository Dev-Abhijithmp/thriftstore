// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, camel_case_types, unused_field

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thriftstore/authentication/signoutstates.dart';
import 'package:thriftstore/innerscreen/loadingpage.dart';
import 'package:thriftstore/innerscreen/somethingwentwrong.dart';
import 'package:thriftstore/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Home());
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: mainColor,
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Somethingwentwrong();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Signinout();
            }
            return Loadingpage();
          }),
    );
  }
}

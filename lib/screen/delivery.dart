// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:thriftstore/screen/deliveryhome.dart';
import 'package:thriftstore/screen/profile.dart';

class delivery extends StatefulWidget {
  delivery({Key? key}) : super(key: key);

  @override
  _deliveryState createState() => _deliveryState();
}

class _deliveryState extends State<delivery> {
  int selectedindex = 0;
  List<Color> curvedcolor = [
    Colors.deepOrange,
    Colors.black,
  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [deliverypage(), Profilepage()];
    void changeindex(int index) {
      setState(() {
        selectedindex = index;
        curvedcolor[0] = Colors.black;
        curvedcolor[1] = Colors.black;
        curvedcolor[selectedindex] = Colors.deepOrange;
      });
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      body: pages[selectedindex],
      bottomNavigationBar: CurvedNavigationBar(
          color: Colors.orange,
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.white,
          height: 50,
          index: selectedindex,
          onTap: changeindex,
          items: [
            Icon(
              Icons.home,
              color: curvedcolor[0],
            ),
            Icon(
              Icons.person,
              color: curvedcolor[1],
            ),
          ]),
    );
  }
}

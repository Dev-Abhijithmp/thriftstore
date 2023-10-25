// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:thriftstore/home/productscreen.dart';
import 'package:thriftstore/screen/profile.dart';
import 'package:thriftstore/screen/searchpage.dart';
import 'package:thriftstore/widgets.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  NavbarState createState() => NavbarState();
}

class NavbarState extends State<Navbar> {
  int selectedindex = 0;
  List<Color> curvedcolor = [
    mainColor,
    Colors.black,
    Colors.black,
  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [ProductHome(), SearchPage(), Profilepage()];

    void changeindex(int index) {
      setState(() {
        selectedindex = index;
        curvedcolor[0] = Colors.black;
        curvedcolor[1] = Colors.black;
        curvedcolor[2] = Colors.black;
        curvedcolor[selectedindex] = mainColor;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: pages[selectedindex],
      bottomNavigationBar: CurvedNavigationBar(
          color: mainColor,
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
              Icons.search,
              color: curvedcolor[1],
            ),
            Icon(
              Icons.person,
              color: curvedcolor[2],
            ),
          ]),
    );
  }
}

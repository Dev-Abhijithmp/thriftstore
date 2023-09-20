// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/sellorrent/addproduct.dart';
import 'package:thriftstore/widgets.dart';

bool is_selected = false;

class SellorRent extends StatefulWidget {
  const SellorRent({Key? key}) : super(key: key);

  @override
  SellorRentState createState() => SellorRentState();
}

class SellorRentState extends State<SellorRent> {
  int index = 0;
  List<Color> welcomecolor = [
    Colors.white,
    Colors.white,
  ];
  List<Widget> page = [
    AddProduct(
      type: 'rent',
    ),
    AddProduct(type: 'sell')
  ];
  void changecolor(int val) {
    setState(() {
      index = val;
      welcomecolor[0] = Colors.white;
      welcomecolor[1] = Colors.white;
      welcomecolor[val] = mainColor;
      is_selected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("choose any one"),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      changecolor(0);
                    },
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          color: welcomecolor[0],
                          border: Border.all(color: mainColor, width: 2),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        Icons.production_quantity_limits,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Rent",
                    style: GoogleFonts.notoSans(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
              SizedBox(
                width: 60,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      changecolor(1);
                    },
                    child: Container(
                      height: 90,
                      width: 90,
                      child: Icon(
                        Icons.shopping_bag,
                        size: 60,
                      ),
                      decoration: BoxDecoration(
                          color: welcomecolor[1],
                          border: Border.all(color: mainColor, width: 2),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sell",
                    style: GoogleFonts.notoSans(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 300,
          ),
          is_selected
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return page[index];
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(115)),
                    child: const Center(
                      child: Text("Proceed"),
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                ),
        ],
      ),
    );
  }
}

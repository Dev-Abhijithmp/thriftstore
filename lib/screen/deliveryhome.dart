// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/authentication/authenticate.dart';
import 'package:thriftstore/screen/deliverydetails.dart';
import 'package:thriftstore/screen/deliverystatus.dart';

class deliverypage extends StatefulWidget {
  deliverypage({Key? key}) : super(key: key);

  @override
  _deliverypageState createState() => _deliverypageState();
}

class _deliverypageState extends State<deliverypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        height: 500,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: const [(Color(0xffF5591F)), Color(0xffF2861E)],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight)),
        child: Container(
            margin: EdgeInsets.only(right: 30, top: 150, left: 30),
            alignment: Alignment.topCenter,
            child: Text("ACCEPTER",
                style: GoogleFonts.blackHanSans(
                    fontWeight: FontWeight.w300,
                    fontSize: 40,
                    color: Colors.white))),
      ),
      Padding(
          padding: EdgeInsets.only(top: 250),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(40)),
            ),
            child: Column(children: [
              Container(
                child: Column(
                  children: [
                    Column(children: [
                      Column(children: [
                        Container(
                          width: 170,
                          height: 65,
                          margin: EdgeInsets.only(left: 25, top: 40),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade500,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.person_add,
                              size: 40,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => details()));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Donation",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.blackHanSans(fontSize: 15),
                          ),
                        )
                      ]),
                      Column(
                        children: [
                          Container(
                              width: 170,
                              height: 65,
                              margin: EdgeInsets.only(left: 30, top: 40),
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade600,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.book_online,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                deliverystatus()));
                                  })),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 23),
                              child: Text(
                                "completed",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.blackHanSans(fontSize: 15),
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              width: 170,
                              height: 65,
                              margin: EdgeInsets.only(left: 30, top: 40),
                              decoration: BoxDecoration(
                                color: Colors.redAccent.shade400,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.logout,
                                  size: 40,
                                ),
                                onPressed: () {
                                  signout();
                                  Navigator.canPop(context)
                                      ? Navigator.pop(context)
                                      : null;
                                },
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 27),
                            child: Text(
                              "Logout",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.blackHanSans(fontSize: 15),
                            ),
                          )
                        ],
                      )
                    ])
                  ],
                ),
              )
            ]),
          ))
    ]));
  }
}

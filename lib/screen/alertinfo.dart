// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

showDialogwidget(
  BuildContext context,
  String name,
  String address,
  String phone,
) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.orange.shade50,
            title: Text("Details"),
            // ignore: sized_box_for_whitespace
            content: Container(
                width: double.infinity,
                height: 250,
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        "Name      :",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black),
                            fontSize: 20),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                        left: 40,
                      )),
                      Text(
                        name,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black),
                            fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Address   :",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black),
                            fontSize: 20),
                      ),
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Text(
                        address,
                        textAlign: TextAlign.left,
                        maxLines: 5,
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black),
                            fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "mobile    :",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black),
                            fontSize: 20),
                      ),
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Text(
                        "+91" + phone,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black),
                            fontSize: 20),
                      ),
                    ],
                  ),
                ])),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("cancel"))
            ],
          ));
}

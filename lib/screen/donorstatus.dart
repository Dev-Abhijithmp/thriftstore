// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/add/functions.dart';
import 'package:thriftstore/innerscreen/loadingpage.dart';
import 'package:thriftstore/innerscreen/somethingwentwrong.dart';

class donarstatus extends StatefulWidget {
  donarstatus({Key? key}) : super(key: key);

  @override
  _donarstatusState createState() => _donarstatusState();
}

class _donarstatusState extends State<donarstatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              gradient: const LinearGradient(
                  colors: [(Color(0xffF5591F)), Color(0xffF2861E)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight)),
          child: Container(
            margin: EdgeInsets.only(right: 30, top: 60, left: 40),
            alignment: Alignment.center,
            child: Text("FUDON",
                style: GoogleFonts.blackHanSans(
                    fontWeight: FontWeight.w300,
                    fontSize: 30,
                    textStyle: TextStyle(color: Colors.white))),
          )),
      SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('donations')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError == true) {
              return Somethingwentwrong();
            } else if (snapshot.hasData == true) {
              List<DocumentSnapshot> docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return singlestatusitem(docs[index]);
                },
              );
            } else {
              return Loadingpage();
            }
          },
        ),
      ),
    ]));
  }
}

Widget singlestatusitem(DocumentSnapshot doc) {
  return Container(
    width: 350,
    height: 300,
    margin: EdgeInsets.only(left: 20, top: 65, right: 20),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(children: [
      Text(doc.get('status').toString().toUpperCase(),
          style: GoogleFonts.abrilFatface(
              textStyle: TextStyle(color: Colors.black), fontSize: 25)),
      SizedBox(height: 10),
      // Row(
      //   children: [
      //     Padding(padding: EdgeInsets.only(left: 30)),
      //     Text(
      //       "date        :",
      //       textAlign: TextAlign.left,
      //       style: GoogleFonts.kanit(
      //           textStyle: TextStyle(color: Colors.black), fontSize: 20),
      //     ),
      //     Padding(padding: EdgeInsets.only(left: 70)),
      //     Text(
      //       date,
      //       textAlign: TextAlign.left,
      //       style: GoogleFonts.kanit(
      //           textStyle: TextStyle(color: Colors.black), fontSize: 20),
      //     ),
      //   ],
      // ),
      SizedBox(height: 10),
      Row(
        children: [
          Padding(padding: EdgeInsets.only(left: 30)),
          Text(
            "category   :",
            textAlign: TextAlign.left,
            style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black), fontSize: 20),
          ),
          Padding(padding: EdgeInsets.only(left: 70)),
          Text(
            doc.get('foodtype'),
            textAlign: TextAlign.left,
            style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black), fontSize: 20),
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Padding(padding: EdgeInsets.only(left: 30)),
          Text(
            "vehicle     :",
            textAlign: TextAlign.left,
            style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black), fontSize: 20),
          ),
          Padding(padding: EdgeInsets.only(left: 70)),
          Text(
            doc.get('vehcle'),
            textAlign: TextAlign.left,
            style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black), fontSize: 20),
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Padding(padding: EdgeInsets.only(left: 30)),
          Text(
            "food kg    :",
            textAlign: TextAlign.left,
            style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black), fontSize: 20),
          ),
          Padding(padding: EdgeInsets.only(left: 70)),
          Text(
            doc.get('weight'),
            textAlign: TextAlign.left,
            style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black), fontSize: 20),
          ),
        ],
      ),
      Spacer(),
      doc.get('status') == 'placed'
          ? ElevatedButton(
              onPressed: () {
                removedonation(doc.id);
              },
              child: Text("Remove"))
          : Container(),
    ]),
  );
}

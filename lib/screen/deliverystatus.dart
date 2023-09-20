// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/add/functions.dart';
import 'package:thriftstore/innerscreen/loadingpage.dart';
import 'package:thriftstore/innerscreen/somethingwentwrong.dart';

class deliverystatus extends StatefulWidget {
  deliverystatus({Key? key}) : super(key: key);

  @override
  _deliverystatusState createState() => _deliverystatusState();
}

class _deliverystatusState extends State<deliverystatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
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
                        fontSize: 25,
                        textStyle: TextStyle(color: Colors.white))),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('accept')
                  .where('status', isEqualTo: 'ongoing')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError == true) {
                  return Somethingwentwrong();
                } else if (snapshot.hasData == true) {
                  List<DocumentSnapshot> docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return singlecompletingitem(docs[index]);
                    },
                  );
                } else {
                  return Loadingpage();
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}

Widget singlecompletingitem(DocumentSnapshot doc) {
  return Container(
    height: 200,
    width: 350,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white38,
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
    // ignore: prefer_const_literals_to_create_immutables
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(doc.get('status'),
            style: GoogleFonts.abrilFatface(
                textStyle: TextStyle(color: Colors.black), fontSize: 20)),
        Padding(padding: EdgeInsets.only(left: 10, top: 10)),
        Row(
          children: [
            Text(" Donator Name           :",
                style: GoogleFonts.abrilFatface(
                    textStyle: TextStyle(color: Colors.black), fontSize: 17)),
            Padding(padding: EdgeInsets.only(left: 70)),
            Container(
              width: 100,
              child: Text(
                doc.get('uid'),
                textAlign: TextAlign.left,
                maxLines: 3,
                style: GoogleFonts.abrilFatface(
                    textStyle: TextStyle(color: Colors.black), fontSize: 15),
              ),
            ),
          ],
        ),
        // Row(children: [
        //   Padding(padding: EdgeInsets.only(left: 5)),
        //   Text(
        //     "Date                                   :",
        //     textAlign: TextAlign.left,
        //     style: GoogleFonts.abrilFatface(
        //         textStyle: TextStyle(color: Colors.black), fontSize: 17),
        //   ),
        //   Padding(padding: EdgeInsets.only(left: 70)),
        //   Text(
        //     " 2021:07:10",
        //     textAlign: TextAlign.left,
        //     style: GoogleFonts.abrilFatface(
        //         textStyle: TextStyle(color: Colors.black), fontSize: 17),
        //   ),
        // ]),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 5)),
            Text(
              "Category                        :",
              textAlign: TextAlign.left,
              style: GoogleFonts.abrilFatface(
                  textStyle: TextStyle(color: Colors.black), fontSize: 17),
            ),
            Padding(padding: EdgeInsets.only(left: 70)),
            SizedBox(
              width: 100,
              child: Text(
                doc.get("donationtype"),
                textAlign: TextAlign.left,
                style: GoogleFonts.abrilFatface(
                    textStyle: TextStyle(color: Colors.black), fontSize: 17),
              ),
            ),
          ],
        ),
        InkWell(
            onTap: () async {
              changestatus(doc.id, 'completed');
              changestatusaccept(doc.id, 'completed');
            },
            child: Container(
              width: 200,
              height: 30,
              margin: EdgeInsets.only(top: 45, left: 65),
              decoration: BoxDecoration(
                  color: Colors.orange.shade400,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "          Complete >>>>",
                style: GoogleFonts.bebasNeue(
                    textStyle: TextStyle(color: Colors.white), fontSize: 20),
                textAlign: TextAlign.center,
              ),
            )),
      ],
    ),
  );
}

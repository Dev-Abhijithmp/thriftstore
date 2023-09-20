// ignore_for_file: prefer_const_constructors_in_immutables, camel_case_types, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/add/functions.dart';
import 'package:thriftstore/innerscreen/loadingpage.dart';
import 'package:thriftstore/innerscreen/somethingwentwrong.dart';

class details extends StatefulWidget {
  details({Key? key}) : super(key: key);

  @override
  detailsState createState() => detailsState();
}

class detailsState extends State<details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 150,
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
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 150,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('donations')
                .where('status', isEqualTo: 'placed')
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
                    return singleacceptitem(docs[index], context);
                  },
                );
              } else {
                return Loadingpage();
              }
            },
          ),
        )
      ],
    ));
  }
}

Widget singleacceptitem(DocumentSnapshot doc, context) {
  return Container(
    width: double.infinity,
    height: 400,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
            colors: [(Color(0xFFFFCCBC)), Color(0xFFFBE9E7)],
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight)),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 105,
              height: 35,
              margin: EdgeInsets.only(
                left: 10,
                top: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                doc.get('donationtype'),
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                    textStyle: TextStyle(color: Colors.black), fontSize: 20),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 30)),
            Text(
              "weight    :",
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
        SizedBox(height: 20),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 30)),
            Text(
              "vehicle   :",
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
        SizedBox(height: 20),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 30)),
            Text(
              "mobile   :",
              textAlign: TextAlign.left,
              style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black), fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(left: 70)),
            Text(
              "+91 " + doc.get('phone'),
              textAlign: TextAlign.left,
              style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black), fontSize: 20),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 30)),
            Text(
              "ADDRESS    :",
              textAlign: TextAlign.left,
              style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black), fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(left: 70)),
            Text(
              doc.get('address'),
              textAlign: TextAlign.left,
              style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black), fontSize: 20),
            ),
          ],
        ),
        SizedBox(height: 20),

        // Row(
        //   children: [
        //     Padding(padding: EdgeInsets.only(left: 30)),
        //     Text(
        //       "date      :",
        //       textAlign: TextAlign.left,
        //       style: GoogleFonts.kanit(
        //           textStyle: TextStyle(color: Colors.black),
        //           fontSize: 20),
        //     ),
        //     Padding(padding: EdgeInsets.only(left: 70)),
        //     Text(
        //       " 2021:07:10",
        //       textAlign: TextAlign.left,
        //       style: GoogleFonts.kanit(
        //           textStyle: TextStyle(color: Colors.black),
        //           fontSize: 20),
        //     ),
        //   ],
        // ),
        Spacer(),
        Container(
          width: 350,
          height: 45,
          decoration: BoxDecoration(
              color: Colors.orange.shade300,
              border: Border.all(color: Colors.deepOrange),
              borderRadius: BorderRadius.circular(10)),
          child: GestureDetector(
              onTap: () async {
                await Acceptfood(
                    doc.get('donationtype'),
                    doc.get('foodtype'),
                    doc.get('weight'),
                    doc.get('vehcle'),
                    doc.get('address'),
                    doc.get('district'),
                    doc.get('phone'),
                    doc.get('donationid'));
                changestatus(doc.get('donationid'), "ongoing");
              },
              child: Text(
                "           ACCEPT DONATION >>>>",
                style: GoogleFonts.bebasNeue(
                    textStyle: TextStyle(color: Colors.white), fontSize: 30),
                textAlign: TextAlign.center,
              )),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}

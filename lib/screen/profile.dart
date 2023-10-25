// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/authentication/authenticate.dart';
import 'package:thriftstore/innerscreen/loadingpage.dart';
import 'package:thriftstore/innerscreen/somethingwentwrong.dart';
import 'package:thriftstore/screen/myproducts.dart';
import 'package:thriftstore/screen/productpage.dart';
import 'package:thriftstore/widgets.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
        ),
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: mainColor,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(height: 100),
              Text(
                "PROFILE",
                style:
                    GoogleFonts.blackHanSans(fontSize: 40, color: Colors.white),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 250),
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('user')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData == true) {
                  DocumentSnapshot doc = snapshot.data!;
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(40)),
                    ),
                    padding: EdgeInsets.only(left: 20, top: 30, right: 20),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        ListTile(
                          title: Text("Name"),
                          subtitle: Text(
                            doc.get('name'),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          title: Text("Email"),
                          subtitle: Text(
                            doc.get('email'),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          title: Text("Phone"),
                          subtitle: Text(
                            doc.get('phone'),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => MyProducts())),
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text("View My products"),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () => signout(),
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text("Logout"),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ]),
                    ),
                  );
                } else if (snapshot.hasError == true) {
                  return Somethingwentwrong();
                } else {
                  return Loadingpage();
                }
              },
            ),
          ),
        ]));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:thriftstore/innerscreen/loadingpage.dart';
import 'package:thriftstore/innerscreen/somethingwentwrong.dart';
import 'package:thriftstore/screen/productpage.dart';
import 'package:thriftstore/widgets.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({
    super.key,
  });

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text("My products"),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('products')
              .where('userid', isEqualTo: uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Somethingwentwrong();
            } else if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                    crossAxisCount: 2),
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(10),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: mainColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                              height: 120,
                              image: NetworkImage(
                                  snapshot.data?.docs[index].get('url')))),
                      Text(
                        snapshot.data?.docs[index].get('name'),
                        style: GoogleFonts.lato(fontSize: 17),
                      ),
                      Text(
                        "Price :${snapshot.data?.docs[index].get('price')} Rs",
                        style: GoogleFonts.lato(fontSize: 17),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('products')
                                .doc(snapshot.data?.docs[index].id)
                                .delete();
                            setState(() {});
                          },
                          child: const Text("Remove"))
                    ],
                  ),
                ),
              );
            } else {
              return const Loadingpage();
            }
          }),
    );
  }
}

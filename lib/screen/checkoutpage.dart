import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/screen/paymetsscreen.dart';
import 'package:thriftstore/widgets.dart';

import '../add/add_data.dart';
import 'ordersucces.dart';

class Checkoutpage extends StatelessWidget {
  final List<String> urls;

  final String uid;

  final int totalamount;

  final List<String> sizes;

  final List<String> itemids;
  final List<Map<String, dynamic>> priceandcount;
  final List<String> mainids;

  const Checkoutpage({
    Key? key,
    required this.itemids,
    required this.sizes,
    required this.totalamount,
    required this.urls,
    required this.uid,
    required this.priceandcount,
    required this.mainids,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    DocumentSnapshot<Map<String, dynamic>> _data =
                        await FirebaseFirestore.instance
                            .collection('user')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get();
                    if (_data.get('address') == "" || _data.get('name') == "") {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    "Please add both name and Address"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("ok"))
                                ],
                              ));
                    } else {
                      Map<String, dynamic> flag = await addorder(
                          uid,
                          itemids,
                          urls,
                          sizes,
                          totalamount,
                          mainids,
                          "cod",
                          priceandcount);

                      if (flag['status'] == 'success') {
                        for (var item in itemids) {
                          await FirebaseFirestore.instance
                              .collection('user')
                              .doc(uid)
                              .collection('cart')
                              .doc(item)
                              .delete();
                        }
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Ordersucces(
                                      totalamount: totalamount,
                                    )));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: Text(flag['status']),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("ok"))
                                  ],
                                ));
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Center(
                      child: Text(
                        "COD",
                        style: GoogleFonts.lato(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: mainColor)),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    DocumentSnapshot<Map<String, dynamic>> _data =
                        await FirebaseFirestore.instance
                            .collection('user')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get();
                    if (_data.get('address') == "" || _data.get('name') == "") {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    "Please add both name and Address"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("ok"))
                                ],
                              ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Payment(
                                    uid: uid,
                                    urls: urls,
                                    totalamount: totalamount,
                                    itemids: itemids,
                                    sizes: sizes,
                                    priceandcount: priceandcount,
                                    mainids: mainids,
                                  )));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: mainColor)),
                    child: Center(
                      child: Text(
                        "CREDIT/DEBIT Cards",
                        style: GoogleFonts.lato(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

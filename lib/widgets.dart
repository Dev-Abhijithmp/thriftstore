import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thriftstore/screen/checkoutpage.dart';

showdialogue(String title, String content, context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("ok"),
              ),
            ],
          ));
}

const Color mainColor = Color.fromRGBO(239, 149, 149, 1);
const Color admincolor = Color.fromRGBO(181, 201, 154, 1);

Widget checkoutbutton(double total, context, List<DocumentSnapshot> cartdata) {
  List<String> itemids = [];

  List<String> urls = [];
  List<Map<String, dynamic>> priceandcount = [];

  return InkWell(
    onTap: () {
      for (var i = 0; i < cartdata.length; i++) {
        urls.add(cartdata[i].get('url'));
        itemids.add(cartdata[i].get('id'));
        // mainid.add(cartdata[i].get('mainid'));
        priceandcount.add({
          'price': cartdata[i].get('total'),
          'count': cartdata[i].get('count'),
        });
      }
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Checkoutpage(
                  itemids: itemids,
                  totalamount: total.toInt(),
                  uid: FirebaseAuth.instance.currentUser!.uid,
                  urls: urls,
                  priceandcount: priceandcount,
                )),
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 200,
      height: 40,
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text("CHECKOUT(₹$total)",
            style: const TextStyle(color: Colors.white)),
      ),
    ),
  );
}

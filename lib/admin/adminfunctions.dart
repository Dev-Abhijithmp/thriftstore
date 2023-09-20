import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

AlertDialog alertadmin(String title, String content, context) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.blue)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("ok"))
    ],
  );
}

Future<Map<String, String?>> removeproduct(String uid) async {
  try {
    await FirebaseFirestore.instance.collection('products').doc(uid).delete();
    return {"status": "success"};
  } on FirebaseException catch (e) {
    return {"status": e.message};
  }
}

Future<Map<String, String?>> verifyproduct(String uid) async {
  try {
    await FirebaseFirestore.instance.collection('products').doc(uid).update({
      'isverified': true,
    });
    return {"status": "success"};
  } on FirebaseException catch (e) {
    return {"status": e.message};
  }
}

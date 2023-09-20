import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thriftstore/admin/adminfunctions.dart';
import 'package:thriftstore/innerscreen/loadingpage.dart';
import 'package:thriftstore/innerscreen/somethingwentwrong.dart';
import 'package:thriftstore/widgets.dart';

class ViewProducts extends StatelessWidget {
  const ViewProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Products"),
        backgroundColor: admincolor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError == true) {
            return const Somethingwentwrong();
          } else if (snapshot.hasData) {
            List<DocumentSnapshot> data = snapshot.data!.docs;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return singleProduct(data[index], context);
              },
              itemCount: data.length,
            );
          } else {
            return const Loadingpage();
          }
        },
      ),
    );
  }
}

Widget singleProduct(DocumentSnapshot doc, context) {
  return Container(
    width: double.infinity,
    height: 500,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
        border: Border.all(color: admincolor)),
    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    child: Column(
      children: [
        SizedBox(
          height: 200,
          width: 300,
          child: Image(image: NetworkImage(doc.get('url'))),
        ),
        staffitems("Product Name", doc.get('name')),
        staffitems("price", doc.get('price')),
        staffitems("Verifiedornot", doc.get('isverified').toString()),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                removeproduct(doc.id);
              },
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: admincolor),
                child: const Center(
                  child: Text("Remove"),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                verifyproduct(doc.id);
              },
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: admincolor),
                child: const Center(
                  child: Text("verify"),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget staffitems(String field, String data) {
  return SizedBox(
    width: double.infinity,
    height: 65,
    child: Card(
      child: ListTile(
        title: Text(
          field,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          data,
          style: const TextStyle(),
        ),
      ),
    ),
  );
}

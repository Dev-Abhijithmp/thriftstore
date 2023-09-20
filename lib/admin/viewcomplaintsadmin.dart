import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thriftstore/admin/adminfunctions.dart';
import 'package:thriftstore/innerscreen/somethingwentwrong.dart';
import 'package:thriftstore/widgets.dart';

class ViewcomplaintAdmin extends StatelessWidget {
  const ViewcomplaintAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(""),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError == true) {
            return const Somethingwentwrong();
          } else if (snapshot.connectionState == ConnectionState.active) {
            List<DocumentSnapshot> data = snapshot.data!.docs;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return singlecomplaintitem(data[index], context);
              },
              itemCount: data.length,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Widget singlecomplaintitem(DocumentSnapshot doc, context) {
  List<dynamic> wastetypes = doc.get('wastetypes');
  return Container(
    height: 250,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(30)),
        border: Border.all(color: admincolor)),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Id :  ${doc.get('complaintid')}"),
        ),
        Row(
          children: [
            Container(
              height: 160,
              width: 120,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: admincolor),
                  image:
                      DecorationImage(image: NetworkImage(doc.get('image')))),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Status :  ${doc.get('status')}"),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  " waste types",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80,
                  width: 100,
                  child: ListView.builder(
                    itemCount: wastetypes.length,
                    itemBuilder: (BuildContext context, int index1) {
                      return Text(wastetypes[index1].toString());
                    },
                  ),
                ),
              ),
              //   doc.get('status') == 'placed'
              //       ? InkWell(
              //           onTap: () async {
              //             Map<String, String> flag =
              //                 await removecomplaint(doc.get('productid'));
              //             if (flag['status'] != "success") {
              //               showDialog(
              //                   context: context,
              //                   builder: (BuildContext context) =>
              //                       alertadmin("Error", flag['status']!, context));
              //             }
              //           },
              //           child: Container(
              //             height: 30,
              //             width: 60,
              //             color: admincolor,
              //             child: const Center(
              //               child: Text(
              //                 "remove",
              //                 style: TextStyle(color: Colors.white),
              //               ),
              //             ),
              //           ),
              //         )
              //       : Container(),
              // ],
            ]),
          ],
        ),
      ],
    ),
  );
}

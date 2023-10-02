import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/add/add_data.dart';
import 'package:thriftstore/innerscreen/loadingpage.dart';
import 'package:thriftstore/innerscreen/somethingwentwrong.dart';
import 'package:thriftstore/widgets.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({
    Key? key,
  }) : super(key: key);

  @override
  CartscreenState createState() => CartscreenState();
}

class CartscreenState extends State<Cartscreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text("Cart"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('cart')
                    .snapshots(includeMetadataChanges: false),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError == true) {
                    return const Somethingwentwrong();
                  }
                  if (snapshot.hasData == true) {
                    List<DocumentSnapshot> cartdata = snapshot.data!.docs;
                    if (cartdata.isEmpty) {
                      return Container();
                      //return Emptycart(title: 'cart');
                    } else {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 230 * (cartdata.length).toDouble(),
                              width: double.infinity,
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, index) {
                                  return singlecartitem(
                                    context,
                                    cartdata[index].get('url'),
                                    cartdata[index].get('title'),
                                    cartdata[index].get('price').toDouble(),
                                    cartdata[index].get('id'),
                                    cartdata[index].get('count'),
                                    cartdata[index].get('type'),
                                  );
                                },
                                itemCount: cartdata.length,
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('cart')
                                    .snapshots(includeMetadataChanges: true),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  double total = 0.0;
                                  if (snapshot.hasData == true) {
                                    List<DocumentSnapshot> totaldata =
                                        snapshot.data!.docs;

                                    for (var item in totaldata) {
                                      total = total + item.get('total');
                                    }

                                    return checkoutbutton(
                                        total, context, cartdata);
                                  }
                                  return Container();
                                })
                          ],
                        ),
                      );
                    }
                  } else {
                    return const Loadingpage();
                  }
                }),
          ),
          // sizedh(50)
        ],
      ),
    );
  }
}

Widget singlecartitem(context, String url, String title, double price,
    String cartid, int count, String type) {
  return SizedBox(
    width: MediaQuery.of(context).size.height * 0.9,
    child: Container(
      height: 150,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: mainColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 80,
                child: Image.network(
                  url,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title.toUpperCase(),
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: mainColor)),
                  // Text(
                  //   description,
                  //   style: GoogleFonts.lato(fontSize: 12, color: mainColor),
                  // ),
                  // sizedh(5),
                  Text("₹$price",
                      style: GoogleFonts.lato(fontSize: 15, color: mainColor)),
                  //  sizedh(5),
                  // Text(size,
                  //     style: GoogleFonts.lato(fontSize: 15, color: mainColor)),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          subtractcount(
                            FirebaseAuth.instance.currentUser!.uid,
                            cartid,
                            price,
                          );
                        },
                        child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                                border: Border.all(color: mainColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 2),
                                child: Transform.rotate(
                                  angle: -33,
                                  child: const Text(
                                    "|",
                                    style: TextStyle(
                                        color: mainColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: Center(child: cartcount(cartid)),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          addtocart(
                              context,
                              FirebaseAuth.instance.currentUser!.uid,
                              cartid,
                              url,
                              price,
                              title,
                              type);
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                              border: Border.all(color: mainColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.add,
                            color: mainColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      InkWell(
                        onTap: () {
                          removefromcart(
                              FirebaseAuth.instance.currentUser!.uid, cartid);
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: mainColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.delete,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget cartcount(String id) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(id)
          .snapshots(includeMetadataChanges: true),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          DocumentSnapshot<Map<String, dynamic>> data = snapshot.data;

          if (data.exists == true) {
            return Text(
              '${data.get('count')}',
              style: GoogleFonts.lato(fontSize: 15, color: mainColor),
            );
          } else {
            return Text('');
          }
        }

        return Text('');
      });
}

Widget totalcartcount() {
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .snapshots(includeMetadataChanges: true),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          List<DocumentSnapshot> data = snapshot.data!.docs;
          if (data.isNotEmpty) {
            double total = 0;
            for (var item in data) {
              total = total + item.get('count');
            }
            return Text(
              "${total.round()}",
              style: GoogleFonts.lato(
                  fontSize: 17, color: mainColor, fontWeight: FontWeight.bold),
            );
          } else {
            return Text("");
          }
        }

        return Text("");
      });
}

Future<Map<String, String?>> addnametodatabase(String uid, String name) async {
  try {
    await FirebaseFirestore.instance.collection('user').doc(uid).update({
      'name': name,
    });
    return {'status': "success"};
  } on FirebaseException catch (e) {
    return {'status': e.message};
  }
}

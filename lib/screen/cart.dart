import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/innerscreen/loadingpage.dart';
import 'package:thriftstore/innerscreen/somethingwentwrong.dart';
import 'package:thriftstore/widgets.dart';

class Cartscreen extends StatefulWidget {
  Cartscreen({
    Key? key,
  }) : super(key: key);

  @override
  _CartscreenState createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
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
                    return Somethingwentwrong();
                  }
                  if (snapshot.hasData == true) {
                    List<DocumentSnapshot> cartdata = snapshot.data!.docs;
                    if (cartdata.length == 0) {
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
                                padding: EdgeInsets.symmetric(vertical: 5),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, index) {
                                  return singlecartitem(
                                      context,
                                      cartdata[index].get('url'),
                                      cartdata[index].get('title'),
                                      cartdata[index].get('price').toDouble(),
                                      cartdata[index].get('description'),
                                      cartdata[index].get('size'),
                                      cartdata[index].get('id'),
                                      cartdata[index].get('count'),
                                      cartdata[index].get('mainid'));
                                },
                                itemCount: cartdata.length,
                              ),
                            ),
                            // StreamBuilder<QuerySnapshot>(
                            //     stream: FirebaseFirestore.instance
                            //         .collection('user')
                            //         .doc(FirebaseAuth
                            //             .instance.currentUser!.uid)
                            //         .collection('cart')
                            //         .snapshots(includeMetadataChanges: true),
                            //     builder: (context,
                            //         AsyncSnapshot<QuerySnapshot> snapshot) {
                            //       double total = 0.0;
                            //       if (snapshot.hasData == true) {
                            //         List<DocumentSnapshot> totaldata =
                            //             snapshot.data!.docs;

                            //         for (var item in totaldata) {
                            //           total = total + item.get('total');
                            //         }

                            //         return checkoutbutton(
                            //             total, context, cartdata);
                            //       }
                            //       return Container();
                            //     })
                          ],
                        ),
                      );
                    }
                  } else {
                    return Loadingpage();
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
    String description, String size, String cartid, int count, String mainid) {
  return SizedBox(
    width: MediaQuery.of(context).size.height * 0.9,
    child: Container(
      height: 150,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: mainColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 100,
                height: 80,
                child: Image.network(
                  url,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
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
                  Text(
                    description,
                    style: GoogleFonts.lato(fontSize: 12, color: mainColor),
                  ),
                  // sizedh(5),
                  Text("₹" + price.toString(),
                      style: GoogleFonts.lato(fontSize: 15, color: mainColor)),
                  //  sizedh(5),
                  Text(size,
                      style: GoogleFonts.lato(fontSize: 15, color: mainColor)),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // subtractcount(FirebaseAuth.instance.currentUser!.uid,
                          //     cartid, price, size);
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
                                  child: Text(
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
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 28,
                        height: 28,
                        //child: Center(child: cartcount(cartid)),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          // addtocart(
                          //     context,
                          //     FirebaseAuth.instance.currentUser!.uid,
                          //     cartid,
                          //     url,
                          //     price,
                          //     description,
                          //     title,
                          //     size,
                          //     mainid);
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                              border: Border.all(color: mainColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.add,
                            color: mainColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      InkWell(
                        onTap: () {
                          // removefromcart(
                          //     FirebaseAuth.instance.currentUser!.uid, cartid);
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: mainColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
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

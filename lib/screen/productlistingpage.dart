import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/home/productscreen.dart';
import 'package:thriftstore/innerscreen/loadingpage.dart';
import 'package:thriftstore/innerscreen/somethingwentwrong.dart';
import 'package:thriftstore/screen/productpage.dart';
import 'package:thriftstore/widgets.dart';

class Productlisting extends StatefulWidget {
  final String type;
  final String category;
  const Productlisting({super.key, required this.type, required this.category});

  @override
  State<Productlisting> createState() => _ProductlistingState();
}

class _ProductlistingState extends State<Productlisting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(widget.category),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('products')
              .where('type', isEqualTo: widget.type)
              .where('category', isEqualTo: widget.category)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Somethingwentwrong();
            } else if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9,
                    crossAxisCount: 2),
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProductPage(
                                data: snapshot.data?.docs[index],
                              ))),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: mainColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(8.0),
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
                      ],
                    ),
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

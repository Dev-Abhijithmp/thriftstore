import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/innerscreen/somethingwentwrong.dart';
import 'package:thriftstore/screen/productpage.dart';

import '../innerscreen/loadingpage.dart';
import '../widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

TextEditingController searchController = TextEditingController();
List<DocumentSnapshot>? searchList = [];

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text("Search"),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('products').get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Somethingwentwrong();
            } else if (snapshot.hasData) {
              List<DocumentSnapshot> data = snapshot.data!.docs;
              print(data.length);

              print(data.length);
              print(data[0].get('price').toString());
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            print("search values");

                            searchList = data
                                .where((element) => (element
                                    .get('name')
                                    .toLowerCase()
                                    .contains(
                                        searchController.text.toLowerCase())))
                                .toList();

                            // searchList = data
                            //     .where((element) => element
                            //         .get('name')
                            //         .toString()
                            //         .toLowerCase()
                            //         .contains(
                            //             searchController.text.toLowerCase()))
                            //     .toList();
                            setState(() {});
                          }),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.76,
                    child: searchList!.isEmpty
                        ? const Center(
                            child: Text("No product found"),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.7,
                                    crossAxisCount: 2),
                            itemCount: searchList!.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ProductPage(
                                            data: searchList![index]
                                                as QueryDocumentSnapshot<
                                                    Object?>?,
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image(
                                            height: 120,
                                            image: NetworkImage(
                                                searchList![index]
                                                    .get('url')))),
                                    Text(
                                      searchList![index].get('name'),
                                      style: GoogleFonts.lato(fontSize: 17),
                                    ),
                                    Text(
                                      "Price :${searchList![index].get('price')} Rs",
                                      style: GoogleFonts.lato(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  )
                ],
              );
            } else {
              return const Loadingpage();
            }
          }),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_tv/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/sellorrent/sellorrent.dart';
import 'package:thriftstore/widgets.dart';

class ProductHome extends StatelessWidget {
  const ProductHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const SellorRent())),
        backgroundColor: mainColor,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Triftstore",
          style: GoogleFonts.lato(color: Colors.black),
        ),
        backgroundColor: mainColor,
      ),
      body: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    List<String> img = [
      'images/duke390.jpeg',
      'images/g310.jpeg',
      'images/himalayan.jpeg',
      'images/ninja.jpeg'
    ];
    List<Map<String, dynamic>> data = [
      {
        'title': "Jackets",
        'url':
            "https://5.imimg.com/data5/TR/XS/MY-3513908/htb1zf4egfxxxxxxxpxxq6xxfxxxq-1000x1000.jpg"
      },
      {
        'title': "Helmets",
        'url':
            "https://images.unsplash.com/photo-1603799091901-f0034ac3e7fa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
      },
      {
        'title': "Gloves",
        'url':
            "https://images-eu.ssl-images-amazon.com/images/I/51H8sdJdXBL._SX300_SY300_QL70_FMwebp_.jpg"
      },
      {
        'title': "Boots",
        'url': "https://m.media-amazon.com/images/I/812HUl6A1YL._SL1500_.jpg"
      },
      {
        'title': "Parts",
        'url':
            "https://i0.wp.com/vfxdownload.com/wp-content/uploads/2019/12/1920x1080.jpg?w=590&ssl=1"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  child: Swiper(
                    fade: 1,
                    autoplay: true,
                    itemCount: img.length,
                    controller: SwiperController(),
                    pagination: const SwiperPagination(
                      builder: SwiperPagination.dots,
                      alignment: Alignment.bottomCenter,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Image.asset(
                          img[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Categories",
                      style: GoogleFonts.lato(color: Colors.blue, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _categories(context, data),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _appbar(context) {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  return Container(
    width: double.infinity,
    height: 120,
    decoration: const BoxDecoration(
      color: mainColor,
      boxShadow: [
        BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: Colors.black54,
            offset: Offset(0, 1))
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Text(
              "Partsbay",
              style: GoogleFonts.oxygen(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer()
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              // onTap: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (BuildContext context) {
              //     return Searchpage();
              //   }));
              // },
              child: Container(
                padding: const EdgeInsets.all(5),
                height: 40,
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    Expanded(
                        child: Text("Search spares,helmets,gears here..",
                            style: GoogleFonts.lato(
                              color: mainColor,
                            ))),
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return Wishlistpage(uid: uid);
                  // }));
                },
                icon: Icon(
                  Icons.heart_broken,
                  size: 20,
                  color: Colors.black,
                )),
          ],
        )
      ],
    ),
  );
}

Widget _categories(context, List<Map<String, dynamic>> data) {
  return SizedBox(
    width: double.infinity,
    height: 300,
    child: GridView.custom(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.8),
      childrenDelegate:
          SliverChildBuilderDelegate((BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return Catadata(
            //     docdata: data[index]['title'].toString().toLowerCase(),
            //   );
            // }));
          },
          child: Container(
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: mainColor)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 100,
                  child: Image.network(
                    data[index]['url'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  data[index]['title'].toString(),
                  style: GoogleFonts.lato(color: mainColor, fontSize: 20),
                )
              ],
            ),
          ),
        );
      }, childCount: 5),
    ),
  );
}

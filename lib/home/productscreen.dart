import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_tv/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/screen/cart.dart';
import 'package:thriftstore/screen/productlistingpage.dart';
import 'package:thriftstore/sellorrent/sellorrent.dart';
import 'package:thriftstore/widgets.dart';

List<String> img = [
  'images/1.jpeg',
  'images/2.jpeg',
  'images/3.jpeg',
];
List<Map<String, dynamic>> data = [
  {
    'title': "chain",
    'url':
        "https://img.freepik.com/free-photo/display-shiny-elegant-gold-chain_23-2149635331.jpg?w=826&t=st=1695230574~exp=1695231174~hmac=e0ac22f0322e16d93a4f908dd97b4c7412e7b25d8a70bd75f118fe210c5fc437"
  },
  {
    'title': "ring",
    'url':
        "https://as2.ftcdn.net/v2/jpg/00/71/67/87/1000_F_71678766_kPinbw5YXRSJrlwwT8SmA90TgjBu64Ng.jpg"
  },
  {
    'title': "bangles",
    'url':
        "https://cdnmedia-breeze.vaibhavjewellers.com/media/webp_image/catalog/product/cache/40285937a65a1c81bb16d6469aab5e06/image/91825df0/vaibhav-jewellers-22k-antique-gold-bangles-125vg1210-125vg1210.webp"
  },
  {
    'title': "gowns",
    'url':
        "https://images.pexels.com/photos/1635664/pexels-photo-1635664.jpeg?cs=srgb&dl=pexels-li-jianhua-1635664.jpg&fm=jpg"
  },
  {
    'title': "kurthas",
    'url':
        "https://assets.myntassets.com/dpr_1.5,q_60,w_400,c_limit,fl_progressive/assets/images/19494072/2022/8/24/fbd5a6dd-2f67-48fc-9341-72f91acca09b1661330892106-Kurta-Pyjama-Set-2971661330890568-1.jpg"
  },
];

class ProductHome extends StatelessWidget {
  const ProductHome({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
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
          "Thriftstore",
          style: GoogleFonts.abhayaLibre(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Cartscreen())),
              icon: const Icon(Icons.shopping_cart))
        ],
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                  style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: mainColor),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      width: 200,
                      height: 30,
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        //dividerColor: lightPrimary1,
                        dividerColor: mainColor,
                        tabs: const [
                          Tab(
                            text: "Rent",
                          ),
                          Tab(
                            text: "Sale",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 700,
                      child: TabBarView(
                        clipBehavior: Clip.none,
                        children: [
                          _categories(context, data, 'rent'),
                          _categories(context, data, 'sale'),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
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
              "thrifstore",
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

Widget _categories(context, List<Map<String, dynamic>> data, String type) {
  return SizedBox(
    width: double.infinity,
    height: 700,
    child: GridView.custom(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.8),
      childrenDelegate:
          SliverChildBuilderDelegate((BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Productlisting(type: type, category: data[index]['title']);
            }));
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

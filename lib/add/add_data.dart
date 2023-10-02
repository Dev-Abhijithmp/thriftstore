import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

CollectionReference user = FirebaseFirestore.instance.collection('user');

Future<void> createuserprofile(
  String uid,
  String email,
  String name,
  String phone,
) async {
  DocumentReference documentReference = user.doc(uid);

  documentReference.set({
    'id': uid,
    'name': name,
    'email': email,
    'phone': phone,
    'images': 0,
    'address': '',
    'orders': 0,
    'role': 'user'
  });
}

Future<void> addtocart(context, String uid, String cartid, String url,
    double price, String title, String type) async {
  DocumentReference documentReference = user.doc(uid);
  QuerySnapshot<Map<String, dynamic>>? coldata =
      await documentReference.collection('cart').get();
  DocumentSnapshot<Map<String, dynamic>>? countdata;

  if (coldata.docs.isEmpty) {
    await documentReference.collection('cart').doc(cartid).set({
      'type': type,
      'id': cartid,
      'count': 1,
      'title': title,
      'url': url,
      'price': price,
      'total': price
    });
  } else {
    countdata = await documentReference.collection('cart').doc(cartid).get();
    if (countdata.exists) {
      await documentReference
          .collection('cart')
          .doc(cartid)
          .update({'count': (countdata!.get('count') + 1)});
      await documentReference
          .collection('cart')
          .doc(cartid)
          .update({'total': ((countdata.get('count') + 1) * price)});
    } else {
      await documentReference.collection('cart').doc(cartid).set({
        'type': type,
        'id': cartid,
        'count': 1,
        'title': title,
        'url': url,
        'price': price,
        'total': price
      });
    }
  }
}

Future<Map<String, dynamic>> removeorder(
  String orderid,
  List<String> mainids,
  List<String> sizes,
  List<String> itemids,
  List<Map<String, dynamic>> priceandcount,
) async {
  DocumentSnapshot<Map<String, dynamic>> userdata = await FirebaseFirestore
      .instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  try {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('orders')
        .doc(orderid)
        .delete();
    await FirebaseFirestore.instance.collection('orders').doc(orderid).delete();
    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'orders': (userdata.get('orders') + 1),
    });
    for (var i = 0; i < itemids.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> temp = await FirebaseFirestore
          .instance
          .collection('products')
          .doc(mainids[i])
          .collection('sizes&count')
          .doc(sizes[i])
          .get();

      await FirebaseFirestore.instance
          .collection('products')
          .doc(mainids[i])
          .collection('sizes&count')
          .doc(sizes[i])
          .update({
        'size': sizes[i],
        'sizecount': (temp.get('sizecount') + priceandcount[i]['count']),
      });
    }
    return {'status': 'success'};
  } on FirebaseException catch (e) {
    return {'status': e.message};
  }
}

// Future<void> addtowishlist(
//     context,
//     String uid,
//     String whishid,
//     String url,
//     double price,
//     String description,
//     String title,
//     String size,
//     String mainid) async {
//   DocumentReference documentReference = user.doc(uid);
//   DocumentSnapshot<Map<String, dynamic>>? countdata =
//       await documentReference.collection('wishlist').doc(whishid).get();

//   if (countdata.exists == false) {
//     await documentReference.collection('wishlist').doc(whishid).set({
//       'mainid': mainid,
//       'id': whishid,
//       'title': title,
//       'description': description,
//       'url': url,
//       'price': price,
//       'size': size
//     });
//   } else {
//     await documentReference
//         .collection('cart')
//         .doc(whishid)
//         .update({'count': (countdata.get('count') + 1)});
//   }
// }

Future<void> subtractcount(String uid, String cartid, double price) async {
  DocumentReference documentReference = user.doc(uid);
  DocumentSnapshot<Map<String, dynamic>>? countdata =
      await documentReference.collection('cart').doc(cartid).get();
  if (countdata['count'] > 1) {
    await documentReference
        .collection('cart')
        .doc(cartid)
        .update({'count': (countdata.get('count') - 1)});
    await documentReference
        .collection('cart')
        .doc(cartid)
        .update({'total': ((countdata.get('count') - 1) * price)});
  } else {
    removefromcart(uid, cartid);
  }
}

Future<void> removefromcart(String uid, String id) async {
  DocumentReference documentReference = user.doc(uid);
  await documentReference.collection('cart').doc(id).delete();
}

Future<void> removefromwishlist(String uid, String whishid) async {
  DocumentReference documentReference = user.doc(uid);
  documentReference.collection('wishlist').doc(whishid).delete();
}

//Provider.of<Change>(context).cartcount

Future<Map<String, dynamic>> addorder(
  String uid,
  List<String> itemids,
  List<String> urls,
  int totalamount,
  // List<String> mainids,
  String mode,
  List<Map<String, dynamic>> priceandcount,
) async {
  DocumentSnapshot<Map<String, dynamic>> userdata =
      await FirebaseFirestore.instance.collection('user').doc(uid).get();
  for (var i = 0; i < itemids.length; i++) {
    DocumentSnapshot<Map<String, dynamic>> temp = await FirebaseFirestore
        .instance
        .collection('products')
        .doc(itemids[i])
        .get();

    // await FirebaseFirestore.instance
    //     .collection('products')
    //     .doc(itemids[i])
    //     .update({
    //   'sizecount': (temp.get('sizecount') - priceandcount[i]['count']),
    // });
  }

  try {
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('orders')
        .doc(uid + (userdata.get('orders') + 1).toString())
        .set({
      'itemids': itemids,
      'uid': uid,
      'urls': urls,
      // 'sizes': sizes,
      'price&count': priceandcount,
      'totalamount': totalamount,
      'mode': mode,
      'status': 'placed',
      'date': DateTime.now()
    });
    FirebaseFirestore.instance.collection('user').doc(uid).update({
      'orders': (userdata.get('orders') + 1),
    });
    FirebaseFirestore.instance
        .collection('orders')
        .doc(uid + (userdata.get('orders') + 1).toString())
        .set({
      'itemids': itemids,
      'uid': uid,
      'urls': urls,
      // 'sizes': sizes,
      'price&count': priceandcount,
      'totalamount': totalamount,
      'mod': mode,
      'status': 'placed',
      'date': DateTime.now()
    });
    return {'status': 'success'};
  } on FirebaseException catch (e) {
    return {'status': e.message};
  }
}

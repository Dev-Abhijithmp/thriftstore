import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, String>> addproduct({
  required String type,
  required String url,
  required String name,
  required String price,
  required String address,
  required String category,
  required String phone,
}
    //Position position,
    ) async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    await FirebaseFirestore.instance
        .collection('products')
        .doc(FirebaseAuth.instance.currentUser!.uid +
            (documentSnapshot.get('images') + 1).toString())
        .set({
      'uid': FirebaseAuth.instance.currentUser!.uid +
          (documentSnapshot.get('images') + 1).toString(),
      'userid': FirebaseAuth.instance.currentUser!.uid,
      'address': address,
      'category': category,
      'type': type,
      'name': name,
      'price': price,
      'url': url,
      'phone': phone,
      'date': DateTime.now(),
      'isverified': false,
      // 'location': {
      //   'latitude': position.latitude,
      //   'longitude': position.longitude,
      // },
    });

    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'images': (documentSnapshot.get('images') + 1)});
    return {'status': "success"};
  } on FirebaseException catch (e) {
    return {'status': e.message.toString()};
  }
}

FirebaseStorage firebaseStorage = FirebaseStorage.instance;
Future<Map<String, String>> addimagetostorage(File images) async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    int count = int.parse(documentSnapshot.get('images').toString());

    await FirebaseStorage.instance
        .ref(
            'requestimages/${FirebaseAuth.instance.currentUser!.uid}${count + 1}')
        .putFile(images);
    String sample = await FirebaseStorage.instance
        .ref(
            'requestimages/${FirebaseAuth.instance.currentUser!.uid}${count + 1}')
        .getDownloadURL();

    return {'status': "success", 'url': sample.toString()};
  } on FirebaseException catch (e) {
    return {'status': e.message.toString()};
  }
}

Future<Map<String, String>> removedonation(String ddonationid) async {
  try {
    await FirebaseFirestore.instance
        .collection('donations')
        .doc(ddonationid)
        .delete();

    return {'status': "success"};
  } on FirebaseException catch (e) {
    return {'status': e.message.toString()};
  }
}

Future<Map<String, String?>> changephone(String uid, String phone) async {
  try {
    await FirebaseFirestore.instance.collection('user').doc(uid).update({
      'phone': phone,
    });
    return {'status': "success"};
  } on FirebaseException catch (e) {
    return {'status': e.message.toString()};
  }
}

Future<Map<String, String?>> updatestatus(
    String donationid, String status) async {
  try {
    await FirebaseFirestore.instance
        .collection('donations')
        .doc(donationid)
        .update({
      'status': status,
    });
    return {'status': "success"};
  } on FirebaseException catch (e) {
    return {'status': e.message.toString()};
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
}

void changestatus(String donid, String status) async {
  await FirebaseFirestore.instance
      .collection('donations')
      .doc(donid)
      .update({'status': status});
}

void changestatusaccept(String donid, String status) async {
  await FirebaseFirestore.instance
      .collection('accept')
      .doc(donid)
      .update({'status': status});
}

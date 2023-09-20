import 'package:cloud_firestore/cloud_firestore.dart';

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
    'donations': 0,
    'phone': phone,
  });
}

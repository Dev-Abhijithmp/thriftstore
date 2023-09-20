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
    'phone': phone,
    'images': 0,
    'role': 'user'
  });
}

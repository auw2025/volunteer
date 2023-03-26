import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addcommunity(String contact,String description,String location,String logo,String mission,String website,String name)
async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  await _firestore
      .collection('community')
      .doc(name)
      .set({
    "contact" : contact,
    "description" : description,
    "location" : location,
    "logo" : logo,
    "mission" : mission,
    "name" : name,
    "website" : website,

  });
}

Future<void> addvolunteer(String contact,String description,String location,String logo,String mission,String website,String name,String date)
async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  await _firestore
      .collection('volunteer')
      .doc(name)
      .set({
    "contact" : contact,
    "description" : description,
    "location" : location,
    "logo" : logo,
    "mission" : mission,
    "name" : name,
    "website" : website,
    "date" : date,

  });
}
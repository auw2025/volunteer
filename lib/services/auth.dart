import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> doesUserExist() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('Users')
      .where("Email", isEqualTo: FirebaseAuth.instance.currentUser!.email!)
      .get();
  return snapshot.docs.isNotEmpty;
}

Future<void> startcollection () async
{
  bool condition = await doesUserExist();
  if (condition == false) {
    FirebaseFirestore.instance.collection("Users").doc(
        FirebaseAuth.instance.currentUser!.uid).set({
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'Email': FirebaseAuth.instance.currentUser!.email,
      'Groups': FieldValue.arrayUnion([]),
      'Volunteer': FieldValue.arrayUnion([]),

    });
  }
}

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {



      startcollection();
    });
    notifyListeners();
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}


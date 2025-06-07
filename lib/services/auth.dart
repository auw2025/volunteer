import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Checks whether the currently authenticated user exists in your Firestore Users collection.
Future<bool> doesUserExist() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('Users')
      .where(
        "Email",
        isEqualTo: FirebaseAuth.instance.currentUser!.email!,
      )
      .get();
  return snapshot.docs.isNotEmpty;
}

/// Creates a document in the Firestore Users collection for new users.
Future<void> startcollection() async {
  bool condition = await doesUserExist();
  if (condition == false) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'Email': FirebaseAuth.instance.currentUser!.email,
      'Groups': FieldValue.arrayUnion([]),
      'Volunteer': FieldValue.arrayUnion([]),
    });
  }
}

/// A provider which handles Google Sign-In and domain-based access.
class GoogleSignInProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  // Allowed domain for authentication (change this to your custom domain).
  final String allowedDomain = "tsss.edu.hk";

  /// Performs Google login and checks the user's email domain.
  Future googleLogin(BuildContext context) async {
    // Trigger the Google Sign-In flow.
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    // Authenticate with Google.
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in with Firebase.
    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final userEmail = authResult.user?.email?.toLowerCase();

    // Check that the email ends with the allowed domain.
    if (userEmail != null && userEmail.endsWith(allowedDomain)) {
      // Email is allowed; proceed to create collection if not exists.
      await startcollection();
      // Navigate to home screen.
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Email is not allowed; sign the user out and show a custom message.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Sorry, only the email address of Tak Sun Secondary School is supported.",
          ),
        ),
      );
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
    }

    notifyListeners();
  }

  /// Logs out the current user.
  Future logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
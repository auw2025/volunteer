// volunteerscreen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

// Adjust these imports to match your own paths:
import 'package:hapii/services/const.dart';
import 'package:hapii/services/extras.dart';

class volunteerScreen extends StatefulWidget {
  final ImageProvider image;
  final ImageProvider banner;
  final String name;       // e.g. "Laboratory cleanup service"
  final String location;
  final String contact;
  final String description;
  final String donationUrl;
  final String websiteUrl;
  final String date;

  const volunteerScreen({
    super.key,
    required this.image,
    required this.banner,
    required this.name,
    required this.location,
    required this.contact,
    required this.description,
    required this.donationUrl,
    required this.websiteUrl,
    required this.date,
  });

  @override
  State<volunteerScreen> createState() => _volunteerScreenState();
}

class _volunteerScreenState extends State<volunteerScreen> {
  /// Tracks if the user can still apply. `true` means show "Apply Now".
  /// `false` means user has already applied, so show "Applied".
  bool apply = true;

  @override
  void initState() {
    super.initState();
    _checkIfUserAlreadyApplied();
  }

  /// Checks Firestore to see if the current volunteer’s [widget.name] is
  /// already in the user’s `volunteer` array. If yes, sets [apply] to false.
  Future<void> _checkIfUserAlreadyApplied() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.uid)
        .get();

    if (!userDoc.exists) return;
    final userData = userDoc.data() as Map<String, dynamic>;
    final userVolunteers = userData['volunteer'] as List<dynamic>? ?? [];

    // If volunteer array already contains this volunteer's name
    if (userVolunteers.contains(widget.name)) {
      setState(() {
        apply = false;
      });
    }
  }

  /// Called when the user taps “Apply Now.” Updates the Firestore user doc’s
  /// volunteer array and the volunteer doc’s `appliedvolunteer` sub-collection.
  void _applyNow() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    // Update Firestore - add this volunteer name to the user’s volunteer array
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.uid)
        .update({
      'volunteer': FieldValue.arrayUnion([widget.name])
    });

    // Also store user info in the volunteer doc => 'appliedvolunteer' sub-collection
    await FirebaseFirestore.instance
        .collection("volunteer")
        .doc(widget.name) // or doc ID if you store it that way
        .collection('appliedvolunteer')
        .doc(currentUser.email)
        .set({
      'name': currentUser.displayName,
      'photo': currentUser.photoURL,
      'gmail': currentUser.email,
    });

    // Locally update to show that user has applied
    setState(() {
      apply = false;
    });

    // Confirmation toast
    Fluttertoast.showToast(
      msg: "Successfully applied",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryBG,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Top banner area with the volunteer’s banner image + logo + contact info
          SizedBox(
            height: size.height * 0.35,
            width: size.width,
            child: Stack(
              children: [
                // Background banner
                Container(
                  height: size.height * 0.2,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: widget.banner,
                    ),
                  ),
                ),
                // Logo + Name + Location + Phone
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.15),
                      // Logo
                      Container(
                        height: size.height * 0.1,
                        width: size.height * 0.1,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: widget.image,
                          ),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                            width: 1,
                          ),
                          borderRadius:
                              BorderRadius.circular(size.height * 0.05),
                        ),
                      ),
                      // Name
                      Text(
                        widget.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      // Location & Contact
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 22,
                                color: Colors.black,
                              ),
                              Text(
                                widget.location,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              LaunchUrl("tel:${widget.contact}");
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    widget.contact,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Description
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.grey),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Text(
              widget.description,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),

          // Donate / Website row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Donate
                GestureDetector(
                  onTap: () {
                    LaunchUrl(widget.donationUrl);
                  },
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: kAccentGreen,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF35591D),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Donate",
                        style: GoogleFonts.inter(
                          color: const Color(0xFF35591D),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),

                // Website
                GestureDetector(
                  onTap: () {
                    LaunchUrl(widget.websiteUrl);
                  },
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: kAccentYellow,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF53441D),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Website",
                        style: GoogleFonts.inter(
                          color: const Color(0xFF53441D),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // “Volunteer on [date]”
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Volunteer on ${widget.date}',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 8),

          // "Apply Now" / "Applied" button
          GestureDetector(
            onTap: apply ? _applyNow : null,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              height: 55,
              width: size.width,
              decoration: BoxDecoration(
                color: apply ? const Color(0xFFEDC7BF) : Colors.grey,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF59241D),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  apply ? "Apply Now" : "Applied",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF59241D),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),

          // Set Reminder button
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              setReminder('To Volunteer for ${widget.name} on ${widget.date}');
            },
            child: Container(
              height: 55,
              width: size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFBFD4ED),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF1D3259),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  "Set Reminder",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF1D3259),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),

          // Additional information in point form
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Why Volunteer?",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                const BulletItem(
                    text: "Learn new skills and enhance your resume."),
                const BulletItem(
                    text:
                        "Make meaningful connections in your community."),
                const BulletItem(
                    text:
                        "Support local causes and create lasting impact."),
                const BulletItem(
                    text:
                        "Enjoy a variety of flexible volunteering opportunities."),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

/// A simple widget for displaying a bullet point item.
class BulletItem extends StatelessWidget {
  final String text;
  const BulletItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: GoogleFonts.inter(fontSize: 20, color: Colors.black),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
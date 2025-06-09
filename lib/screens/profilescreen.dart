import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/main.dart';
import 'package:hapii/screens/orgcreatescreen.dart';
import 'package:hapii/screens/volunteercreatescreen.dart';
import 'package:hapii/services/const.dart';

import '../widgets/volunteerCard.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const NavScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    var size = MediaQuery.of(context).size;

    // Stream to get the user document from Firestore which now includes the "role" field.
    final userDocStream = FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseUser!.uid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: kPrimaryBlack,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: kPrimaryBG,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: userDocStream,
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!userSnapshot.hasData || userSnapshot.data == null) {
            return const Center(child: Text('Error loading user data'));
          }

          // Retrieve user data from Firestore including the role field.
          Map<String, dynamic>? userData = userSnapshot.data!.data();
          String userRole = userData?['role'] ?? 'student'; // default to student if not set

          return Center(
            child: Column(
              children: [
                // Profile header section.
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(firebaseUser.photoURL!),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            firebaseUser.displayName!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            firebaseUser.email!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Optional logout button in the body for additional visibility
                          TextButton(
                            onPressed: _logout,
                            child: Text(
                              "Logout",
                              style: GoogleFonts.inter(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                // Only display the buttons if the user role is "staff".
                if (userRole == "staff") ...[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Orgcreate()));
                    },
                    child: Container(
                      height: 55,
                      width: size.width - 40,
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
                          "Register an Organisation",
                          style: GoogleFonts.inter(
                            color: const Color(0xFF1D3259),
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Volunteercreate()));
                    },
                    child: Container(
                      height: 55,
                      width: size.width - 40,
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
                          "Create a Volunteering Post",
                          style: GoogleFonts.inter(
                            color: const Color(0xFF53441D),
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // Applied Volunteer heading.
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Applied Volunteer",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Volunteer posts list.
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: (userData?['volunteer'] as List<dynamic>?)?.length ?? 0,
                      itemBuilder: (context, index) {
                        // Use a FutureBuilder to get details of each volunteer post.
                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('volunteer')
                              .doc((userData?['volunteer'] as List)[index].toString())
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.hasData && snapshot.data!.exists) {
                              Map<String, dynamic>? volunteerDetails =
                                  snapshot.data?.data() as Map<String, dynamic>?;
                              return volunteerCard(
                                // Pass isApplied true so that the apply button is removed.
                                isApplied: true,
                                image: volunteerDetails?['logo'] ?? '',
                                location: volunteerDetails?['location'] ?? '',
                                date: volunteerDetails?['date'] ?? '',
                                orgDescription:
                                    volunteerDetails?['description'] ?? '',
                                contact: volunteerDetails?['contact'] ?? '',
                                name: volunteerDetails?['name'] ?? '',
                                banner: volunteerDetails?['banner'] ?? '',
                                donation: volunteerDetails?['donation'] ?? '',
                                website: volunteerDetails?['website'] ?? '',
                              );
                            } else {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                child: const Text(
                                  "Volunteer post not found",
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
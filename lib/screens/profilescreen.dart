// profile_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Adjust these imports to match your own structure.
import 'package:hapii/main.dart';                // For NavScreen, if it’s here
import 'package:hapii/screens/orgcreatescreen.dart';
import 'package:hapii/screens/volunteercreatescreen.dart';
import 'package:hapii/services/const.dart';
import 'package:hapii/widgets/volunteerCard.dart';

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
    // Get current user info
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    final size = MediaQuery.of(context).size;

    // Listen to the user's Firestore doc (includes "role" and "volunteer" array)
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

          // Retrieve user data from Firestore
          final userData = userSnapshot.data!.data();
          if (userData == null) {
            return const Center(child: Text('No user data found'));
          }

          // Read user role
          final String userRole = userData['role'] ?? 'student';

          return Center(
            child: Column(
              children: [
                // ---------------------------
                // Profile header section
                // ---------------------------
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      // User’s profile photo
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(firebaseUser.photoURL!),
                      ),
                      const SizedBox(width: 16),

                      // User’s basic info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            firebaseUser.displayName ?? 'No display name',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            firebaseUser.email ?? 'No email',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Additional logout button
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ---------------------------
                // Only show staff actions if userRole == "staff"
                // ---------------------------
                if (userRole == "staff") ...[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Orgcreate()),
                      );
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Volunteercreate()),
                      );
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

                // ---------------------------
                // Applied Volunteer heading
                // ---------------------------
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

                // ---------------------------
                // Show the user’s volunteer posts
                // ---------------------------
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      // This reads the 'volunteer' array from userData.
                      itemCount: (userData['volunteer'] as List<dynamic>?)?.length ?? 0,
                      itemBuilder: (context, index) {
                        // We expect userData['volunteer'] to store volunteer doc IDs or unique names
                        final volunteerId = (userData['volunteer'] as List)[index];

                        // Use a FutureBuilder to fetch each volunteer doc
                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('volunteer')
                              .doc(volunteerId.toString())
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData || !snapshot.data!.exists) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                child: const Text(
                                  "Volunteer post not found",
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            }

                            // If doc found, build the volunteerCard
                            final volunteerDetails =
                                snapshot.data!.data() as Map<String, dynamic>?;

                            return volunteerCard(
                              isApplied: true, // hide "Apply to Volunteer" button
                              name: volunteerDetails?['name'] ?? 'Unknown Name',
                              image: volunteerDetails?['logo'] ?? '',
                              banner: volunteerDetails?['banner'] ?? '',
                              location: volunteerDetails?['location'] ?? '',
                              date: volunteerDetails?['date'] ?? '',
                              orgDescription: volunteerDetails?['description'] ?? '',
                              contact: volunteerDetails?['contact'] ?? '',
                              donation: volunteerDetails?['donation'] ?? '',
                              website: volunteerDetails?['website'] ?? '',
                            );
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
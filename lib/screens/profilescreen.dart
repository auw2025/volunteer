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
    User? user = FirebaseAuth.instance.currentUser;
    var size = MediaQuery.of(context).size;
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
      body: Center(
        child: Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user!.photoURL!),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email!,
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
            // Buttons for creating Organisation and Volunteering posts
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
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc(user.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic>? userData = snapshot.data?.data();
                      // Use a default empty list if the volunteer field is null.
                      List<dynamic> volunteerList =
                          userData?['volunteer'] ?? [];
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: volunteerList.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('volunteer')
                                .doc(volunteerList[index].toString())
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot.hasData && snapshot.data!.exists) {
                                Map<String, dynamic>? volunteerDetails =
                                    snapshot.data?.data();
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
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
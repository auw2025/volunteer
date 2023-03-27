import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/main.dart';
import 'package:hapii/screens/orgcreatescreen.dart';
import 'package:hapii/screens/volunteercreatescreen.dart';
import 'package:hapii/services/const.dart';
import 'package:hapii/widgets/bottomNavBar.dart';

import '../widgets/volunteerCard.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore data = FirebaseFirestore.instance;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: kPrimaryBlack,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const NavScreen()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      backgroundColor: kPrimaryBG,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Orgcreate()));
              },
              child: Container(
                height: 55,
                width: size.width - 40,
                decoration: BoxDecoration(
                  color: Color(0xFFBFD4ED),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFF1D3259),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Register a Organisation",
                    style: GoogleFonts.inter(
                      color: Color(0xFF1D3259),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
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
                    color: Color(0xFF53441D),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Create a Volunteering Post",
                    style: GoogleFonts.inter(
                      color: Color(0xFF53441D),
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
              child: Text("Applied Volunteer",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Map<String, dynamic>? volunteer = snapshot.data?.data();
                        List<dynamic> volunteerlist = volunteer?['volunteer'];
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: volunteerlist.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                              future: FirebaseFirestore.instance.collection('volunteer').doc(volunteerlist[index].toString()).get(),
                                builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Map<String, dynamic>? volunteerdata =
                                    snapshot.data?.data();
                                return volunteerCard(
                                  image: volunteerdata!['logo'],
                                  location: volunteerdata!['location'],
                                  date: volunteerdata!['date'],
                                  orgDescription: volunteerdata!['description'],
                                  contact: volunteerdata!['contact'],
                                  name: volunteerdata!['name'],
                                  banner: volunteerdata!['banner'],
                                  donation: volunteerdata!['donation'],
                                  website: volunteerdata!['website'],
                                );
                              } else {
                                return Container();
                              }
                            });
                          },
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/screens/orgscreen.dart';
import 'package:hapii/services/const.dart';
import 'package:hapii/widgets/bottomNavBar.dart';
import 'package:hapii/widgets/volunteerCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    FirebaseFirestore data = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: kPrimaryBG,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20), // Adjust this value as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Text(
                  "Highlighted Organizations",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                height: 140, // increased height to account for the text below the logo
                margin: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                child: StreamBuilder<QuerySnapshot>(
                  stream: data.collection("community").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> mapdata =
                              snapshot.data!.docs[index].data() as Map<String, dynamic>;
                          
                          // Use null-aware operators, providing defaults if fields are null.
                          String logoUrl = mapdata['logo'] ?? 'https://via.placeholder.com/100';
                          String nickname = mapdata['nickname'] ?? 'No Nickname';
                          String bannerUrl = mapdata['banner'] ?? '';
                          String name = mapdata['name'] ?? '';
                          String location = mapdata['location'] ?? '';
                          String contact = mapdata['contact'] ?? '';
                          String description = mapdata['description'] ?? '';
                          String website = mapdata['website'] ?? '';
                          String donation = mapdata['donation'] ?? '';

                          // Ensure latlng exists and is a GeoPoint, otherwise provide a default value.
                          GeoPoint latlng = mapdata['latlng'] is GeoPoint
                              ? mapdata['latlng'] as GeoPoint
                              : const GeoPoint(22.302711, 114.177216);

                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavBar(
                                    true,
                                    OrgScreen(
                                      banner: NetworkImage(bannerUrl),
                                      image: NetworkImage(logoUrl),
                                      name: name,
                                      location: location,
                                      contact: contact,
                                      description: description,
                                      websiteUrl: website,
                                      donationUrl: donation,
                                      latlng: latlng,
                                    ),
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Organisation logo container.
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(logoUrl),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Organisation nickname.
                                  Text(
                                    nickname,
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      // Display a loading view while data is being loaded.
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return UnconstrainedBox(
                            child: Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  "Get Involved",
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
                  child: StreamBuilder<QuerySnapshot>(
                    stream: data.collection("volunteer").snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> mapdata =
                                snapshot.data!.docs[index].data() as Map<String, dynamic>;
                            return volunteerCard(
                              image: mapdata['logo'] ?? 'https://via.placeholder.com/100',
                              location: mapdata['location'] ?? 'No location',
                              date: mapdata['date'] ?? 'No date',
                              orgDescription: mapdata['description'] ?? 'No description',
                              contact: mapdata['contact'] ?? '',
                              name: mapdata['name'] ?? '',
                              banner: mapdata['banner'] ?? '',
                              donation: mapdata['donation'] ?? '',
                              website: mapdata['website'] ?? '',
                              relatedOrg: mapdata['related_org'] ?? 'Unknown',
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
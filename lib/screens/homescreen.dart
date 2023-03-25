import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/screens/orgscreen.dart';
import 'package:hapii/services/auth.dart';
import 'package:hapii/services/const.dart';
import 'package:hapii/widgets/bottomNavBar.dart';
import 'package:hapii/widgets/orgCard.dart';
import 'package:hapii/widgets/volunteerCard.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    FirebaseFirestore logo = FirebaseFirestore.instance;
    return Scaffold(
        backgroundColor: kPrimaryBG,
        bottomNavigationBar: BottomNavBar(
          currentIndex: 0,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Text(
                  "Featured organizations",
                  style: GoogleFonts.inter(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: 115,
                margin: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: StreamBuilder(
                  stream: logo.collection("community").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> group =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                          return orgCard(
                            NetworkImage(group['logo']),
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => orgScreen(
                                        image: NetworkImage(group['logo']),
                                        name: group['name'],
                                        location: group['location'],
                                        contact: group['contact'],
                                        description: group['description'],
                                        websiteUrl: group['website'],
                                        donationUrl: group['donation'],
                                      )),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  "Get Envolved",
                  style: GoogleFonts.inter(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return volunteerCard(
                          location: "Pune",
                          date: "1st April",
                          orgDescription: desc);
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

String desc =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of .";

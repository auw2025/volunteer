import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/screens/orgscreen.dart';
import 'package:hapii/services/const.dart';
import 'package:hapii/widgets/bottomNavBar.dart';
import 'package:hapii/widgets/orgCard.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Text(
                  "Featured organizations",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      )
                  ),
              ),
              Container(
                height: 115,
                margin: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: StreamBuilder(
                  stream: data.collection("community").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> mapdata = snapshot.data!.docs[index].data();
                          return orgCard(
                            NetworkImage(mapdata['logo']),
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavBar(
                                      true,
                                      OrgScreen(
                                        banner: NetworkImage(mapdata['banner']),
                                        image: NetworkImage(mapdata['logo']),
                                        name: mapdata['name'],
                                        location: mapdata['location'],
                                        contact: mapdata['contact'],
                                        description: mapdata['description'],
                                        websiteUrl: mapdata['website'],
                                        donationUrl: mapdata['donation'],
                                      ))),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(
                        height: size.height*0.15,
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
                    )
                ),
              ),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: StreamBuilder(
                    stream: data.collection("volunteer").snapshots(),

                    builder: (context, snapshot) {
                      if(snapshot.hasData)
                        {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> mapdata = snapshot.data!.docs[index].data();
                              return volunteerCard(
                                  image: mapdata['logo'],
                                  location: mapdata['location'],
                                  date: mapdata['date'],
                                  orgDescription: mapdata['description'],
                                contact: mapdata['contact'],
                                name: mapdata['name'],
                                banner: mapdata['banner'],
                                donation: mapdata['donation'],
                                website: mapdata['website'],);
                            },
                          );
                        }
                      else {
                        return Container();
                      }
                    }
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

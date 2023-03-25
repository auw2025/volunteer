import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/services/const.dart';
import 'package:hapii/services/extras.dart';
import 'package:hapii/widgets/bottomNavBar.dart';
import 'package:hapii/widgets/orgCard.dart';

class orgScreen extends StatefulWidget {
  ImageProvider image;
  String name;
  String location;
  String contact;
  String description;
  String donationUrl;
  String websiteUrl;
  orgScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.location,
      required this.contact,
      required this.description,
      required this.donationUrl,
      required this.websiteUrl});

  @override
  State<orgScreen> createState() => _orgScreenState();
}

class _orgScreenState extends State<orgScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore logo = FirebaseFirestore.instance;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
      backgroundColor: kPrimaryBG,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: 200,
                width: double.infinity,
                color: kPrimaryBlack,
              ),
              Positioned(
                left: 20,
                top: 50,
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: widget.image,
                          fit: BoxFit.cover,
                        ),
                        color: Color(0xFFFFCC00),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.location,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Contact: ${widget.contact}",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ]),
                  ],
                ),
              )
            ]),
            Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                widget.description,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      LaunchUrl(widget.donationUrl);
                    },
                    child: Container(
                      height: 55,
                      width: 175,
                      decoration: BoxDecoration(
                        color: kAccentGreen,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFF35591D),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Donate",
                          style: GoogleFonts.inter(
                            color: Color(0xFF35591D),
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      LaunchUrl(widget.websiteUrl);
                    },
                    child: Container(
                      height: 55,
                      width: 175,
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
                          "Website",
                          style: GoogleFonts.inter(
                            color: Color(0xFF53441D),
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
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Other Organizations',
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              height: 115,
              margin: const EdgeInsets.fromLTRB(20, 8, 0, 8),
              child: StreamBuilder(
                stream: logo.collection("community").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> group = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
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
          ],
        ),
      ),
    );
  }
}

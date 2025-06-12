import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/services/const.dart';
import 'package:hapii/services/extras.dart';
import 'package:hapii/widgets/bottomNavBar.dart';
import 'package:hapii/widgets/orgCard.dart';

class OrgScreen extends StatefulWidget {
  OrgScreen(
      {Key? key,
      required this.image,
      required this.name,
      required this.banner,
      required this.location,
      required this.contact,
      required this.description,
      required this.donationUrl,
      required this.websiteUrl})
      : super(key: key);
  ImageProvider image;
  ImageProvider banner;
  String name;
  String location;
  String contact;
  String description;
  String donationUrl;
  String websiteUrl;

  @override
  State<OrgScreen> createState() => _OrgScreenState();
}

class _OrgScreenState extends State<OrgScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryBG,
      extendBody: true,
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          SizedBox(
            height: size.height * 0.35,
            width: size.width,
            child: Stack(
              children: [
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
                Container(
                  alignment: Alignment.topLeft,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.15),
                      Container(
                        height: size.height * 0.1,
                        width: size.height * 0.1,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
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
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 10),
                        child: Row(
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                margin:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey.withOpacity(0.3),
                ),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w200,
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
              // Removed the "Other Organizations" section.
            ],
          ),
        ],
      ),
    );
  }
}
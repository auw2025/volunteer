import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/screens/volunteerscreen.dart';
import 'package:hapii/services/const.dart';
import 'package:hapii/widgets/bottomNavBar.dart';
import 'package:unicons/unicons.dart';

class volunteerCard extends StatelessWidget {
  final String location;
  final String donation;
  final String website;
  final String name;
  final String banner;
  final String date;
  final String orgDescription;
  final String image;
  final String contact;
  final bool isApplied;

  const volunteerCard({
    super.key,
    required this.contact,
    required this.name,
    required this.banner,
    required this.donation,
    required this.image,
    required this.location,
    required this.date,
    required this.orgDescription,
    required this.website,
    this.isApplied = false,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      width: size.width,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 4),
            )
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: kAccentGrey,
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    children: [
                      const Icon(
                        UniconsLine.clock_five,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text("Starts on $date"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: kAccentGrey,
                    borderRadius: BorderRadius.circular(50)),
                child: Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    children: [
                      const Icon(
                        UniconsLine.location_point,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(location),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 12),
            child: Row(
              children: [
                Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(image)),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 75,
                  width: size.width * 0.6,
                  child: Text(
                    orgDescription,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Only show the apply button if not applied
          if (!isApplied)
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavBar(
                        true,
                        volunteerScreen(
                          banner: NetworkImage(banner),
                          image: NetworkImage(image),
                          name: name,
                          location: location,
                          contact: contact,
                          description: orgDescription,
                          donationUrl: donation,
                          websiteUrl: website,
                          date: date,
                        ),
                      ),
                    ));
              },
              child: Container(
                width: size.width,
                height: 35,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black),
                child: Center(
                  child: Text(
                    "Apply to Volunteer",
                    style: GoogleFonts.inter(
                        fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
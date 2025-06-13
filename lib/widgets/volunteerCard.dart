/// volunteerCard.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/screens/volunteerscreen.dart'; // Update path if needed
import 'package:hapii/services/const.dart'; // Update path if needed
import 'package:hapii/widgets/bottomNavBar.dart'; // Update path if needed
import 'package:unicons/unicons.dart';

/// A card widget that displays volunteer post details.
/// If [isApplied] is true, the “Apply to Volunteer” button is replaced/hidden.
class volunteerCard extends StatelessWidget {
  final String location;
  final String donation;
  final String website;
  final String name;
  final String banner;
  final String date;
  final String orgDescription;
  final String relatedOrg;
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
    required this.relatedOrg,
    required this.website,
    this.isApplied = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          ),
        ],
      ),
      child: Column(
        children: [
          // Top row (date + location)
          Row(
            children: [
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: kAccentGrey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(
                        UniconsLine.clock_five,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text("Starts on $date"),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: kAccentGrey,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(
                        UniconsLine.location_point,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(location),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Middle row with image + description (bold & larger relatedOrg, no underline)
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 12),
            child: Row(
              children: [
                Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 75,
                  width: size.width * 0.6,
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: relatedOrg,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const TextSpan(
                          text: ': ',
                        ),
                        TextSpan(
                          text: orgDescription,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom button to open details screen
          if (!isApplied)
            GestureDetector(
              onTap: () {
                // Provide a small vibration
                HapticFeedback.lightImpact();

                // Navigate to volunteerScreen wrapped with BottomNavBar
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
                  ),
                );
              },
              child: Container(
                width: size.width,
                height: 35,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    "More Details",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/services/const.dart';
import 'package:unicons/unicons.dart';

class volunteerCard extends StatelessWidget {
  final String location;
  final String date;
  final String orgDescription;
  const volunteerCard(
      {super.key,
      required this.location,
      required this.date,
      required this.orgDescription});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      width: size.width - 32,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 64,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        child: Column(children: [
          Row(
            children: [
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
                width: 8,
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
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  height: 75,
                  width: size.width - 152,
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
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
            },
            child: Container(
              width: size.width,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.black),
              child: Center(
                child: Text(
                  "Apply to Volunteer",
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

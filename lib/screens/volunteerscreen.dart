import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/services/const.dart';
import 'package:hapii/services/extras.dart';

class volunteerScreen extends StatefulWidget {
  ImageProvider image;
  ImageProvider banner;
  String name;
  String location;
  String contact;
  String description;
  String donationUrl;
  String websiteUrl;
  String date;
  volunteerScreen(
      {super.key,
      required this.image,
      required this.banner,
      required this.name,
      required this.location,
      required this.contact,
      required this.description,
      required this.donationUrl,
      required this.websiteUrl,
      required this.date});

  @override
  State<volunteerScreen> createState() => _volunteerScreenState();
}

class _volunteerScreenState extends State<volunteerScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryBG,
      body: ListView(
        padding: EdgeInsets.zero,
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
                // Container(
                //   height: size.height * 0.2,
                //   width: size.width,
                //   decoration:  BoxDecoration(
                //     gradient: LinearGradient(
                //         begin: Alignment.center,
                //         end: Alignment.bottomCenter,
                //         colors: [
                //           Colors.transparent,
                //           Colors.white.withOpacity(0.1),
                //           Colors.white.withOpacity(0.2),
                //           Colors.white.withOpacity(0.3),
                //           Colors.white.withOpacity(0.4),
                //           Colors.white.withOpacity(0.5),
                //           Colors.white.withOpacity(0.6),
                //           Colors.white.withOpacity(0.7),
                //           Colors.white.withOpacity(0.9),
                //           Colors.white
                //         ]),
                //   ),
                // ),
                Container(
                  alignment: Alignment.topLeft,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.15),
                      Container(
                        height: size.height * 0.1,
                        width: size.height * 0.1,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: widget.image ,
                            ),
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius:
                            BorderRadius.circular(size.height * 0.05)),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10,top :10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 5),
                              child:  Row(
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
                            ),
                            Container(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 5),
                              child:  Row(
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey.withOpacity(0.3)),
              child:  Text(
                widget.description,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Colors.black,
                    ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    LaunchUrl("${widget.donationUrl}");
                  },
                  child: Container(
                    height: size.height*0.06,
                    width: size.width*0.4,
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
                    LaunchUrl("${widget.websiteUrl}");
                  },
                  child: Container(
                    height: size.height*0.06,
                    width: size.width*0.4,
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
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Volunteer on ${widget.date}',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              FirebaseFirestore.instance.collection("Users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({
                'volunteer': FieldValue.arrayUnion([
                  "${widget.name}"
                ])
              }
              );
              FirebaseFirestore.instance.collection("volunteer")
                  .doc(widget.name).collection('appliedvolunteer').doc(FirebaseAuth.instance.currentUser!.email).set({
                'name': FirebaseAuth.instance.currentUser!.displayName,
                'photo': FirebaseAuth.instance.currentUser!.photoURL,
                'gmail': FirebaseAuth.instance.currentUser!.email,
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
              height: 55,
              width: size.width,
              decoration: BoxDecoration(
                color: Color(0xFFEDC7BF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xFF59241D),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  "Apply Now",
                  style: GoogleFonts.inter(
                    color: Color(0xFF59241D),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              setReminder('To Volunteer for ${widget.name} on ${widget.date}');
            },
            child: Container(
              height: 55,
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
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
                  "Set Reminder",
                  style: GoogleFonts.inter(
                    color: Color(0xFF1D3259),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          // FutureBuilder(
          // future: FirebaseFirestore.instance.collection('volunteer').doc(widget.name).collection('appliedvolunteer').get(),
          // builder: (context, snapshot) {
          //   if (snapshot.hasData) {
          //
          //     return SizedBox(
          //       height: snapshot.data!.docs.length*100, // Specify a fixed height for the inner ListView
          //       child: ListView.builder(
          //         shrinkWrap: true,
          //         itemCount: snapshot.data!.docs.length,
          //         itemBuilder: (BuildContext context, int innerIndex) {
          //           Map<String, dynamic> mapdata = snapshot.data!.docs[innerIndex].data();
          //           return SizedBox(
          //               height: 100,
          //               width: size.width,
          //               child: ListView(
          //                 scrollDirection: Axis.horizontal,
          //                 children: [
          //                   Container(
          //                     alignment: Alignment.center,
          //                     width: size.width*0.9,
          //                     decoration: BoxDecoration(
          //                         color: Colors.white,
          //                         border: Border.all(color: Colors.white),
          //                         borderRadius: BorderRadius.circular(15),
          //                         boxShadow: [
          //                           BoxShadow(
          //                             color: Colors.black.withOpacity(0.2),
          //                             blurRadius: 5,
          //                             offset: const Offset(0, 4),
          //                           )
          //                         ]),
          //                     padding: EdgeInsets.only(top: 10, bottom: 10,right: 10,left: 10),
          //                     margin: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
          //                     child:  Row(
          //                       children: [
          //                         CircleAvatar(
          //                           radius: 50,
          //                           backgroundImage: NetworkImage("${mapdata['image']}"),
          //                         ),
          //                         Column(
          //                           crossAxisAlignment: CrossAxisAlignment.start,
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             Text(
          //                               mapdata['image'],
          //                               style: TextStyle(
          //                                 fontSize: 20,
          //                                 fontWeight: FontWeight.bold,
          //                               ),
          //                             ),
          //                             SizedBox(height: 4),
          //                             Text(
          //                               mapdata['image'],
          //                               style: TextStyle(
          //                                 fontSize: 16,
          //                                 fontWeight: FontWeight.w400,
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ],
          //                     ),
          //
          //                   ),
          //                 ],
          //               ));
          //         },
          //       ),
          //     );
          //   } else {
          //     return Container();
          //   }
          // }),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/screens/messagescreen.dart';
import 'package:hapii/services/const.dart';
import 'package:hapii/widgets/bottomNavBar.dart';

class Groupscreen extends StatelessWidget {
  const Groupscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryBlack,
        title: Text(
          'Communities',
          style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 2),
        ),
      ),
      backgroundColor: kPrimaryBG,
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('community').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> group =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return Group(
                    size: size,
                    Groupinfo: group['mission'],
                    Grouplogo: group['logo'],
                    Groupname: group['name'],
                  );
                },
              );
            } else {
              return Container();
            }
          }),
    );
  }
}

class Group extends StatelessWidget {
  const Group(
      {Key? key,
      required this.size,
      required this.Grouplogo,
      required this.Groupname,
      required this.Groupinfo})
      : super(key: key);

  final Size size;
  final String Grouplogo;
  final String Groupname;
  final String Groupinfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GroupChatRoom(
                  groupName: Groupname,
                  groupChatId: Groupname,
                  groupImage: Grouplogo)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.white),
        height: size.height * 0.1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(50),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(Grouplogo),
              ),
            ),
            Container(
              width: size.width * 0.73,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Groupname,
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    Groupinfo,
                    style: GoogleFonts.inter(
                        fontSize: 14, fontWeight: FontWeight.w300),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

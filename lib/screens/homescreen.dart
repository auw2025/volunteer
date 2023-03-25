import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                margin: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  "Featured organizations",
                  style: GoogleFonts.inter(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: 100,
                margin: const EdgeInsets.all(8),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return orgCard(NetworkImage(
                        'https://images.unsplash.com/photo-1678614033802-d8b11cd7fb93?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80'));
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

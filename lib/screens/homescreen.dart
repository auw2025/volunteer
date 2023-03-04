import 'package:flutter/material.dart';
import 'package:hapii/services/auth.dart';
import 'package:hapii/services/const.dart';
import 'package:hapii/widgets/volunteerCard.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryBG,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: volunteerCard(
                location: "Pune",
                date: "3rd May",
                orgDescription: desc,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(100),
              child: IconButton(
                icon: Icon(UniconsLine.exit),
                onPressed: () {
                  final provider = Provider.of<GoogleSignInProvider>(context);
                  provider.logout();
                },
              ),
            )
          ],
        ));
  }
}

String desc =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of .";

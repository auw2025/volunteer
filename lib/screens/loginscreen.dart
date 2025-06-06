import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/services/auth.dart';
import 'package:hapii/services/const.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        color: Colors.white,
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Image.asset(
                "assets/LoginBG.png",
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(45, (size.width - 300) / 2, 45, 100),
              child: Container(
                height: size.height,
                width: size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          "Tak Sun Volunteer Platform",
                          style: GoogleFonts.inter(
                              fontSize: 50, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          description,
                          style: GoogleFonts.inter(fontSize: 20),
                        ),
                      ),
                      Container(
                          width: 300,
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.googleLogin();
                            },
                            icon: const Icon(FontAwesomeIcons.google),
                            label: const Text("Sign In with Google"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryBlack),
                          )),
                    ]),
              ),
            ),
          ],
        ));
  }
}

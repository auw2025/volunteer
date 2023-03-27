import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/const.dart';
import '../services/firestore.dart';


class Volunteercreate extends StatelessWidget {
  Volunteercreate({Key? key}) : super(key: key);
  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController donation = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController logo = TextEditingController();
  TextEditingController banner = TextEditingController();
  TextEditingController mission = TextEditingController();
  TextEditingController date = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryBlack,
        title: Text(
          'Volunteer Form',
          style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 2),
        ),
      ),
      body: Container(

        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: const Text(
                "Topic",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
              width: size.width,
              height: 50,
              child: AutoSizeTextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Topic",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: kPrimaryBlack,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    )),
                controller: name,
                style: const TextStyle(fontSize: 22),
                minFontSize: 18,
                maxLines: 1,

              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: const Text(
                "logo",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
              width: size.width,
              height: 50,
              child: AutoSizeTextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.photo),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "logo",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: kPrimaryBlack,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    )),
                controller: logo,
                style: const TextStyle(fontSize: 22),
                minFontSize: 18,
                maxLines: 1,

              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: const Text(
                "Banner",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
              width: size.width,
              height: 50,
              child: AutoSizeTextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.photo),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "banner",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: kPrimaryBlack,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    )),
                controller: banner,
                style: const TextStyle(fontSize: 22),
                minFontSize: 18,
                maxLines: 1,

              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: const Text(
                "Mission",
                style:  TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
              width: size.width,
              child: AutoSizeTextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "mission",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: kPrimaryBlack,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    )),
                controller: mission,
                style: const TextStyle(fontSize: 22),
                minFontSize: 18,
                maxLines: 2,

              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: const Text(
                "Description",
                style:  TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
              width: size.width,
              child: AutoSizeTextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Description",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: kPrimaryBlack,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    )),
                controller: description,
                style: const TextStyle(fontSize: 22),
                minFontSize: 18,
                maxLines: 5,

              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child:const Text(
                "Date",
                style:  TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20,right: 20),
              width: size.width,
              height: 50,
              child: AutoSizeTextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "date",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: kPrimaryBlack,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    )),
                controller: date,
                style: TextStyle(fontSize: 22),
                minFontSize: 18,
                maxLines: 1,

              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child:const Text(
                "Location",
                style:  TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20,right: 20),
              width: size.width,
              height: 50,
              child: AutoSizeTextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "location",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: kPrimaryBlack,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    )),
                controller: location,
                style: TextStyle(fontSize: 22),
                minFontSize: 18,
                maxLines: 1,

              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child:const Text(
                "Contact",
                style:  TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20,right: 20),
              width: size.width,
              height: 50,
              child: AutoSizeTextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "contact",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: kPrimaryBlack,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    )),
                controller: contact,
                style: TextStyle(fontSize: 22),
                minFontSize: 18,
                maxLines: 1,

              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child:const Text(
                "Website",
                style:  TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20,right: 20),
              width: size.width,
              height: 50,
              child: AutoSizeTextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "website",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: kPrimaryBlack,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    )),
                controller: website,
                style: TextStyle(fontSize: 22),
                minFontSize: 18,
                maxLines: 1,

              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child:const Text(
                "Donation",
                style:  TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20,right: 20),
              width: size.width,
              height: 50,
              child: AutoSizeTextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "donation",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: kPrimaryBlack,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    )),
                controller: donation,
                style: TextStyle(fontSize: 22),
                minFontSize: 18,
                maxLines: 1,

              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(30),
              child: GestureDetector(
                onTap: () {
                  addvolunteer(banner.text,donation.text,contact.text, description.text, location.text, logo.text, mission.text, website.text, name.text, date.text);
                },
                child: Container(
                  height: size.height*0.06,
                  width: size.width*0.4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF35591D),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
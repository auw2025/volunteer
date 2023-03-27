import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hapii/widgets/bottomNavBar.dart';

import '../services/const.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController logo = TextEditingController();
    return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 60,),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
              width: size.width,
              height: 50,
              child: AutoSizeTextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "search",
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
          ],
        ));
  }
}

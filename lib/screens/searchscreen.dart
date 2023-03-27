import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hapii/screens/groupscreen.dart';
import 'package:hapii/widgets/bottomNavBar.dart';

import '../services/const.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController search = TextEditingController();
    final CollectionReference CommunityCollection = FirebaseFirestore.instance.collection('community');

    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const SizedBox(height: 60,),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
              width: size.width,
              height: 50,
              child: TextField(
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
                controller: search,
                style: const TextStyle(fontSize: 22),
                onSubmitted: (value){
                  setState(() {
                    query = search.text;
                  });
                },
                maxLines: 1,

              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: CommunityCollection.where('name', isGreaterThanOrEqualTo: query).get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: EdgeInsets.only(bottom: 10),
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
                  }
              ),
            )
          ],
        ));
  }
}

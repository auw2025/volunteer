import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hapii/screens/messagescreen.dart';

class Groupscreen extends StatelessWidget {
  const Groupscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Communities',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 2),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('community').snapshots(),

        builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> group = snapshot.data!.docs[index].data() as Map<String, dynamic>;

              return Group(size:size, Groupinfo:group['mission'] ,Grouplogo:group['logo'] ,Groupname:group['name'] ,);
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
              builder: (context) =>
                  GroupChatRoom(groupName: Groupname, groupChatId: Groupname)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black),
            color: Colors.black12),
        height: size.height * 0.1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    Groupinfo,
                    style: const TextStyle(
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

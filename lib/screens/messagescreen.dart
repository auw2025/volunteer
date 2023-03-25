import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapii/services/const.dart';

class GroupChatRoom extends StatefulWidget {
  final String groupChatId, groupName, groupImage;

  GroupChatRoom(
      {required this.groupName,
      required this.groupChatId,
      required this.groupImage,
      Key? key})
      : super(key: key);

  @override
  State<GroupChatRoom> createState() => _GroupChatRoomState();
}

class _GroupChatRoomState extends State<GroupChatRoom> {
  final TextEditingController _message = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  ScrollController _scrollController = ScrollController();

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> chatData = {
        "sendBy": _auth.currentUser!.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();

      await _firestore
          .collection('groups')
          .doc(widget.groupChatId)
          .collection('chats')
          .add(chatData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.groupImage),
          ),
        ),
        backgroundColor: kPrimaryBlack,
        title: Text(
          widget.groupName,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: kPrimaryBG,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.8,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('groups')
                    .doc(widget.groupChatId)
                    .collection('chats')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollController
                          .jumpTo(_scrollController.position.maxScrollExtent);
                    });
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> chatMap =
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                        if (index == 0) {
                          return MessageTile(size, chatMap, 1);
                        } else {
                          Map<String, dynamic> prevchatmap =
                              snapshot.data!.docs[index - 1].data()
                                  as Map<String, dynamic>;
                          if (prevchatmap['sendBy'] == chatMap['sendBy']) {
                            return MessageTile(size, chatMap, 0);
                          }
                          return MessageTile(size, chatMap, 1);
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.1,
                    width: size.width * 0.8,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    alignment: Alignment.centerRight,
                    child: TextField(
                      controller: _message,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: "Send Message",
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
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.send), onPressed: onSendMessage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget MessageTile(Size size, Map<String, dynamic> chatMap, int x) {
    return Builder(builder: (_) {
      if (chatMap['type'] == "text") {
        return Container(
          width: size.width * 0.8,
          alignment: chatMap['sendBy'] == _auth.currentUser!.displayName
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
              width: size.width * 0.8,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment:
                    chatMap['sendBy'] == _auth.currentUser!.displayName
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                children: [
                  (x == 1)
                      ? Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            chatMap['sendBy'],
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      : SizedBox(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: kAccentGreen,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            chatMap['message'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      } else if (chatMap['type'] == "img") {
        return Container(
          width: size.width,
          alignment: chatMap['sendBy'] == _auth.currentUser!.displayName
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            height: size.height / 2,
            child: Image.network(
              chatMap['message'],
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}

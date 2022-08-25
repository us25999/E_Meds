import 'dart:math';

import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/database_methods.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final myEmail, userEmail, userName, chatRoomId;
  ChatScreen(this.myEmail, this.userEmail, this.userName, this.chatRoomId);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String myId = "";
  String messageId = "";

  var messageStream;
  String userTokenId = "";
  bool isUserExist = false;

  TextEditingController messageController = TextEditingController();

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  getAndSetMessages() async {
    print(widget.chatRoomId);
    messageStream = await DatabaseMethods().getMessages(widget.chatRoomId);
    setState(() {});
  }

  @override
  void initState() {
    getAndSetMessages();
    super.initState();
  }

  onSendClick(bool send) {
    if (messageController.text != "") {
      String date = DateFormat("dd/MM/yyyy ").format(DateTime.now());
      String time = DateFormat('hh:mm a').format(DateTime.now());
      Map<String, dynamic> messageInfoMap = {
        "message": messageController.text,
        "sendBy": widget.myEmail,
        "date": date,
        "time": time,
        "ts": DateTime.now(),
      };
      if (messageId == "") {
        messageId = getRandomString(12);
      }

      DatabaseMethods()
          .addMessage(widget.chatRoomId, messageId, messageInfoMap)
          .then((value) {});
      if (send) {
        messageController.text = "";
        messageId = "";
        setState(() {});
      }
    }
  }

  Widget ChatListTile(ds) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: ds["sendBy"] == widget.myEmail
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: ds["sendBy"] == widget.myEmail
            ? const EdgeInsets.only(top: 3, bottom: 3, left: 50, right: 8)
            : const EdgeInsets.only(top: 3, bottom: 3, left: 8, right: 50),
        decoration: BoxDecoration(
          color:
              ds["sendBy"] == widget.myEmail ? Colors.grey[200] : Colors.cyan,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 65.0, bottom: 10, left: 12, top: 10),
              child: Text(
                ds["message"],
                style: TextStyle(
                  fontSize: 16,
                  color: ds["sendBy"] == widget.myEmail
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 7,
              right: 10,
              child: Text(
                ds["time"],
                style: TextStyle(
                  fontSize: 10,
                  color: ds["sendBy"] == widget.myEmail
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget AllChats() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? snapshot.data!.docs.length == 0
                ? Center(child: bAppText("No Chats to show", 15, Colors.black))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 65),
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return ChatListTile(ds);
                    },
                  )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 30,
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              HSpace(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text(
                    widget.userEmail,
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // UrlLauncher.launch("tel:${widget.userPhoneNumber}");
              },
              icon: Icon(
                Icons.call,
              ),
            ),
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("Settings"),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              AllChats(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(2),
                  child: Row(
                    children: [
                      // IconButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       chatBool = false;
                      //     });
                      //   },
                      //   icon: Icon(
                      //     Icons.cancel,
                      //     size: 28,
                      //   ),
                      // ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide(width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextField(
                              onChanged: (value) {},
                              minLines: 1,
                              maxLines: 3,
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Message",
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: green,
                        radius: 25,
                        child: IconButton(
                          onPressed: () {
                            onSendClick(true);
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

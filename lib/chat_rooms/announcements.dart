import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logapp/screens/home_screen.dart';
import 'package:logapp/widgets/widgets_lib.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

// ScrollController _controller = new ScrollController();
class Announcements extends StatefulWidget {
  const Announcements({Key? key}) : super(key: key);

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

String timegetter(){
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('jm');
  String time = formatter.format(now);
  // print(day);
  return time;
}

class _AnnouncementsState extends State<Announcements> {
  final TextEditingController _chatcontroller = TextEditingController();
  final storemessages = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          title: Text("Announcements",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
          // subtitle: Text("",
          //     style: TextStyle(
          //         fontSize: 13,
          //         color: Colors.white,
          //         fontWeight: FontWeight.w500)
          // ),
        ),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ListTile(
            //   title: Text("ASP.NET"),
            //   onTap: (){
            //
            //   },
            // )
            // Text("Message"),
            Expanded(
              child: SizedBox(
                child: ShowMessages(),
                height: 500,
              ),
            ),
            // Row(
              // children: [
              //   // Expanded(
              //   //     child: Container(
              //   //   child: TextField(
              //   //     autocorrect: true,
              //   //     controller: _chatcontroller,
              //   //     decoration: const InputDecoration(
              //   //       border: InputBorder.none,
              //   //       hintText: " Messages",
              //   //       prefixIcon: Icon(
              //   //         Icons.messenger_outline,
              //   //       ),
              //   //     ),
              //   //   ),
              //   // )),
              //   IconButton(
              //       onPressed: () {
              //         if (_chatcontroller.text.isNotEmpty) {
              //           storemessages.collection("Announcements").doc().set({
              //             "messages": _chatcontroller.text.trim(),
              //             "user": loginuser!.email.toString(),
              //             "time": DateTime.now(),
              //             "uid": loginuser!.uid,
              //             "display_time": DateFormat("jm").format(DateTime.now()),
              //           });
              //           _chatcontroller.clear();
              //           // _controller.animateTo(_controller.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
              //           // ShowNotification(),
              //         }
              //       },
              //       icon: const Icon(Icons.send)),
              // ],
            // )
          ],
        ),
      ),
    );
  }
}

class ShowMessages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Announcements")
          .orderBy("time", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            reverse: true,
            primary: true,
            // controller: _controller,
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              String msg = x["messages"];
              var url = Uri.parse(x["messages"]);
              RegExp exp = RegExp(r"""([\"'])\s*((?:(?:https?|ftp):\/\/)(?:\S+(?::\S*)?@)?(?:(?:(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-zA-Z0-9\u00a1-\uffff]+-?)*[a-zA-Z0-9\u00a1-\uffff]+)(?:\.(?:[a-zA-Z0-9\u00a1-\uffff]+-?)*[a-zA-Z0-9\u00a1-\uffff]+)*(?:\.(?:[a-zA-Z\u00a1-\uffff]{2,})))|localhost)(?::\d{2,5})?(?:\/(?:(?!\1|\s)[\S\s])*)?)\s*\1""");
              Iterable<RegExpMatch> matches = exp.allMatches(msg);
              bool linkval(text){
                for (var match in matches) {
                  print(text.substring(match.start, match.end));
                }
                return true;
              }
              return ListTile(
                title: Column(
                  // verticalDirection: VerticalDirection.up,

                  crossAxisAlignment: loginuser!.email == x["user"]
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: RichText(
                        text: TextSpan(
                          text:  msg,
                          style: linkunderline(x["messages"]),
                          recognizer: TapGestureRecognizer()..onTap=() async {
                            // Iterable<RegExpMatch> matches = exp.allMatches(msg);
                            for (var element in matches) {msg.substring(element.start,element.end);}
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url,mode: LaunchMode.externalApplication);
                            } else {
                              print("This isn't a URL");
                            }
                          },
                          // recognizer: TapGestureRecognizer()..onTap = (){linkval(msg);}
                        ),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: loginuser!.email == x["user"]
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))
                            : const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                        color: loginuser!.email == x["user"]
                            ? Colors.grey.withOpacity(0.3)
                            : Colors.blue.withOpacity(0.3),
                      ),
                    )
                  ],
                ),
                subtitle: Column(
                  // crossAxisAlignment: loginuser!.email == x["user"]
                  //     ? CrossAxisAlignment.end
                  //     : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(x["display_time"],
                        textAlign: loginuser!.email == x["user"] ? TextAlign.left : TextAlign.start,
                    ),
                  ],
                ),
                onLongPress: () {
                  if(loginuser!.uid == x["uid"]) {
                    FirebaseFirestore.instance
                        .collection("/Time_Table/Lectures/Monday")
                        .doc(x["start_time"] + " to " + x["end_time"])
                        .delete();
                  }
                  else{ print("you cant delete this message");}
                },
              );
            });
      },
    );
  }

  linkunderline(msgg) {

    RegExp exp = RegExp(r"""([\"'])\s*((?:(?:https?|ftp):\/\/)(?:\S+(?::\S*)?@)?(?:(?:(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-zA-Z0-9\u00a1-\uffff]+-?)*[a-zA-Z0-9\u00a1-\uffff]+)(?:\.(?:[a-zA-Z0-9\u00a1-\uffff]+-?)*[a-zA-Z0-9\u00a1-\uffff]+)*(?:\.(?:[a-zA-Z\u00a1-\uffff]{2,})))|localhost)(?::\d{2,5})?(?:\/(?:(?!\1|\s)[\S\s])*)?)\s*\1""");
    Iterable<RegExpMatch> matches = exp.allMatches(msgg);
    for (var match in matches) {
      // String uurl = Uri.parse(msgg.substring(match.start, match.end)).isAbsolute;
      if (Uri.tryParse(msgg) != null){
        nonlinktext();
      }
      else {
        linktext();
      }
    }
  }
}

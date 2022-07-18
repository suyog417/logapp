import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/home_screen.dart';

class ShowAnnouncements extends StatelessWidget {
  var exp =
      "/((([A-Za-z]{3,9}:(?://)?)(?:[-;:&=+\$,w]+@)?[A-Za-z0-9.-]+(:[0-9]+)?|(?:www.|[-;:&=+\$,w]+@)[A-Za-z0-9.-]+)((?:/[+~%/.w-_]*)???(?:[-+=&;%@.w_]*)#?(?:[w]*))?)/";
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
                          text:  x["messages"],
                          style: const TextStyle(fontSize: 17,
                          ),
                          recognizer: TapGestureRecognizer()..onTap=() async {
                            var url = Uri.parse(x["messages"]);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              print("Could not launch $url");
                            }
                          },
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
                  crossAxisAlignment: loginuser!.email == x["user"]
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(x["user"]),
                  ],
                ),
              );
            });
      },
    );
  }
}
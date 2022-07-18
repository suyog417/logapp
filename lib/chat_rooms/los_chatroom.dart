import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logapp/screens/home_screen.dart';

// ScrollController _controller = new ScrollController();
class LOSChatRoom extends StatefulWidget {
  const LOSChatRoom({Key? key}) : super(key: key);

  @override
  State<LOSChatRoom> createState() => _LOSChatRoomState();
}
// DocumentReference doc_ref = FirebaseFirestore.instance.collection("Usernames").doc();
// Future<String> get_data(DocumentReference doc_ref) async {
//   DocumentSnapshot docSnap = await doc_ref.get();
//   String doc_id = docSnap.date;
//   String doc_id2 = docSnap.reference.id;
//   // print(doc_id2);
//   return doc_id2;
// }
class _LOSChatRoomState extends State<LOSChatRoom> {
  final TextEditingController _chatcontroller = TextEditingController();
  final storemessages = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          title: Text("Linux Operating System",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
          subtitle: Text("Smt. T. D. Pawar",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
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
            Row(
              children: [
                Expanded(
                    child: Container(
                      child: TextField(
                        autocorrect: true,
                        controller: _chatcontroller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: " Messages",
                          prefixIcon: Icon(
                            Icons.messenger_outline,
                          ),
                        ),
                      ),
                    )),
                IconButton(
                    onPressed: () {
                      // get_data(doc_ref);
                      if (loginuser!.emailVerified == true) {
                        if (_chatcontroller.text.isNotEmpty) {
                          storemessages.collection("LOS_Chat").doc().set({
                            "messages": _chatcontroller.text.trim(),
                            "user": loginuser!.email.toString(),
                            "time": DateTime.now(),
                            "uid" : loginuser!.uid,
                          });
                          _chatcontroller.clear();
                          // _controller.animateTo(_controller.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                          // ShowNotification(),
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              "Email not verified \n Verify email to send messages"),
                        ));
                      }
                    },
                    icon: const Icon(Icons.send)),
              ],
            )
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
          .collection("LOS_Chat")
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
                  verticalDirection: VerticalDirection.up,
                  crossAxisAlignment: loginuser!.email == x["user"]
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        x["messages"],
                        style: const TextStyle(fontSize: 17),
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
                // onLongPress: () {
                //   if (loginuser!.uid == x["uid"]) {
                //     FirebaseFirestore.instance
                //         .collection("ADJ_Chat")
                //         .doc()
                //         .delete();
                //   }
                //   else{
                //     print("You can't delete this message");
                //   }
                // },
              );
            });
      },
    );
  }
}

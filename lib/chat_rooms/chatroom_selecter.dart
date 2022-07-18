import 'package:flutter/material.dart';

class ChatRoomNavigator extends StatefulWidget {
  const ChatRoomNavigator({Key? key}) : super(key: key);

  @override
  State<ChatRoomNavigator> createState() => _ChatRoomNavigatorState();
}

class _ChatRoomNavigatorState extends State<ChatRoomNavigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Subjects",style: TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(title: const Text("ASP.NET"),
            onTap: (){
              Navigator.pushNamed(context, "asp");
            },
            ),
            ListTile(title: const Text("Advance Java"),
              onTap: (){
                Navigator.pushNamed(context, "adj");
              },
            ),
            ListTile(title: const Text("PHP Programming "),
              onTap: (){
                Navigator.pushNamed(context, "php");
              },
            ),
            ListTile(title: const Text("Linux Operating System"),
              onTap: (){
                Navigator.pushNamed(context, "los");
              },
            ),
            ListTile(title: const Text("Common Chat"),
              onTap: (){
                Navigator.pushNamed(context, "chatscreen");
              },
            ),
          ],
        ),
      ),
    );
  }
}

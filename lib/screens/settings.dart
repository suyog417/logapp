import 'package:flutter/material.dart';
import 'package:logapp/screens/emailverify.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings",style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: SingleChildScrollView(
          child: Column(

            children: <Widget>[
              // Padding(padding: EdgeInsets.only(right: 50,left: 50)),
              ListTile(

                title: const Text("Verify email"),
                contentPadding: const EdgeInsets.only(left: 20,right: 20),
                shape:  const Border(bottom: BorderSide(color: Colors.black)),
                // enableFeedback: true,
                // style:,
                // tileColor: Colors.blue,
                onTap: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const EmailVerify()));
                },
              ),
              ListTile(
                title: const Text("Edit User Info"),
                shape:  const Border(bottom: BorderSide(color: Colors.black)),
                // tileColor: Colors.blue,
                onTap: (){
                  Navigator.pushNamed(context,"usernamesettings");
                },
              ),
              ListTile(

                title: const Text("About us"),
                contentPadding: const EdgeInsets.only(left: 20,right: 20),
                shape:  const Border(bottom: BorderSide(color: Colors.black)),
                // enableFeedback: true,
                // style:,
                // tileColor: Colors.blue,
                onTap: (){
                  Navigator.pushNamed(context,"about us");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

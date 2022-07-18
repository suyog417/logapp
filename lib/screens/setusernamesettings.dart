import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logapp/screens/home_screen.dart';
import 'package:logapp/widgets/widgets_lib.dart';

class SetUsernamesettings extends StatefulWidget {
  const SetUsernamesettings({Key? key}) : super(key: key);

  @override
  State<SetUsernamesettings> createState() => _SetUsernamesettingsState();
}

class _SetUsernamesettingsState extends State<SetUsernamesettings> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _rollno = TextEditingController();
  final TextEditingController _department = TextEditingController();
  final TextEditingController _addyear = TextEditingController();

  final storemessages = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("User Info",style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20,
            MediaQuery.of(context).size.height*0.09,
            20, 0),
        child: SingleChildScrollView(
          child: Column(

            children: <Widget>[
              userinfotype("Enter Username", Icons.person, false, _username, Colors.blueAccent.withOpacity(0.3), Colors.grey, Colors.black87,TextInputType.name),
              const SizedBox(height: 15,),
              userinfotype("Enter Roll. No.", Icons.person, false, _rollno, Colors.blueAccent.withOpacity(0.3), Colors.grey, Colors.black87,TextInputType.number),
              const SizedBox(height: 15,),
              userinfotype("Enter Programme", Icons.person, false, _department, Colors.blueAccent.withOpacity(0.3), Colors.grey, Colors.black87,TextInputType.name),
              const SizedBox(height: 15,),
              userinfotype("Enter Admission Year", Icons.person, false, _addyear, Colors.blueAccent.withOpacity(0.3), Colors.grey, Colors.black87,TextInputType.number),
              const SizedBox(height: 15,),
              resetpassbutton(context, (){
                loginuser!.updateDisplayName(_username.text);
                storemessages.collection("Usernames").doc(loginuser!.uid.toString()).set({
                  "username": _username.text.trim(),
                  "rollno": _rollno.text.trim(),
                  "department": _department.text.trim(),
                  "uid": loginuser!.uid.toString(),
                  "addmission_year": _addyear.text.trim(),
                });
                _rollno.clear();
                _department.clear();
                _username.clear();
                _addyear.clear();
              }, "Update Information")
            ],
          ),
        ),
      ),
    );
  }

}

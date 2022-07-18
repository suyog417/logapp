import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logapp/screens/home_screen.dart';
import 'package:logapp/widgets/widgets_lib.dart';

class SetUsername extends StatefulWidget {
  const SetUsername({Key? key}) : super(key: key);

  @override
  State<SetUsername> createState() => _SetUsernameState();
}

class _SetUsernameState extends State<SetUsername> {

  DateTime datetime = DateTime.now();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _rollno = TextEditingController();
  final TextEditingController _department = TextEditingController();
  final TextEditingController _addyear = TextEditingController();
  final storemessages = FirebaseFirestore.instance;

  Widget buildDatePicker() => SizedBox(
    height: 100,
    child: CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
        onDateTimeChanged: (datetime) =>
            setState(() => this.datetime = datetime)
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text("Set User Info"),
        backgroundColor: Colors.blueGrey,
        iconTheme: null,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20,
            MediaQuery.of(context).size.height*0.09,
            20, 0),
        child: SingleChildScrollView(
          child: Column(

            children: <Widget>[
              buildDatePicker(),
              const SizedBox(
                height: 100,
              ),
              userinfotype("Enter Username", Icons.person, false, _username, Colors.blueAccent.withOpacity(0.3), Colors.grey, Colors.black87,TextInputType.name),
              const SizedBox(height: 15,),
              userinfotype("Enter Roll. No.", Icons.person, false, _rollno, Colors.blueAccent.withOpacity(0.3), Colors.grey, Colors.black87,TextInputType.number),
              const SizedBox(height: 15,),
              userinfotype("Enter Programme", Icons.person, false, _department, Colors.blueAccent.withOpacity(0.3), Colors.grey, Colors.black87,TextInputType.name),
              const SizedBox(height: 15,),
              userinfotype("Enter Admission Year", Icons.person, false, _addyear, Colors.blueAccent.withOpacity(0.3), Colors.grey, Colors.black87,TextInputType.number),
              const SizedBox(height: 15,),
              resetpassbutton(context, (){
                if (_username.text.isNotEmpty&&_addyear.text.isNotEmpty&&_rollno.text.isNotEmpty&&_department.text.isNotEmpty){
                  storemessages
                      .collection("Usernames")
                      .doc(loginuser!.uid.toString())
                      .set({
                    "username": _username.text.trim(),
                    "rollno": _rollno.text.trim(),
                    "department": _department.text.trim(),
                    "uid": loginuser!.uid.toString(),
                    "addmission_year": _addyear.text.trim(),
                  });
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("All fields are necessary"),
                  ));
                }
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HomeScreen()));
                _rollno.clear();
                _department.clear();
                _username.clear();
                _addyear.clear();
              }, "Save Information")
            ],
          ),
        ),
      ),
    );
  }
  Future updateusername(String name)  async{
    await loginuser?.updateDisplayName(name);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logapp/screens/emailverify.dart';
import 'package:logapp/screens/home_screen.dart';
import 'package:logapp/widgets/widgets_lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Service {
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  final _auth = FirebaseAuth.instance;
  void CreateUser(context, email, password) async {
    try {
      // Method to create new user
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((res) => {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const EmailVerify()))
              });
    } catch (e) {
      // If any error occurs
      ErrorBox(context, "Enter Valid Credentials");
    }
  }

  void LoginUser(context, email, password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()))
              });
    } catch (e) {
      // If any error occurs
      ErrorBox(context, "Email not registered");
    }
  }

  void setusernamedb(uname) {
    FirebaseFirestore.instance.collection("Usernames").doc().set({
      "uname": uname.text.trim(),
    });
  }

  void SignOut(context) {
    try {
      _auth.signOut();
    } catch (e) {
      // If any error occurs
      ErrorBox(context, e);
    }
  }

  void ErrorBox(context, e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
          );
        });
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName);
  }

  void linkunderline(context,msgg){
    RegExp exp = RegExp(r"""([\"'])\s*((?:(?:https?|ftp):\/\/)(?:\S+(?::\S*)?@)?(?:(?:(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-zA-Z0-9\u00a1-\uffff]+-?)*[a-zA-Z0-9\u00a1-\uffff]+)(?:\.(?:[a-zA-Z0-9\u00a1-\uffff]+-?)*[a-zA-Z0-9\u00a1-\uffff]+)*(?:\.(?:[a-zA-Z\u00a1-\uffff]{2,})))|localhost)(?::\d{2,5})?(?:\/(?:(?!\1|\s)[\S\s])*)?)\s*\1""");
    Iterable<RegExpMatch> matches = exp.allMatches(msgg);
    for (var match in matches) {
      bool uurl = Uri.parse(msgg.substring(match.start, match.end)).isAbsolute;
      if (uurl){
        linktext();
      }
      else {
        nonlinktext();
      }
    }
  }
  void restpass(email, context) {
    try {
      _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // If any error occurs
      ErrorBox(context, e);
    }
  }


}

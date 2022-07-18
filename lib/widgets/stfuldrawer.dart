import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:logapp/screens/signin_screen.dart';
import 'package:logapp/services/auth.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../screens/home_screen.dart';

final usersref = FirebaseFirestore.instance.collection("Usernames");
class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

String daygetter() {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE');
  String day = formatter.format(now);
  // print(day);
  return day;
}

class _NavbarState extends State<Navbar> {
  @override
  void init(){
    _getusers();
    super.initState();
  }
  _getusers() async {
    final String id = loginuser!.uid ;
    // .then((DocumentSnapshot doc){
      final DocumentSnapshot doc = await usersref.doc(id).get();
      print(doc.data);
    // });
  }
  Widget svgCode = randomAvatar('saytoonz', trBackground: true, height: 50, width: 50);
  String weekday = daygetter();
  void timetablesetter(context, day) {
    switch (day) {
      case "Monday":
        {
          Navigator.pushNamed(context, "monday");
        }
        break; // print("1");
      case "Tuesday":
        {
          // print("2");
          Navigator.pushNamed(context, "tuesday");
        }
        break;
      case "Wednesday":
        {
          Navigator.pushNamed(context, "wednesday");
        }
        break;
      case "Thursday":
        {
          Navigator.pushNamed(context, "thursday");
        }
        break;
      case "Friday":
        {
          Navigator.pushNamed(context, "friday");
        }
        break;
      case "Saturday":
        {
          Navigator.pushNamed(context, "saturday");
        }
        break;
      case "Sunday":
        {
          Navigator.pushNamed(context, "sunday");
        }
        break;
      default:
        {
          print("Invalid choice");
        }
        break;
    }
  }

  // String displayName = "";
  // @override
  // void initState(){
  //   getdata();
  // }
  // getdata() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   displayName = prefs.getString("displayName")!;
  // }
  // String weekday = daygetter();
  Service service = Service();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ListTile(
          //   title: Text("Hello World",style: TextStyle(color: Colors.black87,)),
          // ),
          UserAccountsDrawerHeader(
            accountName: Text(loginuser!.displayName.toString()),
            accountEmail: Text(loginuser!.email.toString()),
            currentAccountPicture: CircleAvatar(
              child: ProfilePicture(
                name: loginuser!.displayName.toString(),
                random: false,
                radius: 41,
                fontsize: 30,
              )

            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              // image: DecorationImage(
              //   image: ,
              //   fit: BoxFit.cover,
              // )
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.favorite,
          //   color: Colors.blue),
          //   title: Text("Favorite"),
          //   onTap: () {
          //     Navigator.of(context).pushNamed('favorite');
          //   },
          // ),

          // ListTile(
          //   leading: Icon(Icons.calendar_today),
          //   title: Text("Manage Time Table"),
          //   onTap: () => {
          //   Navigator.of(context).pushNamed("managetimetable"),
          //     _getusers(),
          // },
          // ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text("Time Table"),
            onTap: () => {
              // Navigator.of(context).pushNamed('monday')
              timetablesetter(context, weekday),
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_outlined),
            title: const Text("Books/Notes"),
            onTap: () => {Navigator.of(context).pushNamed('assignment')},
          ),
          ListTile(
            leading: const Icon(Icons.message_outlined),
            title: const Text("Discussions"),
            onTap: () => {Navigator.of(context).pushNamed('navigator')},
          ),
          ListTile(
            leading: const Icon(Icons.announcement),
            title: const Text("Announcements"),
            onTap: () => {Navigator.of(context).pushNamed('announcements')},
          ),
          // ListTile(
          //   leading: Icon(Icons.info_outlined),
          //   title: Text("About us"),
          //   onTap: () => {
          //   Navigator.of(context).pushNamed('about us')
          // },
          // ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () => {Navigator.of(context).pushNamed('settings')},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined, color: Colors.blue),
            title: const Text("Sign Out"),
            onTap: () async {
              service.SignOut(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()));
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove("email");
            },
          ),
        ],
      ),
    );
  }
}

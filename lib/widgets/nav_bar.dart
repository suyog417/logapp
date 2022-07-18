import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:logapp/screens/home_screen.dart';
import '../screens/signin_screen.dart';
import '../services/auth.dart';


// ignore: must_be_immutable
class NavBar extends StatelessWidget {
  String displayName = "";
  @override
  void initState(){
    getdata();
  }
  static Future<String?> getdata() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username')!;
  }
  // static Future<String?> getUserNameSharedPreference() async{
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return await preferences.getString("username");
  // }
  Service service= Service();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(getdata().toString()),
            accountEmail: Text(loginuser!.email.toString()),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network("https://i.pinimg.com/custom_covers/222x/85498161615209203_1636332751.jpg",
                  fit: BoxFit.cover,
                ),

              ),
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
          //   title: Text("Calendar"),
          //   onTap: () => {
          //   Navigator.of(context).pushNamed('calendar')
          // },
          // ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text("Time Table"),
            onTap: () => {
            Navigator.of(context).pushNamed('tasks')
          },
          ),
          ListTile(
            leading: const Icon(Icons.book_outlined),
            title: const Text("Assignments"),
            onTap: () => {
            Navigator.of(context).pushNamed('assignment')
          },
          ),
          ListTile(
            leading: const Icon(Icons.message_outlined),
            title: const Text("Discussions"),
            onTap: () => {
              Navigator.of(context).pushNamed('navigator')
            },
          ),
          ListTile(
            leading: const Icon(Icons.announcement_outlined),
            title: const Text("Announcements"),
            onTap: () => {
            Navigator.of(context).pushNamed('events')
          },
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
            onTap: () => {
              Navigator.of(context).pushNamed('settings')
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined,
                color: Colors.blue),
            title: const Text("Sign Out"),
            onTap: () async {
              service.SignOut(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove("email");
            },
          ),
        ],
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logapp/widgets/stfuldrawer.dart';
import 'package:logapp/widgets/widgets_lib.dart';
import 'package:intl/intl.dart';

import '../services/auth.dart';

var loginuser = FirebaseAuth.instance.currentUser;
String timegetter() {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('jm');
  String time = formatter.format(now);
  // print(day);
  return time;
}


int daysBetween(DateTime from, DateTime to) {
  from = DateTime.now();
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

//the birthday's date
final date2 = DateTime.now();
final examday = DateTime(2022, 7, 22);
final difference = daysBetween(date2,examday);
final formattedexam = DateFormat('yMMMEd').format(examday);
final inst = FirebaseFirestore.instance.collection("Usernames");

String daygetter() {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE');
  String day = formatter.format(now);
  // print(day);
  return day;
}

String showtimetable(day) {
  var _day = "";
  switch (day) {
    case "Monday":
      {
        _day = "Monday";
        return _day;
        // Navigator.pushNamed(context, "monday");
      }
    case "Tuesday":
      {
        _day = "Tuesday";
        return _day;
        // Navigator.pushNamed(context, "tuesday");
      }
    case "Wednesday":
      {
        _day = "Wednesday";
        return _day;
        // Navigator.pushNamed(context, "wednesday");
      }
    case "Thursday":
      {
        _day = "Thursday";
        return _day;
        // Navigator.pushNamed(context, "thursday");
      }
    case "Friday":
      {
        _day = "Friday";
        return _day;
        // Navigator.pushNamed(context, "friday");
      }
    case "Saturday":
      {
        _day = "Saturday";
        return _day;
        // Navigator.pushNamed(context, "saturday");
      }
    case "Sunday":
      {
        _day = "Sunday";
        return _day;
      }
    default:
      {
        print("Invalid choice");
      }
      break;
  }
  return "Nothing";
}

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Service service = Service();
  String verifyuser = loginuser!.emailVerified == true ? "" : "Verify email to use features of this app" ;
  final auth = FirebaseAuth.instance;
  // final storemessages = FirebaseFirestore.instance;
  // var userinfo = FirebaseFirestore.instance.collection("Announcements").doc(loginuser!.uid).get();
  get user => getCurrentUser();
  getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loginuser = user;
    }
  }

  @override
  void initstate() {
    super.initState();
    getCurrentUser();
    messagesStream();
  }
  void messagesStream() async {
    var collection = FirebaseFirestore.instance.collection('Usernames');
    collection.doc(loginuser!.uid.toString()).snapshots().listen((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;
        // You can then retrieve the value from the Map like this:
        var name = data['username'];
        print(name);
      }
    });
    // String uname = ;
  }
  @override
  Widget build(BuildContext context) {
    // ScrollController _scontroller = ScrollController();
    // var USER = getCurrentUser();
    return Stack(
      children: <Widget>[
    Image.asset(
    "assets/images/bg.jpg",
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    ),
      Scaffold(
      drawer: const Navbar(),
      appBar: AppBar(
        title: const Text("Desk Alerts",style: TextStyle(color: Colors.black87),),
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
        backgroundColor: Colors.white,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.pushNamed(context, "imageprev");
        //       // messagesStream();
        //       // Navigator.pushNamed(context, "home");
        //     },
        //     icon: Icon(Icons.refresh_outlined),
        //     alignment: Alignment.centerRight,
        //     padding: EdgeInsets.only(right: 20),
        //   )
        // ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.03,
            10,
            MediaQuery.of(context).size.width * 0.03,
            0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // RefreshIndicator(
              //     child: CircularProgressIndicator(color: Colors.orange),
              //     onRefresh: () => Navigator.pushNamed(context, "home"),
              // triggerMode: RefreshIndicatorTriggerMode.,
              // ),
              // SizedBox( // Horizontal ListView
              //   height: 50,
              //   child: ListView.builder(
              //     itemCount: 20,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         width: 100,
              //         alignment: Alignment.center,
              //         // color: Colors.blue[(index % 9) * 100],
              //         child: ListTile(title: Text("Discussions"),),
              //       );
              //     },
              //   ),
              // ),
              Row(
                children: [
                  // padding: const EdgeInsets.all(8.0),
                  Expanded(
                    child: Container(
                      // alignment: Alignment.topLeft * 1.01,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 30,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            loginuser!.displayName.toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                          const SizedBox(height: 15,),
                          const Text("Next Exam",style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),),
                          Text(difference.toString()+" days remaining "+"($formattedexam)",),
                          // Container(child: LinearProgressIndicator(color: Colors.blue,value: 0.0,)),
                          Text(verifyuser),
                        ],
                      ),
                      height: 170,
                      // width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 15, top: 15,right: 15),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.3),
                        // boxShadow: [
                          // BoxShadow(
                          //   color: Colors.black87.withOpacity(0.5),
                          //   blurRadius: 5,
                          //   offset: const Offset(0.0, 0.0),
                          // )
                        // ],
                        // color: Colors.orange.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                // contentPadding: EdgeInsets.only(
                //     left: MediaQuery.of(context).size.width * 0.06,
                //     right: MediaQuery.of(context).size.width * 0.06),
                title: const Text(
                  'Announcements',
                  style: TextStyle(fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                trailing: icnbtn(const Icon(Icons.arrow_forward), () {
                  Navigator.pushNamed(context, "announcements");
                }, Colors.black87),
              ),
              Container(
                alignment: Alignment.center,
                  //logic for displaying messages in time using switch case abd datetime function "use jm for time formatting "
                  //show 3 latest messagse in container
                  child: ShowAncc(),
                height: 200,
                width: MediaQuery.of(context).size.width*0.9,
                decoration: BoxDecoration(
                  boxShadow: const [BoxShadow(
                    color: Colors.transparent,
                    offset: Offset(0,0),
                    blurRadius: 5,
                  )],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                  ),
              ListTile(
                // contentPadding: EdgeInsets.only(
                //     left: MediaQuery.of(context).size.width * 0.02,
                //     right: MediaQuery.of(context).size.width * 0.06),
                title: const Text(
                  'Time Table',
                  style: TextStyle(fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                trailing: icnbtn(const Icon(Icons.arrow_forward), () {
                  timetablesetter(context, daygetter());
                }, Colors.black87),
              ),
              const ListTile(
                title: Text(
                  'Lecture',
                  style: TextStyle(fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: ShowLectures(),
              ),
            ],
          ),
        ),
        color: Colors.white,
      ),
      // body: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.orange,
      //   ),
      // child: Column(
      //   children: <Widget>[
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children:[
      //         ListTile(title: Text("Announcements")),
      //         ListTile(title: Text("Time Table"),),
      //       ],
      //     )
      //   ],
      // ),
      )
  ]
      );
  }
}

class ShowAncc extends StatelessWidget {
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
            itemCount: snapshot.data!.docs.isEmpty ? 5 : snapshot.data!.docs.length,
            shrinkWrap: true,
            reverse: false,
            primary: true,
            // controller: _controller,
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              return ListTile(
                title: Column(
                  verticalDirection: VerticalDirection.up,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // crossAxisAlignment: loginuser!.email == x["user"]
                  //     ? CrossAxisAlignment.end
                  //     : CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        x["messages"],
                        style: const TextStyle(fontSize: 17
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      decoration:  const BoxDecoration(
                        // color: Colors.orange,
                        border: Border(bottom: BorderSide(color: Colors.black87,width: 0.5))
                        // borderRadius: loginuser!.email == x["user"]
                        //     ? BorderRadius.only(
                        //         topLeft: Radius.circular(10),
                        //         topRight: Radius.circular(10),
                        //         bottomLeft: Radius.circular(10))
                        //     : BorderRadius.only(
                        //         topLeft: Radius.circular(10),
                        //         topRight: Radius.circular(10),
                        //         bottomRight: Radius.circular(10)),
                        // color: Colors.blueAccent.withOpacity(0.7),
                        // color: loginuser!.email == x["user"]
                        //     ? Colors.grey.withOpacity(0.3)
                        //     : Colors.blue.withOpacity(0.3),
                      ),
                    )
                  ],
                ),
                // subtitle: Column(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   // crossAxisAlignment: loginuser!.email == x["user"]
                //   //     ? CrossAxisAlignment.end
                //   //     : CrossAxisAlignment.start,
                //   children: <Widget>[
                //     Text(x["user"]),
                //   ],
                // ),
              );
            });
      },
    );
  }
}

class ShowLectures extends StatelessWidget {
  final FSref = FirebaseFirestore.instance
      .collection("/Time_Table/Lectures/${showtimetable(daygetter())}")
      .orderBy("start_time", descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FSref,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            reverse: false,
            primary: true,
            // controller: _controller,
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              return ListTile(
                title: Column(
                  verticalDirection: VerticalDirection.up,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child:Text("Time :"+x["start_time"] + " to " + x["end_time"],
                        style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
                      ),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    )
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Faculty Name : "+x["teacher_name"]),
                    Text("Classroom : "+x["classroom"]),
                    Text("Subject : "+x["subject"])
                  ],
                ),
                // shape: Border(bottom: BorderSide(color: Colors.black87,width: 1.5)),
                onLongPress: (){
                  FirebaseFirestore.instance.collection("/Time_Table/Lectures/Monday").doc(x["start_time"]+" to "+x["end_time"]).delete();
                },
              );
            });

      },
    );

  }
}

class ShowPracticals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("/Time_Table/Practicals/${showtimetable(daygetter())}")
          .orderBy("start_time", descending: true)
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
            reverse: false,
            primary: true,
            // controller: _controller,
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              return ListTile(
                title: Column(
                  verticalDirection: VerticalDirection.up,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("Time :"+x["start_time"] + " to " + x["end_time"],
                        style: const TextStyle(fontSize: 17),
                      ),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    )
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("CM1 : "+x["FBsubject"],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                    Text("Lab : "+x["FBlab"]),
                    Text("Faculty Name : "+x["FBfaculty"]),
                    const SizedBox(height: 5,),
                    Text("CM2 : "+x["SBsubject"],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                    Text("Lab : "+x["SBlab"]),
                    Text("Faculty Name : "+x["SBfaculty"]),
                    const SizedBox(height: 5,),
                    Text("CM3 : "+x["TBsubject"],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                    Text("Lab : "+x["TBlab"]),
                    Text("Faculty Name : "+x["TBfaculty"]),
                  ],
                ),
                style: ListTileStyle.drawer,
                onLongPress: (){
                  FirebaseFirestore.instance.collection("/Time_Table/Practicals/Monday").doc(x["start_time"]+" to "+x["end_time"]).delete();
                },

                // shape: Border(bottom: BorderSide(color: Colors.black87,width: 1.5)),
              );

            });
      },
    );
  }
}

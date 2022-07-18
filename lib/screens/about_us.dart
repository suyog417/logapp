import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        // title: Text("About Us",style: TextStyle(color: Colors.black87),),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).size.height * 0.05, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              "About Us",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5,),
            Text("Project Name : Desk Alert's"),
            SizedBox(height: 5,),
            Text("Group Leader : Snehdeep Gosavi"),
            SizedBox(height: 5,),
            Text("Group Name : Tech Saviours"),
            SizedBox(height: 5,),
            Text("Group Member's :"),
            // SizedBox(height: 2,),
            ListTile(
              title: Text("1) Suyog Bhoye"),
              subtitle: Text("Roll no : 196109 "),
            ),
            // SizedBox(height: 2,),
            ListTile(
              title: Text("1) Kartik Deshpande"),
              subtitle: Text("Roll no : 196167 "),
            ),
            // SizedBox(height: 2,),
            ListTile(
              title: Text("1) Saurabh Jadhav"),
              subtitle: Text("Roll no : 196126 "),
            ),
            // SizedBox(height: 2,),
            ListTile(
              title: Text("1) Snehdeep Gosavi"),
              subtitle: Text("Roll no : 196123 "),
            ),
          ],
        ),
      ),
    );
  }
}

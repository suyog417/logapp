import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            ListTile(title: Text("PHP Practical 11:00 AM to 01:00 PM",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),
            ),
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 1),
                  // borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.add),
      ),
    );
  }
}

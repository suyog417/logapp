import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CreateTimeTable extends StatefulWidget {
  const CreateTimeTable({Key? key}) : super(key: key);

  @override
  State<CreateTimeTable> createState() => _CreateTimeTableState();
}

class _CreateTimeTableState extends State<CreateTimeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Add Time Table"),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text("Monday"),
              onTap: () => Navigator.pushNamed(context, "monday"),
              shape: const Border(bottom: BorderSide(color: Colors.black87,width: 1)),
            ),
            ListTile(
              title: const Text("Tuesday"),
              onTap: () => Navigator.pushNamed(context, "tuesday"),
              shape: const Border(bottom: BorderSide(color: Colors.black87,width: 1)),
            ),
            ListTile(
              title: const Text("Wednesday"),
              onTap: () => Navigator.pushNamed(context, "wednesday"),
              shape: const Border(bottom: BorderSide(color: Colors.black87,width: 1)),
            ),
            ListTile(
              title: const Text("Thursday"),
              onTap: () => Navigator.pushNamed(context, "thursday"),
              shape: const Border(bottom: BorderSide(color: Colors.black87,width: 1)),
            ),
            ListTile(
              title: const Text("Friday"),
              onTap: () => Navigator.pushNamed(context, "friday"),
              shape: const Border(bottom: BorderSide(color: Colors.black87,width: 1)),
            ),
            ListTile(
              title: const Text("Saturday"),
              onTap: () => Navigator.pushNamed(context, "saturday"),
              shape: const Border(bottom: BorderSide(color: Colors.black87,width: 1)),
            ),
            ListTile(
              title: const Text("Final Exam"),
              onTap: () => Navigator.pushNamed(context, "monday"),
              shape: const Border(bottom: BorderSide(color: Colors.black87,width: 1)),
            ),
            ListTile(
              title: const Text("First Periodic Test"),
              onTap: () => Navigator.pushNamed(context, "monday"),
              shape: const Border(bottom: BorderSide(color: Colors.black87,width: 1)),
            ),
            ListTile(
              title: const Text("Second Periodic Test"),
              onTap: () => Navigator.pushNamed(context, "monday"),
              shape: const Border(bottom: BorderSide(color: Colors.black87,width: 1)),
            ),

          ],
        ),
      ),

      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.book),
              label: "Lecture",
              onTap: () => Navigator.pushNamed(context, "lecture")
          ),
          SpeedDialChild(
              child: const Icon(Icons.book),
              label: "Practical",
              onTap: () => Navigator.pushNamed(context, "practical")
          ),
        ],
      ),
    );
  }
}

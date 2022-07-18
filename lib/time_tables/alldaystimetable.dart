import 'package:flutter/material.dart';

class AllTimeTable extends StatefulWidget {
  const AllTimeTable({Key? key}) : super(key: key);

  @override
  State<AllTimeTable> createState() => _AllTimeTableState();
}

class _AllTimeTableState extends State<AllTimeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("Time Table"),
      ),
      body: Container(
        child: Column(
          children: const <Widget>[
            Card(
              child: ListTile(
                // title: ,
              ),
            )
          ],
        ),
      ),
    );
  }
}

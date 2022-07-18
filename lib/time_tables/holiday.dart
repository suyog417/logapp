import 'package:flutter/material.dart';

class holiday extends StatefulWidget {
  const holiday({Key? key}) : super(key: key);

  @override
  State<holiday> createState() => _holidayState();
}

class _holidayState extends State<holiday> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: const <Widget>[
            Text("Enjoy Your",style: TextStyle(fontSize: 20),),
            Text("Weekend",style: TextStyle(fontSize: 22),),
          ],
        ),
      ),
    );
  }
}

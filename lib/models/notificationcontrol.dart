import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class NotificationControl extends StatefulWidget {
  const NotificationControl({Key? key}) : super(key: key);

  @override
  State<NotificationControl> createState() => _NotificationControlState();
}

class _NotificationControlState extends State<NotificationControl> {

  @override
  void shownotification(title,body){
    setState(() {
    });
    flutterLocalNotificationsPlugin.show(0,
      "$title ", "$body",
      NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',importance: Importance.high,
            enableVibration: true,
          )
      ),
    );
  }
  notify(now){
    if(now == DateTime.now().toString()){
      shownotification("Hello", "This is test notification");
    }
    else{
      print("Wait some time for notification");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(child: const Text("Notify"),
        onPressed: notify("12:50 PM"),
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logapp/chat_rooms/adj_chatroom.dart';
import 'package:logapp/chat_rooms/announcements.dart';
import 'package:logapp/chat_rooms/asp_chatroom.dart';
import 'package:logapp/chat_rooms/chatroom_selecter.dart';
import 'package:logapp/chat_rooms/los_chatroom.dart';
import 'package:logapp/chat_rooms/php_chatroom.dart';
import 'package:logapp/screens/about_us.dart';
import 'package:logapp/screens/assignments.dart';
import 'package:logapp/screens/calendar.dart';
import 'package:logapp/screens/chatscreen.dart';
import 'package:logapp/screens/events.dart';
import 'package:logapp/screens/favorites.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logapp/screens/home_screen.dart';
import 'package:logapp/screens/resetpassword.dart';
import 'package:logapp/screens/settings.dart';
import 'package:logapp/screens/setusername.dart';
import 'package:logapp/screens/setusernamesettings.dart';
import 'package:logapp/screens/signin_screen.dart';
import 'package:logapp/screens/signup_screen.dart';
import 'package:logapp/screens/tasks.dart';
import 'package:logapp/services/createtimetable.dart';
import 'package:logapp/time_tables/addexamtimetable.dart';
import 'package:logapp/time_tables/addpractical.dart';
import 'package:logapp/time_tables/friday.dart';
import 'package:logapp/time_tables/holiday.dart';
import 'package:logapp/time_tables/monday.dart';
import 'package:logapp/time_tables/saturday.dart';
import 'package:logapp/time_tables/thursday.dart';
import 'package:logapp/time_tables/time_table_input.dart';
import 'package:logapp/time_tables/tuesday.dart';
import 'package:logapp/time_tables/wednesday.dart';
import 'package:shared_preferences/shared_preferences.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_impoertnace_channel', //id
    'High Importance Notification', //title
    description:
        "This channel is used for important notifications", //description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("a bg message just showed up : ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  SharedPreferences pref = await SharedPreferences.getInstance();
  var email = pref.getString("email");
  @override
  void initState(context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              playSound: true,
            )));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
  }

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Desk Alert's",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // brightness: Brightness.dark,
      ),
      // home: NotificationControl(),
      home: email == null ? const SignInScreen() : const HomeScreen(),
      routes: <String, WidgetBuilder>{
        "login": (BuildContext context) => const SignInScreen(),
        "signup": (BuildContext context) => const SignUpScreen(),
        "home": (BuildContext context) => const HomeScreen(),
        "favorite": (BuildContext context) => const FavoritesScreen(),
        "tasks": (BuildContext context) => const TasksScreen(),
        "assignment": (BuildContext context) => const AssignmentScreen(),
        "events": (BuildContext context) => const EventsScreen(),
        "calendar": (BuildContext context) => const CalendarScreen(),
        "settings": (BuildContext context) => const SettingsScreen(),
        "about us": (BuildContext context) => const AboutUs(),
        "chatscreen": (BuildContext context) => const ChatScreen(),
        "resetscreen": (BuildContext context) => const ResetScreen(),
        "navigator": (BuildContext context) => const ChatRoomNavigator(),
        "setusername": (BuildContext context) => const SetUsername(),
        "announcements": (BuildContext context) => const Announcements(),
        "asp": (BuildContext context) => const ASPChatRoom(),
        "adj": (BuildContext context) => const ADJChatRoom(),
        "php": (BuildContext context) => const PHPChatRoom(),
        "los": (BuildContext context) => const LOSChatRoom(),
        "usernamesettings": (BuildContext context) => const SetUsernamesettings(),
        // "imageprev" : (BuildContext context) => ImagePreview(),

        // time tables
        "examtimetable": (BuildContext context) => const AddExamTimeTable(),
        "practical": (BuildContext context) => const AddPractical(),
        "managetimetable": (BuildContext context) => const CreateTimeTable(),
        "lecture": (BuildContext context) => const TimeTableInput(),
        "monday": (BuildContext context) => const Monday(),
        "tuesday": (BuildContext context) => const Tuesday(),
        "wednesday": (BuildContext context) => const Wednesday(),
        "thursday": (BuildContext context) => const Thursday(),
        "friday": (BuildContext context) => const Friday(),
        "saturday": (BuildContext context) => const Saturday(),
        "sunday": (BuildContext context) => const holiday(),
      }));
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;
  @override
  void initState(){
    user = auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      checkEmailVerification();
    });
    super.initState();
  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // iconTheme: null,
        backgroundColor: Colors.blueAccent,
        title: const Text("Email Verification"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            CircularProgressIndicator(color: Colors.red.withOpacity(0.7)),
            Text("An Email has been sent to \n${user.email}",style: const TextStyle(fontSize: 17,
            fontWeight: FontWeight.w600,
            ),),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              if(user.emailVerified==true){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HomeScreen()));
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Email Not Verified"),
                ));
              }
            },
                child: const Text("Email Verified"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){user.sendEmailVerification();}, child: const Text("Send Email Again"))
          ],
        ),
      ),
    );
  }
  Future<void> checkEmailVerification() async{
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified == false)
    {
      timer.cancel();
      // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const SignInScreen()));
    }
  }
}

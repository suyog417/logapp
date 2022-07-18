import 'package:flutter/material.dart';
import 'package:logapp/services/auth.dart';
import 'package:logapp/widgets/widgets_lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passcheckTextController = TextEditingController();

  Service service= Service();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text("   Sign Up", style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/5836.jpg"),
                // SizedBox(
                //   height: 20,
                // ),
                // reusabletextfield(
                //     "Username", Icons.person_outline, false,
                //     _usernameTextController,Colors.blueAccent.withOpacity(0.3),
                //     Colors.blueAccent,Colors.black87),
                const SizedBox(
                  height: 20,
                ),
                reusabletextfield(
                  "Email address", Icons.person_outline, false,
                  _emailTextController,Colors.blueAccent.withOpacity(0.3),
                    Colors.blueAccent,Colors.black87),
                const SizedBox(
                  height: 20,
                ),
                reusabletextfield("Password", Icons.lock_outline, true,
                    _passwordTextController,Colors.blueAccent.withOpacity(0.3),
                    Colors.blueAccent,Colors.black87),
                const SizedBox(height: 20,),
                reusabletextfield("Re-enter password", Icons.person_outline, true,
                    _passcheckTextController,Colors.blueAccent.withOpacity(0.3),Colors.blueAccent,Colors.black87),
                const SizedBox(
                  height: 20,
                ),
                signimsignupbutton(context, false, () async {
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  if(_emailTextController.text.isNotEmpty && _passwordTextController.text.isNotEmpty&&_passcheckTextController.text.isNotEmpty){
                    if(_passcheckTextController.text == _passwordTextController.text){
                    service.CreateUser(context, _emailTextController.text, _passwordTextController.text);}
                    else{
                      service.ErrorBox(context, "Password's don't match set again");
                    }
                    // Service.saveUserNameSharedPreference(_usernameTextController.text);
                  }
                  else{
                    service.ErrorBox(context, "All fields are necessary");
                  }
                  pref.setString("email", _emailTextController.text);
                },
                ),
                signinoption(),
              ],

            ),
          ),
        ),

      ),

    );
  }

  Row signinoption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
            "Already have an account?", style: TextStyle(color: Colors.blueGrey)),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "login");
          },
          child: const Text(
            " Sign In", style: TextStyle(
              color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}


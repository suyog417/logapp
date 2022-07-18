import 'package:flutter/material.dart';
import 'package:logapp/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth.dart';
import '../widgets/widgets_lib.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  Service service = Service();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: hexStringToColor("#FEFEFE"),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.01, 20, 40),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/start.jpg"),
                const FittedBox(
                  child: Text("Welocme to\nGovernment Polytechnic,",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: Colors.lightBlueAccent)),
                  fit: BoxFit.scaleDown,
                ),
                // Text("Welcome to \nGovernment Polytechnic, ",textAlign: TextAlign.center,
                //     style: TextStyle(fontWeight: FontWeight.w700,
                //     fontSize: 25,
                //     color: Colors.lightBlueAccent)),
                // Text("Nashik ",
                //     style: TextStyle(fontWeight: FontWeight.w700,
                //         fontSize: 25,
                //         color: Colors.lightBlueAccent)),
                const FittedBox(
                  child: Text("Nashik",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: Colors.lightBlueAccent)),
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(
                  height: 10,
                ),
                reusabletextfield(
                    "Enter email address",
                    Icons.person_outline,
                    false,
                    _emailTextController,
                    Colors.blueAccent.withOpacity(0.3),
                    Colors.blueAccent,
                    Colors.black87),
                const SizedBox(
                  height: 20,
                ),
                reusabletextfield(
                    "Enter password",
                    Icons.lock_outline,
                    true,
                    _passwordTextController,
                    Colors.blueAccent.withOpacity(0.3),
                    Colors.blueAccent,
                    Colors.black87),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "resetscreen");
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13),
                        )),
                  ],
                ),
                signimsignupbutton(
                  context,
                  true,
                  () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    if (RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(_emailTextController.text)){
                      if (_emailTextController.text.isNotEmpty &&
                          _passwordTextController.text.isNotEmpty) {
                        service.LoginUser(context, _emailTextController.text,
                            _passwordTextController.text);
                        pref.setString("email", _emailTextController.text);
                      } else {
                        service.ErrorBox(context, "Enter Valid Credentials");
                      }
                    }
                  },
                ),
                signupoption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signupoption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have account?",
            style: TextStyle(color: Colors.blueGrey)),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "signup");
          },
          child: const Text(
            " Register",
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:logapp/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth.dart';
import '../widgets/widgets_lib.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({ Key? key }) : super(key: key);
  @override

  State<ResetScreen> createState() => _ResetScreenState();
}
class _ResetScreenState extends State<ResetScreen> {

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();
  Service service= Service();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.transparent,
      ),
      body : Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: hexStringToColor("#FEFEFE"),
        ),
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.fromLTRB(20,
              MediaQuery.of(context).size.height*0.0005, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/start.jpg"),
                const FittedBox(
                  child: Text("Welocme to\nGovernment Polytechnic,",textAlign: TextAlign.center
                      ,style: TextStyle(fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Colors.lightBlueAccent)) ,
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
                  child: Text("Nashik",textAlign: TextAlign.center
                      ,style: TextStyle(fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Colors.lightBlueAccent)) ,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(
                  height: 10,
                ),
                reusabletextfield("Enter email address",Icons.person_outline,false,
                    _emailTextController,
                    Colors.blueAccent.withOpacity(0.3),Colors.blueAccent,Colors.black87),
                const SizedBox(
                  height: 20,
                ),
                // reusabletextfield("Enter password",Icons.lock_outline,true,
                //     _passwordTextController,
                //     Colors.blueAccent.withOpacity(0.3),Colors.blueAccent,Colors.black87),
                const SizedBox(
                  height: 10,
                ),
                resetpassbutton(context,() async {
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  if(_emailTextController.text.isNotEmpty){
                    service.restpass(_emailTextController.text,context);
                    Navigator.pushNamed(context, "login");
                  }
                  else{
                    service.ErrorBox(context, "Enter Valid Credentials");
                  }
                },"Send Request"),
              ],

            ),
          ),
        ),
      ),
    );
  }

  }





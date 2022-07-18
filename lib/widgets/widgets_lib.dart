import 'package:flutter/material.dart';

IconButton icnbtn(Icon icon, ontap,Color color){
  return IconButton(onPressed: ontap, icon: icon,color: color,);
}

Image logoWidget(imageName) {
  return Image.asset(imageName,fit: BoxFit.fitWidth,
    width: 320,
    height: 320,
    // color: Colors.redAccent,
  );
}
TextField reusabletextfield(String text, IconData icon,bool ispasswordtype,TextEditingController controller, color,prefixiconcolor,cursorcolor){
  return TextField(

    controller: controller,
    obscureText: ispasswordtype,
    enableSuggestions: !ispasswordtype,
    autocorrect: !ispasswordtype,
    cursorColor: cursorcolor,
    style: TextStyle(color: Colors.black87.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: prefixiconcolor,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.black87.withOpacity(0.5)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: color,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.9),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      )

    ),
    keyboardType: ispasswordtype ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}
TextField userinfotype(String text, IconData icon,bool ispasswordtype,TextEditingController controller, color,prefixiconcolor,cursorcolor,kbtype){
  return TextField(
    controller: controller,
    obscureText: ispasswordtype,
    enableSuggestions: !ispasswordtype,
    autocorrect: !ispasswordtype,
    cursorColor: cursorcolor,
    style: TextStyle(color: Colors.black87.withOpacity(0.9)),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: prefixiconcolor,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black87.withOpacity(0.5)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: color,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.9),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        )

    ),
    keyboardType: kbtype,
  );
}
Container signimsignupbutton( BuildContext context, bool isLogin, Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      child: Text(
        isLogin ? "LOG IN" : "SIGN UP",
        style: const TextStyle(
          color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 16,),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)){
            return Colors.black26;
          }
          return Colors.white;
        }
        ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
    ),
  )
  );
}
TextStyle simpleTextStyle() {
  return const TextStyle(color: Colors.white, fontSize: 16);
}
TextStyle biggerTextStyle() {
  return const TextStyle(color: Colors.white, fontSize: 17);
}
InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white54),
      focusedBorder:
      const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
      const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}
Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset(
      "assets/images/logo.png",
      height: 40,
    ),
    elevation: 0.0,
    centerTitle: false,
  );
}
Container resetpassbutton( BuildContext context, Function onTap,String text){
  return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: (){
          onTap();
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 16,),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)){
              return Colors.black26;
            }
            return Colors.white;
          }
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        ),
      )
  );
}
TextStyle nonlinktext(){
  return const TextStyle(
    color: Colors.black87,
    // decoration: TextDecoration.underline,
    fontSize: 17,

  );
}

TextStyle linktext(){
  return const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
    fontSize: 17,

  );
}


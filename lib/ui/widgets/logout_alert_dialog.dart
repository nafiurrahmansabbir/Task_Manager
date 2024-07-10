import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../screens/auth/sign_in_screen.dart';

void logout_alert_dialog(context) {
  Alert(
    context: context,
    type: AlertType.none,
    title: "Log Out",
    desc: "Are You sure?",
    buttons: [
      DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => _loginpage(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(225, 24, 106, 1.0),
            Color.fromRGBO(140, 15, 143, 1.0),
          ])),
      DialogButton(
        child: Text(
          "No",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(0, 179, 134, 1.0),
        ]),
      )
    ],
  ).show();
}

void _loginpage(context) {
  Navigator.pop(context);
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => const SignInScreen(),
    ),
    (Route<dynamic> route) => false,
  );
}

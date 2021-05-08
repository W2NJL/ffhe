import 'package:fast_food_health_e/screens/Login/rounded_button.dart';
import 'package:fast_food_health_e/screens/Login/rounded_input_field.dart';
import 'package:fast_food_health_e/screens/Login/rounded_password_field.dart';
import 'package:fast_food_health_e/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'already_have_an_account_acheck.dart';
import 'background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_health_e/screens/resetpw_screen.dart';
import 'package:fast_food_health_e/state/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String _email, _password;
    final auth = FirebaseAuth.instance;
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                                _email = value.trim();
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                _password = value.trim();
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                _signIn(_email, _password, context);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );



  }
}

_signIn(String _email, String _password, BuildContext context) async {
  String test = await context.read<AuthenticationProvider>().signIn(
    email: _email,
    password: _password,


  );

  if (test == "Signed in!") {
    Navigator.pushReplacementNamed(context, '/home');
  }

  else {
    Fluttertoast.showToast(msg: test,
      toastLength: Toast.LENGTH_LONG,

      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,);
  }
}

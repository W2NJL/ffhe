import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_health_e/screens/verify_email.dart';
import 'package:fast_food_health_e/state/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/constants.dart';
import 'package:fast_food_health_e/widgets/shared_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';

import 'Login/background.dart';
import 'Login/rounded_button.dart';
import 'Login/rounded_input_field.dart';
import 'Login/rounded_password_field.dart';



class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;
  static final now = DateTime.now();





  @override
  Widget build(BuildContext context) {








    final auth = FirebaseAuth.instance;
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset("images\/" + "ffhe_logo.PNG",



            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {

                setState(() {
                  _email = value.trim();
                });

              },
            ),

            RoundedPasswordField(

              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });

              },
            ),


            RoundedButton(
              text: "SIGN UP",
              press: () {

                  _signUp(_email, _password);
                }



            ),




          ],
        ),
      ),
    );



  }

  _signUp(String _email, String _password) async {

    String test = await context.read<AuthenticationProvider>().signUp(
      email: _email,
      password: _password,



    );

    if (test == "Signed up!"){


      _activateFirstRun();
      Navigator.pushReplacementNamed(context, 'BMIScreen');
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

  void _activateFirstRun() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();



      preferences.setBool("FirstRun", true);
    }

  getAgeRange() {

    int j = 0;
    var ageRange = <int>[];
    for (int i=18; i<=100; i++){
      ageRange.add(i);
      j++;
    }

    return ageRange;
  }






  }






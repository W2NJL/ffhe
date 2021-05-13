import 'package:fast_food_health_e/fitness_app/fitness_app_home_screen.dart';
import 'package:fast_food_health_e/screens/launch_screen.dart';
import 'package:fast_food_health_e/screens/newdiet_screen.dart';
import 'package:fast_food_health_e/utils/firebaseFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool firstRun = false;

  _AuthenticateState() {
    FirebaseFunctions joe = new FirebaseFunctions();

    joe.getFirstRun().then((value) =>
        setState(() {
          if(value !=null) {
            firstRun = value;
          }
          print("Bool is: " + value.toString());
        }));
  }



  @override
  Widget build(BuildContext context) {
    //Instance to know the authentication state.
    final firebaseUser = context.watch<User>();
    final referenceDatabase = FirebaseDatabase.instance;






    if (firebaseUser != null) {
      if (!firstRun) {
        return FitnessAppHomeScreen();
      }
    }
    return LaunchScreen();
    }




  }

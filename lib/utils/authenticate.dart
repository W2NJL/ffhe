import 'package:fast_food_health_e/fitness_app/fitness_app_home_screen.dart';
import 'package:fast_food_health_e/screens/launch_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Instance to know the authentication state.
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      print("Nick you are fucking genius");
      //Means that the user is logged in already and hence navigate to HomePage
      return FitnessAppHomeScreen();
    }
    //The user isn't logged in and hence navigate to SignInPage.
    return LaunchScreen();
  }
}
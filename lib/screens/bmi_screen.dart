import 'dart:math';

import 'package:fast_food_health_e/screens/verify_email.dart';
import 'package:fast_food_health_e/state/authentication.dart';
import 'package:fast_food_health_e/utils/firebaseFunctions.dart';
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



class BMIScreen extends StatefulWidget {
  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;
  static final now = DateTime.now();
  var firebaseUser;
  String userID;
  final referenceDatabase = FirebaseDatabase.instance;
  FirebaseFunctions firebaseFunctions = new FirebaseFunctions();

  @override
  void didChangeDependencies() {

    // or else you end up creating multiple instances in this case.


    firebaseUser = context.watch<User>();
    userID  = firebaseUser.uid;




    super.didChangeDependencies();



  }


  final dropdownDatePicker = DropdownDatePicker(
    firstDate: ValidDate(year: now.year - 100, month: 1, day: 1),
    lastDate: ValidDate(year: now.year, month: now.month, day: now.day),
    textStyle: TextStyle(fontWeight: FontWeight.bold),
    dropdownColor: Colors.blue[200],
    dateHint: DateHint(year: 'year', month: 'month', day: 'day'),
    ascending: false,
  );



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
            Image.asset("images\/" + "FastFoodHealthELogo_Slogan.png",



            ),
            SizedBox(height: size.height * 0.03),

            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[ Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(

                    "Select your date of birth: ",
                    style: TextStyle(fontWeight: FontWeight.bold),

                  ),
                ),dropdownDatePicker,


                ]),

            RoundedButton(
                text: "SIGN UP",
                press: () {

                  sendDate(dropdownDatePicker.getDate());

                  if(dropdownDatePicker.getDate().toString().contains('null')){
    Fluttertoast.showToast(msg: 'Please enter a valid date of birth',
    toastLength: Toast.LENGTH_LONG,

    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 16.0,);
    }

                  else {
                    Navigator.pushReplacementNamed(context, 'DietScreen');
                  }
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

      sendDate(dropdownDatePicker.getDate());
      firebaseFunctions.activateFirstRun(true);
      Navigator.pushReplacementNamed(context, 'DietScreen');
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

  void sendDate(String date) {
    final ref = referenceDatabase.reference().child(userID);




    ref.child('DOB').set(date);
  }




}






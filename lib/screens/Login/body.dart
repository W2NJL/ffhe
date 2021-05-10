import 'package:fast_food_health_e/screens/Login/rounded_button.dart';
import 'package:fast_food_health_e/screens/Login/rounded_input_field.dart';
import 'package:fast_food_health_e/screens/Login/rounded_password_field.dart';
import 'package:fast_food_health_e/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../constants.dart';
import 'already_have_an_account_acheck.dart';
import 'background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_health_e/screens/resetpw_screen.dart';
import 'package:fast_food_health_e/state/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loaded = false;
  bool value = false;
  bool sharedPrefValue = false;
  String _email, _password;
  List<String> credentialsFromShared = <String>[];

  _BodyState(){
    _getRememberPref().then((value) =>setState(() {



        this.value = value;
        print("Bool is: " + value.toString());

    }));


   _getRememberMe().then((value) => setState(() {
     credentialsFromShared = value;



     if(credentialsFromShared.elementAt(0) != null && credentialsFromShared.elementAt(1) != null) {

       if (credentialsFromShared.elementAt(0) == "none"){

         _email = null;
       }
       else{
         _email = credentialsFromShared.elementAt(0);
       }


       if (credentialsFromShared.elementAt(1) == "none"){
         _password = null;
       }
       else{
         _password = credentialsFromShared.elementAt(1);
       }
     }

     loaded = true;
    }));}





  @override
  Widget build(BuildContext context) {






    final auth = FirebaseAuth.instance;
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: !loaded? CircularProgressIndicator(): Column(
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
              initialValue: _email != null? _email: "",
              onChanged: (value) {

                setState(() {
                  _email = value.trim();
                });

              },
            ),
            RoundedPasswordField(
              initialValue: _password != null? _password: "",
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });

              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {

                print("Value is: " + value.toString());
                if(value) {
                  _storeRememberMePref(_email, _password, value);
                  _signIn(_email, _password, context);
                }
                else
                {
                  _storeRememberMePref(null, null, value);
                  _signIn(_email, _password, context);
                }


              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Remember Me',
                  style: TextStyle(color: kPrimaryColor),
                ), //Text
                SizedBox(width: 10), //SizedBox
                /** Checkbox Widget **/
                Checkbox(
                  value: value,
                  onChanged: (bool value) {
                    setState(() {
                      this.value = value;

                    });
                  },
                ), //Checkbox
              ], //<Widget>[]
            ), //Row,
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.pushNamed(context, 'SignUpScreen');
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

Future <bool> _getRememberPref() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();


  if(preferences.getBool("Remember") !=null) {
    return preferences.getBool("Remember");
  }
  else {
    return false;
  }

}

Future <List<String>> _getRememberMe() async {
  List<String> list = <String>[];

  SharedPreferences preferences = await SharedPreferences.getInstance();
  list.add(preferences.getString("Email"));
  list.add(preferences.getString("Password"));

  return list;
}

void _storeRememberMePref(String _email, String _password, bool remember) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  if(remember) {
    preferences.setString("Email", _email);
    preferences.setString("Password", _password);
    preferences.setBool("Remember", true);
  }

  else
    {


      preferences.setString("Email", "none");
      preferences.setString("Password", "none");
      preferences.setBool("Remember", false);

    }



}
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_health_e/screens/resetpw_screen.dart';
import 'package:fast_food_health_e/state/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/constants.dart';
import 'package:fast_food_health_e/widgets/shared_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class OldLoginScreen extends StatefulWidget {
  @override
  _OldLoginScreenState createState() => _OldLoginScreenState();
}

class _OldLoginScreenState extends State<OldLoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override








  Widget build(BuildContext context) {




    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,


      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text('Welcome To Fast Food Health-E')),
        body: Card(
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email'
                      ),
                      onChanged: (value){
                        setState(() {
                          _email = value.trim();
                        });
                      }
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password'
                        ),
                        onChanged: (value){
                          setState(() {
                            _password = value.trim();
                          });
                        })
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      TextButton(

                          child: Text('Sign in'),
                          onPressed: () => _signIn(_email, _password),

                          ),
                      TextButton(
                          
                          child: Text('Forgot Password?'),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetScreen()));
                          })
                    ])
              ]
          ),
        ),
      ),

    );

  }
  _signIn(String _email, String _password) async{

      String test = await context.read<AuthenticationProvider>().signIn(
        email: _email,
        password: _password,


      );

      if (test == "Signed in!"){
        Navigator.pushReplacementNamed(context, '/');
      }

      else {
        Fluttertoast.showToast(msg: test,
          toastLength: Toast.LENGTH_LONG,

          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,);
      }

}}




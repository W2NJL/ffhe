import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/constants.dart';
import 'package:fast_food_health_e/widgets/shared_widgets.dart';
import 'package:provider/provider.dart';



class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override








  Widget build(BuildContext context) {




    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,


      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text('Create Your Fast Food Health-E Account')),
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

                      RaisedButton(
                          color: Theme.of(context).accentColor,
                          child: Text('Create Account'),
                          onPressed: (){
                            auth.createUserWithEmailAndPassword(email: _email, password: _password);
                            Navigator.pushReplacementNamed(context, '/home');
                          }),

                    ])
              ]
          ),
        ),
      ),

    );

  }
}




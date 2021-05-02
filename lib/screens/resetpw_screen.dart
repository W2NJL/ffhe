import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/constants.dart';
import 'package:fast_food_health_e/widgets/shared_widgets.dart';
import 'package:provider/provider.dart';


class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String _email;
  final auth = FirebaseAuth.instance;

  @override








  Widget build(BuildContext context) {




    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,


      child: Scaffold(

        appBar: AppBar(title: Text('Reset Password')),
        body: Column(
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


                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      TextButton(

                          child: Text('Send Request'),
                          onPressed: (){
                            auth.sendPasswordResetEmail(email: _email);
                            Navigator.of(context).pop();


                          }),

                    ])
              ]
          ),
        ),


    );

  }
}







import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';




  Future <int> _brunoMars() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    int result;
    int maxValue;

    final referenceDatabase3 = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('DietVals')
        .child('Calories')
        .child('MaxValue')
        .once()
        .then((snapshot) {
      maxValue = snapshot.value;
    });


    return maxValue;
  }

  Future <int> _getRemainingCalories() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    int result;

    final referenceDatabase2 = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('DietVals')
        .child(formattedDate)
        .child('Calories')
        .once()
        .then((snapshot) {
      result = snapshot.value;
    });

    return result;
  }

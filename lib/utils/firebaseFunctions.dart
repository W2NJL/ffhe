import 'package:fast_food_health_e/models/fastFoodHealthE.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class FirebaseFunctions {

  SharedPreferences preferences;





  Future <List<int>> getTotalNutrients(String diet) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate;
    formattedDate = formatter.format(now);
    List<String> dietList = <String>[];
    dietList.add("Calories");
    dietList.add("Low Carb");
    dietList.add("Sodium");
    dietList.add("Low Cholesterol");
    dietList.add("Low Fat");
    dietList.add("Saturated Fat");
    List<int> nutritionList = <int>[];


    for (int i = 0; i < dietList.length; i++) {
      int result;
      int maxValue;

      final referenceDatabase3 = await FirebaseDatabase.instance
          .reference()
          .child('User')
          .child('DietVals')
          .child(dietList.elementAt(i))
          .child('MaxValue')
          .once()
          .then((snapshot) {
        maxValue = snapshot.value;
      });

      if (maxValue == null) {
        nutritionList.add(999999999);
      }
      else {
        nutritionList.add(maxValue);
      }
    }

    return nutritionList;
  }

  Future <bool> getFirstRun() async {


    preferences = await SharedPreferences.getInstance();


    return preferences.getBool("FirstRun");
  }

  void activateFirstRun() async {

    preferences = await SharedPreferences.getInstance();


    preferences.setBool("FirstRun", false);
  }

  getDietPlan(FastFoodHealthEUser user)  {


    List<String> resultList = <String>[];
    resultList.add(user.caloriePlan);
    resultList.add(user.carbPlan);
    resultList.add(user.sodiumPlan);
    resultList.add(user.fatPlan);
    resultList.add(user.cholesterolPlan);







    return analyzeResult(resultList);
  }



  String analyzeResult(List<String> result){
    String returnValue;
    returnValue = result.elementAt(0);

    Iterator<String> listIterator = result.iterator;

    listIterator.moveNext();

    while(listIterator.moveNext()) {
      String now = listIterator.current;
      if(!now.contains("No")) {
        returnValue += "\n" + listIterator.current;
      }

    }





    return returnValue;


  }



}
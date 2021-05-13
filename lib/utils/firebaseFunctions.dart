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

  Future <String> getDietPlan(BuildContext context, String userID) async {



    String result;
    String result2;
    String result3;
    String result4;
    String result5;
    List<String> resultList = <String>[];
    final referenceDatabase = await FirebaseDatabase.instance
        .reference()
        .child(userID)
        .child('DietPlan')
        .once()
        .then((snapshot){resultList.add(snapshot.value);});


    final referenceDatabase2 = await FirebaseDatabase.instance
        .reference()
        .child(userID)
        .child('Low Carb')
        .once()
        .then((snapshot){resultList.add(snapshot.value);});
    //
    // if(result2 == 'No Carb Plan'){
    //   result2 == ''
    // }


    final referenceDatabase3 = await FirebaseDatabase.instance
        .reference()
        .child(userID)
        .child('Sodium')
        .once()
        .then((snapshot){resultList.add(snapshot.value);});


    final referenceDatabase4 = await FirebaseDatabase.instance
        .reference()
        .child(userID)
        .child('Low Fat')
        .once()
        .then((snapshot){resultList.add(snapshot.value);});
    print(result);

    final referenceDatabase5 = await FirebaseDatabase.instance
        .reference()
        .child(userID)
        .child('Low Cholesterol')
        .once()
        .then((snapshot){resultList.add(snapshot.value);});
    print(result);







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
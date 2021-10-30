import 'package:fast_food_health_e/models/fastFoodHealthE.dart';
import 'package:fast_food_health_e/state/FastFoodHealthEState.dart';
import 'package:fast_food_health_e/utils/helperFunctions.dart';
import 'package:fast_food_health_e/widgets/favoritesList.dart';
import 'package:fast_food_health_e/widgets/new_nutritionixList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class FirebaseFunctions {

  SharedPreferences preferences;
  var now = new DateTime.now();
  String formattedDate;
  var formatter = new DateFormat('yyyy-MM-dd');
  HelperFunctions helperFunctions = new HelperFunctions();



  Future <int> getRemainingNutrients(String diet, FastFoodHealthEUser fastFoodHealthEUser) async {

    if (diet == "Calories"){


      return fastFoodHealthEUser.todaysCal;

    }

    if (diet == "Sodium"){


      return fastFoodHealthEUser.todaysSodium;

    }

    if (diet == "Low Fat"){


      return fastFoodHealthEUser.todaysFat;

    }

    if (diet == "Low Carb"){


      return fastFoodHealthEUser.todaysCarbs;

    }

    if (diet == "Low Cholesterol"){


      return fastFoodHealthEUser.todaysCholesterol;

    }

    if (diet == "Saturated Fat"){


      return fastFoodHealthEUser.todaysSaturatedFat;

    }

    if (diet == "Saturated Fat"){


      return fastFoodHealthEUser.todaysTransFat;

    }

    return null;

  }

  getRestaurantIcon(String restaurant) {




    return "https://logo.clearbit.com/" + helperFunctions.fixName(restaurant) + ".com";


    if(restaurant.contains("Bob"))
    {
      return "images/" + "bob_evans.png";
    }
    else if (restaurant.contains("Apple")){
      return "images/" + "applebees.png";
    }
    else if (restaurant.contains("King")){
      return "images/" + "bk.jpg";
    }
    else if (restaurant.contains("Chick")){
      return "images/" + "chick-fil-a.gif";
    }
    else if (restaurant.contains("Donald")){
      return "images/" + "mcdonalds.png";
    }
    else if (restaurant.contains("Olive")){
      return "images/" + "og.jpg";
    }
    else if (restaurant.contains("Chang")){
      return "images/" + "pfchangs.jpg";
    }
    else if (restaurant.contains("Panera")){
      return "images/" +"panera.jpg";
    }
    else if (restaurant.contains("Royal")){
      return "images/" +"royal_farms.jpg";
    }
    else if (restaurant.contains("Smash")){
      return "images/" +"smash.png";
    }
    else if (restaurant.contains("Taco")){
      return "images/" +"taco.png";
    }
    else if (restaurant.contains("Wawa")){
      return"images/" +"wawa.jpg";
    }



  }

  Future <List<int>> getTotalNutrients(String diet, String userID) async {
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
          .child(userID)
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

  getDietPlanHeader(FastFoodHealthEUser user)  {


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

  Future <String> getDietPlan(String diet, FastFoodHealthEUser fastFoodHealthEUser) async {



      if (diet == "Calories"){


        return fastFoodHealthEUser.caloriePlan;

      }

      if (diet == "Sodium"){


        return fastFoodHealthEUser.sodiumPlan;

      }

      if (diet == "Low Fat"){


        return fastFoodHealthEUser.fatPlan;

      }

      if (diet == "Low Carb"){


        return fastFoodHealthEUser.carbPlan;

      }

      if (diet == "Low Cholesterol"){


        return fastFoodHealthEUser.cholesterolPlan;

      }



      return null;

    }

  bool percentageOf(int value, int totalCalories) {

    if (value/totalCalories >= 0.3) {
      return false;
    }
    return true;

  }

   checkPercentageOfDay(String title, ref, FastFoodHealthEUser fastFoodHealthEUser, context) {
    if (percentageOf(fastFoodHealthEUser.favsList[title]['Calories'], fastFoodHealthEUser.todaysCal)){
      return true;
    }

    else
    {
      _showDialog(title, ref, fastFoodHealthEUser, context);
      return false;

    }


  }

  void addToMyDay(String title, DatabaseReference ref, FastFoodHealthEUser fastFoodHealthEUser, BuildContext context) {

    formattedDate = formatter.format(now);

    Provider.of<FastFoodHealthEState>(context, listen: false).clearState();


    ref.child('DietVals').child(formattedDate).child('Calories').set(
        ServerValue.increment(fastFoodHealthEUser.favsList[title]['Calories']));
    ref.child('DietVals').child(formattedDate).child('Sodium').set(
        ServerValue.increment(fastFoodHealthEUser.favsList[title]['Sodium']));
    ref.child('DietVals').child(formattedDate).child('Low Carb').set(
        ServerValue.increment(fastFoodHealthEUser.favsList[title]['Low Carb']));
    ref.child('DietVals').child(formattedDate).child('Low Fat').set(
        ServerValue.increment(fastFoodHealthEUser.favsList[title]['Low Fat']));
    ref.child('DietVals').child(formattedDate).child(
        'Low Cholesterol').set(
        ServerValue.increment(fastFoodHealthEUser.favsList[title]['Low Cholesterol']));
    ref.child('DietVals').child(formattedDate)
        .child('Saturated Fat')
        .set(ServerValue.increment(fastFoodHealthEUser.favsList[title]['Saturated Fat']));
    ref.child('DietVals').child(formattedDate).child('Trans Fat').set(
        ServerValue.increment(fastFoodHealthEUser.favsList[title]['Trans Fat']));
    ref.child('DietVals').child(formattedDate).child('Meals').child(
        title).child('calories').set(
        ServerValue.increment(fastFoodHealthEUser.favsList[title]['Calories']));
    ref.child('DietVals').child(formattedDate).child('Meals').child(
        title).child('sodium').set(
        ServerValue.increment(fastFoodHealthEUser.favsList[title]['Sodium']));
    ref.child('DietVals').child(formattedDate).child('Meals').child(
        title).child('carbs').set(
        ServerValue.increment(fastFoodHealthEUser.favsList[title]['Low Carb']));
    ref.child('DietVals').child(formattedDate).child('Meals').child(
        title).child('fat').set(
        ServerValue.increment(fastFoodHealthEUser.favsList[title]['Low Fat']));
    ref.child('DietVals').child(formattedDate).child('Meals').child(
        title).child('cholesterol').set(
        ServerValue.increment(fastFoodHealthEUser.favsList[title]['Low Cholesterol']));
    ref.child('DietVals').child(formattedDate).child('Meals').child(
        title).child('Saturated Fat').set(
        ServerValue.increment(fastFoodHealthEUser.favsList[title]['Saturated Fat']));
    ref.child('DietVals').child(formattedDate).child('Meals').child(
        title).child('Trans Fat').set(
        ServerValue.increment((fastFoodHealthEUser.favsList[title]['Trans Fat'])));
    ref.child('DietVals').child(formattedDate).child('Meals').child(
        title).child('Restaurant').set(
        fastFoodHealthEUser.favsList[title]['Restaurant']);


    Provider.of<FastFoodHealthEState>(context, listen: false).loadUserList(context);




  }

  void _showDialog(String title, DatabaseReference ref, FastFoodHealthEUser fastFoodHealthEUser, BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Large meal alert"),
          content: new Text("This meal item will consume more than 30% of your recommended daily calorie intake!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Continue anyway"),
              onPressed: () {

                addToMyDay(title, ref, fastFoodHealthEUser, context);

                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritesList(),
                    ),

                  );
                });
              },
            ),
            new FlatButton(
              child: new Text("Don't add"),
              onPressed: () {
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              },
            ),
          ],
        );
      },
    );
  }





}
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:fast_food_health_e/fitness_app/fintness_app_theme.dart';
import 'package:fast_food_health_e/utils/firebaseFunctions.dart';
import 'package:fast_food_health_e/utils/metanutrient.dart';
import 'package:fast_food_health_e/utils/nutrientLabel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fast_food_health_e/services/FirebaseCalls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appbar.dart';

class NewNutritionixList extends StatefulWidget {
  final String restaurant;
  final String mealCategory;

  NewNutritionixList({this.restaurant, this.mealCategory});

  @override
  State<StatefulWidget> createState() => new NewNutritionixListState(restaurant: restaurant, category: mealCategory);
}

class NewNutritionixListState extends State<NewNutritionixList> {
  final String restaurant;
  final String category;
   static int page = 0;
  static int totalCalories;
  static int remainingCalories;
  static int calorieSum;
  static int totalSodium;
  static int totalSatFat;
  static int totalTransFat;
  static int remainingSodium;
  static int remainingSatFat;
  static int totalCarbs;
  static int remainingCarbs;
  static int remainingTransFat;
  static int sodiumSum;
  static int carbSum;
  static int fatSum;
  static int totalFat;
  static int remainingFat;
  static int totalCholesterol;
  static int remainingCholesterol;
  static int cholesterolSum;
  static int satFatSum;
  static int transFatSum;
  static int mealNum = 1;
  static int itemCount;
  static String formattedDate;
  bool done = false;
  bool passThrough = false;
  bool allDone = false;



  bool listingLimit;
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');





  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  List users = new List();
  final dio = new Dio();
  List<int> nutrientList = <int>[];
  final noNutrientLimit = 999999999;




  NewNutritionixListState({this.restaurant, this.category}){
    // _getTotalCalories().then((value) => setState(() {
    //
    //   totalCalories = value;
    // }));

    }


  Future <int> _getRemainingNutrients(String diet) async {

    String formattedDate = formatter.format(now);

    int result;

    final referenceDatabase2 = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('DietVals')
        .child(formattedDate)
        .child(diet)
        .once()
        .then((snapshot) {
      result = snapshot.value;
    });

    return result;
  }

  String imgLink(String restaurant){


    if(restaurant.contains("Apple")){
    return 'applebees.png';
    }
    else if(restaurant.contains("Bob Evans")) {
      return
        'bob_evans.png';
    }
    else if(restaurant.contains("Burger King")){

        return 'bk.jpg';
    }
    else if(restaurant.contains('Chick-Fil-A')){

        return 'chick-fil-a.gif';
    }
    else if(restaurant.contains('McDonald\'s')){

        return
        'mcdonalds.png';
    }
    else if(restaurant.contains('Olive Garden')){

        return 'og.jpg';
    }
    else if(restaurant.contains('P.F. Chang\'s')){

        return
        'pfchangs.jpg';
    }
    else if(restaurant.contains('Panera Bread')){

        return
        'panera.jpg';
    }
    else if(restaurant.contains('Royal Farms')){

        return
        'royal_farms.jpg';
    }
    else if(restaurant.contains('SmashBurger')){

        return
        'smash.png';
    }
    else if(restaurant.contains('Taco Bell')){

        return
        'taco.png';
    }
    else if(restaurant.contains('Wawa')){

        return
        'wawa.jpg';}}

  Future <int> _getTotalNutrients(String diet) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
   formattedDate = formatter.format(now);

    int result;
    int maxValue;

    final referenceDatabase3 = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('DietVals')
        .child(diet)
        .child('MaxValue')
        .once()
        .then((snapshot) {
      maxValue = snapshot.value;
    });

    if (maxValue == null)
      {

        return noNutrientLimit;
      }


    return maxValue;
  }


  @override
  void initState() {
    page = 0;
    String formattedDate = formatter.format(now);
    this._getMoreData(page, this.restaurant, this.category);
    super.initState();





    _sc.addListener(() {
      if (_sc.position.pixels ==
          _sc.position.maxScrollExtent) {
        _getMoreData(page, this.restaurant, this.category);
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        route: 'RestaurantScreen',
        context: context,
        title:  Text(restaurant),
      ),

      body: Column(children:
          [
            Container(
              child: _showDietValues(),
            ),
            Container(
              child: _buildList(),
            ),
          ]

      ),
      resizeToAvoidBottomInset: false,
    );
  }


  Widget _showDietValues(){
    if (done){
    return Container(

          color: Colors.green,
      child: Column(

          children:[
            Row(
              children:[
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
                ),
                Text(
                  "Calories:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    letterSpacing: -0.2,
                    color: Colors.deepPurple,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
                ),
                Text(
                  remainingCalories.toString(),
      textAlign: TextAlign.left,
      style: TextStyle(
      fontFamily: FitnessAppTheme.fontName,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      letterSpacing: -0.2,
      color: remainingCalories > totalCalories?  Colors.red[500]: Colors.black,
      ),
      ),
                Text(
                  " of ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    letterSpacing: -0.2,
                    color: Colors.black,
                  ),
                ),
                Text(
                  totalCalories.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: -0.2,
                    color: Colors.black,
                  ),
                ),
                Text(
                  " kCal",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    letterSpacing: -0.2,
                    color: Colors.black,
                  ),
                ),
              ]
        ),
            totalCholesterol != noNutrientLimit? Row( children:[
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
              ),
              Text(
                "Cholesterol:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.green[900],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
              ),
              Text(
                remainingCholesterol.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: remainingCholesterol > totalCholesterol?  Colors.red[500]: Colors.black,
                ),
              ),
              Text(
                " of ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.black,
                ),
              ),
              Text(
                totalCholesterol.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.black,
                ),
              ),
              Text(
                " mg",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.black,
                ),
              ),
            ]):SizedBox(height: 0),
            totalSodium != noNutrientLimit? Row( children:[
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
              ),
              Text(
                "Sodium:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.blue[900],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
              ),
              Text(
                remainingSodium.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: remainingSodium > totalSodium?  Colors.red[500]: Colors.black,
                ),
              ),
              Text(
                " of ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.black,
                ),
              ),
              Text(
                totalSodium.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.black,
                ),
              ),
              Text(
                " mg",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.black,
                ),
              ),
            ]):SizedBox(height: 0),
            totalCarbs != noNutrientLimit? Row( children:[
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
              ),
              Text(
                "Total Carbs:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.blue[900],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
              ),
              Text(
                remainingCarbs.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: remainingCarbs > totalCarbs?  Colors.red[500]: Colors.black,
                ),
              ),
              Text(
                " of ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.black,
                ),
              ),
              Text(
                totalCarbs.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.black,
                ),
              ),
              Text(
                " g",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.black,
                ),
              ),
            ]):SizedBox(height: 0),
            totalFat != noNutrientLimit? Row( children:[
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
              ),
              Text(
                "Total Fat:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.blue[900],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
              ),
              Text(
                remainingFat.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: remainingFat > totalFat?  Colors.red[500]: Colors.black,
                ),
              ),
              Text(
                " of ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.black,
                ),
              ),
              Text(
                totalFat.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.black,
                ),
              ),
              Text(
                " mg",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.black,
                ),
              ),
            ]):SizedBox(height: 0),
          ])
    );



  }
    else
      return SizedBox(height: 0);
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

  


  Widget _buildList() {



    if(!allDone)
      return Center(child: CircularProgressIndicator());

    else {
      return Expanded(

          child: users.length > 0? ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: users.length + 1,
            // Add one more item for progress indicator
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemBuilder: (BuildContext context, int index) {
              if (index == users.length) {
                return _buildProgressIndicator();
              } else {
                return GestureDetector(
                  onTap: () {
                    showDialog(

                      context: context,
                      builder: (BuildContext context) =>
                          _buildAboutDialog(context, users[index]),
                    );
                  },
                  child: ListTile(
                    leading: ClipOval(

                      child: Image.asset("images\/" + imgLink(restaurant),
                        width: 80,
                        height: 160,
                        fit: BoxFit.fill,),

                    ),


                    title: Text((users[index]['item_name'])),
                    subtitle: Text(
                        (users[index]['nf_calories'].toString()) +
                            ' calories'),
                  ),
                );
              }},

            controller: _sc,
          ):Column(
            children: [Container(
              margin: EdgeInsets.only(top: 150, right: 10, left: 10, bottom: 15),
              child: Center(child: RichText(

                text: TextSpan(

                  style: TextStyle(color: Colors.black, fontSize: 36),
                  children: <TextSpan>[
                    TextSpan(text: 'No meals available! ', style: TextStyle(color: Colors.blue)),

                  ],
                ),
              ),

              ),
            ),
              Container(
                margin: EdgeInsets.only(top: 2, right: 20, left: 20, bottom: 15),
                child: Center(child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(text: 'Please change your diet plan or turn off listing limits to see meal items.', style: TextStyle(color: Colors.black)),

                    ],
                  ),
                ),

                ),
              )],
          ),
      );
    }
    }


 Widget _buildAboutDialog(BuildContext context, user) {
    final referenceDatabase = FirebaseDatabase.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user2 = auth.currentUser;
    final uid = user2.uid;
    final ref = referenceDatabase.reference().child(uid);
    final List<int> nutrientList = <int>[];
    Map<String, dynamic> nutrientMap = Map<String, dynamic>.from(user);
    print(nutrientMap.remove('item_name'));
    nutrientMap.remove('brand_name');

    nutrientList.add(totalCalories);
    nutrientList.add(totalCarbs);
    nutrientList.add(totalSodium);
    nutrientList.add(totalCholesterol);
    nutrientList.add(totalFat);
    nutrientList.add(totalSatFat);

    print(user.runtimeType);


    return new AlertDialog(
      title: Text(user['item_name']),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          NutrientLabel(nutrientMap, nutrientList),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {

            checkPercentageOfDay(ref, user);

            if(passThrough) {
              addToMyDay(ref, user);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NewNutritionixList(
                      restaurant: restaurant, mealCategory: category),
                ),
              );
            }
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Add to My Day'),
        ),
      ],
    );
  }

 void addToMyDay(DatabaseReference ref, user) {
    ref.child('DietVals').child(formattedDate).child('Calories').set(
       ServerValue.increment(user['nf_calories']));
   ref.child('DietVals').child(formattedDate).child('Sodium').set(
       ServerValue.increment(user['nf_sodium']));
   ref.child('DietVals').child(formattedDate).child('Low Carb').set(
       ServerValue.increment(user['nf_total_carbohydrate']));
   ref.child('DietVals').child(formattedDate).child('Low Fat').set(
       ServerValue.increment(user['nf_total_fat'].toInt()));
   ref.child('DietVals').child(formattedDate).child(
       'Low Cholesterol').set(
       ServerValue.increment(user['nf_cholesterol']));
   ref.child('DietVals').child(formattedDate)
       .child('Saturated Fat')
       .set(ServerValue.increment(user['nf_saturated_fat'].toInt()));
   ref.child('DietVals').child(formattedDate).child('Trans Fat').set(
       ServerValue.increment(user['nf_trans_fatty_acid'].toInt()));
   ref.child('DietVals').child(formattedDate).child('Meals').child(
       user['item_name']).child('calories').set(
       ServerValue.increment(user['nf_calories']));
   ref.child('DietVals').child(formattedDate).child('Meals').child(
       user['item_name']).child('sodium').set(
       ServerValue.increment(user['nf_sodium']));
   ref.child('DietVals').child(formattedDate).child('Meals').child(
       user['item_name']).child('carbs').set(
       ServerValue.increment(user['nf_total_carbohydrate']));
   ref.child('DietVals').child(formattedDate).child('Meals').child(
       user['item_name']).child('fat').set(
       ServerValue.increment(user['nf_total_fat'].toInt()));
   ref.child('DietVals').child(formattedDate).child('Meals').child(
       user['item_name']).child('cholesterol').set(
       ServerValue.increment(user['nf_cholesterol']));
   ref.child('DietVals').child(formattedDate).child('Meals').child(
       user['item_name']).child('Saturated Fat').set(
       ServerValue.increment(user['nf_saturated_fat'].toInt()));
   ref.child('DietVals').child(formattedDate).child('Meals').child(
       user['item_name']).child('Trans Fat').set(
       ServerValue.increment(user['nf_trans_fatty_acid'].toInt()));
   ref.child('DietVals').child(formattedDate).child('Meals').child(
       user['item_name']).child('Restaurant').set(
       user['brand_name']);
 }



  void _getMoreData(int index, String restaurant, String category) async {
    int totalCalories2;
    var params;
        if (!isLoading) {

      setState(() {
        isLoading = true;

      });

      FirebaseFunctions joe = new FirebaseFunctions();

      await joe.getTotalNutrients('Calories').then((value) => setState(() {

        nutrientList = value;


      }));

      await _getLimitPref().then((value) => setState(() {

        listingLimit = value;


      }));

    await _getTotalNutrients('Calories').then((value) => setState(() {

      totalCalories = value;

      print("Totalcalroies is " + totalCalories.toString());
    }));

      await _getTotalNutrients('Sodium').then((value) => setState(() {

        totalSodium = value;


      }));

      await _getTotalNutrients('Low Carb').then((value) => setState(() {

        totalCarbs = value;


      }));

      await _getTotalNutrients('Low Fat').then((value) => setState(() {

        totalFat = value;

        print("Totalcalroies is " + totalFat.toString());
      }));

      await _getTotalNutrients('Low Cholesterol').then((value) => setState(() {

        totalCholesterol = value;

        print("Total cholesterol is " + totalCholesterol.toString());
      }));

      await _getTotalNutrients('Saturated Fat').then((value) => setState(() {

        totalSatFat = value;


      }));

      await _getTotalNutrients('Trans Fat').then((value) => setState(() {

        totalTransFat = value;


      }));

    await _getRemainingNutrients('Calories').then((value) => setState((){
      remainingCalories = value;

      if (remainingCalories == null)
        {
          calorieSum = totalCalories;
          remainingCalories = 0;
        }
      else{
        calorieSum = totalCalories-remainingCalories;
      }


      print("recalroies is " + remainingCalories.toString());

    }));

      await _getRemainingNutrients('Sodium').then((value) => setState((){
        remainingSodium = value;

        if (remainingSodium == null)
        {
          sodiumSum = totalSodium;
          remainingSodium = 0;
        }
        else{
          sodiumSum = totalSodium-remainingSodium;
        }}));

      await _getRemainingNutrients('Saturated Fat').then((value) => setState((){
        remainingSatFat = value;

        if (remainingSatFat == null)
        {
          satFatSum = totalSatFat;
          remainingSatFat = 0;
        }
        else{
          satFatSum = totalSatFat-remainingSatFat;
        }



      }));

      await _getRemainingNutrients('Low Cholesterol').then((value) => setState((){
        remainingCholesterol = value;

        if (remainingCholesterol == null)
        {
          cholesterolSum = totalCholesterol;
          remainingCholesterol = 0;
        }
        else{
          cholesterolSum = totalCholesterol-remainingCholesterol;
        }}));

      await _getRemainingNutrients('Low Fat').then((value) => setState(() {
        remainingFat = value;

        if (remainingFat == null) {
          fatSum = totalFat;
        }
        else {
          fatSum = totalFat - remainingFat;
          remainingFat = 0;
        }

        print("FatSum is: " + fatSum.toString());
      }));
      await _getRemainingNutrients('Trans Fat').then((value) => setState(() {
        remainingTransFat = value;

        if (remainingTransFat == null) {
          transFatSum = totalTransFat;
          remainingTransFat = 0;
        }
        else {
          transFatSum = totalTransFat - remainingTransFat;
        }


      }));



      await _getRemainingNutrients('Low Carb').then((value) => setState(() {
        remainingCarbs = value;

        if (remainingCarbs == null) {
          carbSum = totalCarbs;
          remainingCarbs = 0;
          done = true;
        }
        else {
          carbSum = totalCarbs - remainingCarbs;
          done = true;
        }

        print("CarbSum is: " + carbSum.toString());


        }));

      List tList = new List();
      var url = 'https://api.nutritionix.com/v1_1/search';


      try {
        params = generateParams(params, restaurant);
        Response<dynamic> response = await responseCall(url, params);

        while (tList.length < 10 && response.data['hits']?.isEmpty == false) {



          //var url = 'https://api.nutritionix.com/v1_1/search/' + restaurant + '?results='+ index.toString() + ':' + (index+50).toString() + '&fields=item_name,brand_name,nf_calories,nf_sodium,nf_sugars,nf_cholesterol,nf_total_fat,nf_dietary_fiber&appId=816cee15&appKey=aab0a0a4c4224eca770bf5a2a0f4c984';
          //print(url);


          List<String> foodList = <String>[];

          int orig = tList.length;
          print("Response is: " + response.data['hits'].toString());


          for (int i = 0; i < response.data['hits'].length; i++) {
            addFoodtoTList(response, i, category, foodList, tList);
            print("Length of list is: " + tList.length.toString());

          }




          setState(() {
            page += 50;
          });

           if(tList.length < 10){
             print("Page is " + page.toString());

            setState(() {
               params = generateParams(params, restaurant);
             });


             response = await responseCall(url, params);
           }
        }


      }


    catch (error, stackTrace) {
    print("Exception occurred: $error  stackTrace: $stackTrace");

    }

  //}
      if (mounted) {
        setState(() {
          isLoading = false;
          print(tList.toString());
          users.addAll(tList);
        });
      }
    }

    setState(() {
      allDone = true;
    });
    }

  generateParams(params, String restaurant) {


    params = listingLimit? {
      "appId": "816cee15",
      "appKey": "aab0a0a4c4224eca770bf5a2a0f4c984",
      "queries": {
        "brand_name": restaurant,
      },
      "fields": [
        "item_name",
        "brand_name",
        "nf_calories",
        "nf_sodium",
        "nf_total_fat",
        "item_type",
        "nf_cholesterol",
        "nf_total_carbohydrate",
            "nf_saturated_fat",
        "nf_trans_fatty_acid",
        "nf_serving_size_qty",
        "nf_serving_size_unit",
        "nf_servings_per_container",
        "nf_serving_weight_grams",
        "images_front_full_url"

      ],
      "offset": page,
      "limit": 50,
      "sort": {
        "field": "nf_calories",
        "order": "desc"
      },
      "filters": {

        "nf_calories": {
          "from": 0,
          "to": calorieSum
        },
        "nf_sodium": {
          "from": 0,
          "to": sodiumSum
        },
        "nf_total_carbohydrate": {
          "from": 0,
          "to": carbSum
        },
        "nf_total_fat": {
          "from": 0,
          "to": fatSum
        },
        "nf_cholesterol": {
          "from": 0,
          "to": cholesterolSum
        },
        "nf_saturated_fat": {
          "from": 0,
          "to": satFatSum
        },


      }
    }:{
      "appId": "816cee15",
      "appKey": "aab0a0a4c4224eca770bf5a2a0f4c984",
      "queries": {
        "brand_name": restaurant,
      },
      "fields": [
        "item_name",
        "brand_name",
        "nf_calories",
        "nf_sodium",
        "nf_total_fat",
        "item_type",
        "nf_cholesterol",
        "nf_total_carbohydrate",
        "nf_saturated_fat",
        "nf_trans_fatty_acid",
        "nf_serving_size_qty",
        "nf_serving_size_unit",
        "nf_servings_per_container",
        "nf_serving_weight_grams",
        "images_front_full_url"
      ],
      "offset": page,
      "limit": 50,
      "sort": {
        "field": "nf_calories",
        "order": "desc"
      },

    };

    return params;
  }

  Future<Response<dynamic>> responseCall(String url, params) async {
     final response = await dio.post(url,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: params,
    );
    return response;
  }

  void addFoodtoTList(Response<dynamic> response, int i, String category, List<String> foodList, List<dynamic> tList) {
     if (determineFood(
        response.data['hits'][i]['fields']['item_name']) ==
        category && !badWords(response.data['hits'][i]['fields']['item_name'].toString()) && !foodList.contains(
        response.data['hits'][i]['fields']['item_name']
            .toString()
            .toLowerCase())) {

      tList.add(response.data['hits'][i]['fields']);
            foodList.add(response.data['hits'][i]['fields']['item_name']
          .toString()
          .toLowerCase());
    }
  }



  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  categoryWords(String category){

    String nutritionixQuery;

    final entreeWords = ["salad", "sandwich", "soup", "burger"];

    if (category == "Entrees"){
      for (int i=0; i<entreeWords.length; i++){
        if(nutritionixQuery == null) {
          nutritionixQuery == entreeWords[i];
        }
        else  {
          nutritionixQuery = nutritionixQuery + " OR " + entreeWords[i];
  }

      }
    }

    return nutritionixQuery;

  }

  determineFood(String category) {

    String categoryWord;
    const int categories = 3;
    final beverageReg =  RegExp("(?:coke|iced tea|dr. pepper|pepsi|sprite|orange juice|coffee|milk|root beer|latte|mocha|americano|frappe|shake|milk|lemonade|brisk raspberry|caffeine|cappuccino|cold brew|fresca|fruit punch|gold peak|green tea|hot chocolate|iced caramel|limonata|macchiato|mccafe|mcflurry|mist twist|mountain dew|orange soda|pibb|powerade|sierra mist|slushie|smoothie|sobe|tropicana)", caseSensitive: false);
    final entreeReg =  RegExp("(?:salad|wrap|smash|bowl|bbq|patty|sandwich|soup|burger|pasta|gyro|hoagie|buffalo|sandwich|nuggets|filet|strips|pounder|tenders|chicken|tacos|quesadilla|waffle|toast|pancake|omelette|omelet|sausage|breakfast|bagel|egg|hotcakes|steak|burrito|pie|fritter|alfredo|beef|bibimbap|big mac|brioche|buffalo|burrito|carbonara|cheeseburger|chili|ciabatta|eggplant|filet|flatbread|focaccia|gnocchi|gyro|hamburger|hoagie|korean|kung pao|lasagna|lo mein|lobster|mac|marsala|marinara|mcgriddles|meatballs|miche|minestrone|oatmeal|pad thai|panini|parmigana|pork|pounder|prawns|ravioli|ribeye|rigatoni|rontini|salmon|scampi|sea bass|shrimp|sirloin|souffle|spaghetti|spareribs|stew|stir-fried|stuffed shells|stuffed ziti fritta|surf & turf|tempura|tenders|thai curry|tofu|noodles|tortellini|tortelloni|udon|waffle|ziti|zuppa)", caseSensitive: false);

    final sideReg =  RegExp("(?:artichoke|asparagus|avocado rolls|baguette|banana|breadstick|brownie|california roll|california rolls|cinnamon roll|cookie|crab wonton|dessert|dipping sauce|dragon roll|dumplings|egg rolls|fried mozzarella|fruit cup|green beans|hash browns|kimchi|lahvash|mac & cheese|muffin|pastry|peanuts|pickle|potstickers|scone|spread|spring roll|tuna roll|wonton|yogurt|dressing|mustard|jelly|peanuts|coleslaw|sauce|fries|potato|rice|balsamic|beans|blue cheese)", caseSensitive: false);



    bool getCategory(int i, String string){
      if(i==0){
        return entreeReg.hasMatch(string);
      }
      else if(i==1){
        return sideReg.hasMatch(string);
      }
      else if(i==2){
        return beverageReg.hasMatch(string);
      }

      return false;
    }


    String getCategoryWord(int i){


      if(i==0){
        return "Entrees";
      }
      else if(i==1){
        return "Sides";
      }
      else if(i==2){
        return "Beverages";
      }

      return null;


    }

    for(int i=0; i < categories; i++){
      if (getCategory(i, category))
        categoryWord = getCategoryWord(i);
    }





    return categoryWord;
  }

  _buildAboutDialog2(BuildContext context, user) {}

  getCals(DateTime dateTime) {
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(dateTime);


  }

  Future <bool> _getLimitPref() async {


    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("listings");
  }

  bool badWords(String string) {


    print("String is " + string);
    final ignoreReg =  RegExp("(?:kids|children|combo|catering|gallon|build|create|family|bundle|serves|whole|tray|kid|party)", caseSensitive: false);

    print("Truth is " + ignoreReg.hasMatch(string).toString());
    return ignoreReg.hasMatch(string);
  }

  void checkPercentageOfDay(ref, user) {
    if (percentageOf(user['nf_calories'].toInt())){
      passThrough = true;
      return;
    }

    else
      {
_showDialog(ref, user);

      }


  }

  void _showDialog(ref, user) {
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
                passThrough = true;
                addToMyDay(ref, user);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewNutritionixList(
                        restaurant: restaurant, mealCategory: category),
                  ),
                );
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

  bool percentageOf(int value) {

    if (value/totalCalories >= 0.3) {
      return false;
    }
    return true;

  }

}


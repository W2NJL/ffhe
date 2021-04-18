import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fast_food_health_e/fitness_app/fintness_app_theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fast_food_health_e/services/FirebaseCalls.dart';
import 'package:unsplash_client/unsplash_client.dart' hide Response;

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
  static int remainingSodium;
  static int totalCarbs;
  static int remainingCarbs;
  static int sodiumSum;
  static int carbSum;
  static int fatSum;
  static int totalFat;
  static int remainingFat;
  static int totalCholesterol;
  static int remainingCholesterol;
  static int cholesterolSum;
  static int mealNum = 1;
  static String formattedDate;
  bool done = false;
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  final client = UnsplashClient(
    settings: ClientSettings(credentials: AppCredentials(
      accessKey: 'rH4xDYBXLLC1QLwSp0pHWmSXcHqYck0lMzJIVKG688M',
      secretKey: 'SG-k3_ZhUZDc-eOB8nDR8hyjhbSgRQ3-RvfLn0yC75c',
    )),
  );



  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  List users = new List();
  final dio = new Dio();




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
        return 999999999;
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
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){Navigator.pushNamedAndRemoveUntil(context, "RestaurantScreen", (_) => false);}
        ),
        title:  Text(restaurant),
      ),

      body: Column(children:
          [
            Container(
              child: _showTitle(),
            ),
            Container(
              child: _buildList(),
            ),
          ]

      ),
      resizeToAvoidBottomInset: false,
    );
  }


  Widget _showTitle(){
    return FutureBuilder(
        future: _getDietPlan(),
        initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return Text(
            "Diet plan: " + text.data,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: FitnessAppTheme.fontName,
              fontWeight: FontWeight.normal,
              fontSize: 18,
              letterSpacing: -0.2,
              color: FitnessAppTheme.darkerText,
            ),
          );
        }
    );
  }

  Future <String> _getDietPlan() async {
    String result;
    String result2;
    String result3;
    String result4;
    String result5;
    final referenceDatabase = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('DietPlan')
        .once()
        .then((snapshot){result=snapshot.value;});


    final referenceDatabase2 = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('Low Carb')
        .once()
        .then((snapshot){result2=snapshot.value;});


    final referenceDatabase3 = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('Sodium')
        .once()
        .then((snapshot){result3=snapshot.value;});


    final referenceDatabase4 = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('Low Fat')
        .once()
        .then((snapshot){result4=snapshot.value;});
    print(result);

    final referenceDatabase5 = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('Low Cholesterol')
        .once()
        .then((snapshot){result5=snapshot.value;});
    print(result);



    return result + ", \n" + result2 + ", " + result3 +", \n"+ result4 + ", " + result5;
  }

  
  Future <Uri> _getPhotos(user) async{
    // Call `goAndGet` to execute the [Request] returned from `random`
// and throw an exception if the [Response] is not ok.
    final photos = await client.photos.random(count: 1, query: user).goAndGet();

// The api returns a `Photo` which contains metadata about the photo and urls to download it.
    final photo = photos.first;

    final thumb = photo.urls.thumb;




    return thumb;
  }

  Widget _buildList() {

      return Expanded(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: users.length + 1, // Add one more item for progress indicator
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
                  leading: FutureBuilder<Uri>(
                      future: _getPhotos(users[index]['item_name']),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                           radius: 30,
                            backgroundImage: NetworkImage(
                              snapshot.data.toString()
                            ),

                          );
                        }
                        return CircularProgressIndicator();
                      }
                  ),
                  title: Text((users[index]['item_name'])),
                  subtitle: Text(
                      (users[index]['nf_calories'].toString()) +
                          ' calories'),
                ),
              );
            }
          },
          controller: _sc,
        ),
      );
    }


 Widget _buildAboutDialog(BuildContext context, user) {
    final referenceDatabase = FirebaseDatabase.instance;
    final ref = referenceDatabase.reference().child('User');

    return new AlertDialog(
      title: Text(user['item_name']),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(user),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            ref.child('DietVals').child(formattedDate).child('Calories').set(ServerValue.increment(user['nf_calories']));
            ref.child('DietVals').child(formattedDate).child('Sodium').set(ServerValue.increment(user['nf_sodium']));
            ref.child('DietVals').child(formattedDate).child('Low Carb').set(ServerValue.increment(user['nf_total_carbohydrate']));
            ref.child('DietVals').child(formattedDate).child('Low Fat').set(ServerValue.increment(user['nf_total_fat']));
            ref.child('DietVals').child(formattedDate).child('Low Cholesterol').set(ServerValue.increment(user['nf_cholesterol']));
            ref.child('DietVals').child(formattedDate).child('Meals').child(user['item_name']).child('calories').set(ServerValue.increment(user['nf_calories']));
            ref.child('DietVals').child(formattedDate).child('Meals').child(user['item_name']).child('sodium').set(ServerValue.increment(user['nf_sodium']));
            ref.child('DietVals').child(formattedDate).child('Meals').child(user['item_name']).child('carbs').set(ServerValue.increment(user['nf_total_carbohydrate']));
            ref.child('DietVals').child(formattedDate).child('Meals').child(user['item_name']).child('fat').set(ServerValue.increment(user['nf_total_fat']));
            ref.child('DietVals').child(formattedDate).child('Meals').child(user['item_name']).child('cholesterol').set(ServerValue.increment(user['nf_cholesterol']));
            ref.child('DietVals').child(formattedDate).child('Meals').child(user['item_name']).child('Restaurant').set(user['brand_name']);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NewNutritionixList(restaurant: restaurant, mealCategory: category),
              ),
            );
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Add to My Day'),
        ),
      ],
    );
  }

  static Widget _buildAboutText(user) {
    return new RichText(
      text: new TextSpan(
        text: 'Calories: ' + user['nf_calories'].toString() + " calories" + '\n\n' +
            'Total Carbohydrates: ' + user['nf_total_carbohydrate'].toString() + " g" + '\n\n' +
            'Sodium: ' + user['nf_sodium'].toString() + " mg" + '\n\n' +
            'Total Fat: '  + user['nf_total_fat'].toString() + " g" + '\n\n' +
            'Cholesterol: ' + user['nf_cholesterol'].toString() + " mg" + '\n\n',
        style: const TextStyle(color: Colors.black87),
        // children: <TextSpan>[
        //   const TextSpan(text: 'The app was developed with '),
        //   new TextSpan(
        //     text: 'Flutter',
        //
        //   ),
        //   const TextSpan(
        //     text: ' and it\'s open source; check out the source '
        //         'code yourself from ',
        //   ),
        //   new TextSpan(
        //     text: 'www.codesnippettalk.com',
        //
        //   ),
        //   const TextSpan(text: '.'),
        // ],
      ),
    );
  }

  void _getMoreData(int index, String restaurant, String category) async {
    int totalCalories2;
    var params;
        if (!isLoading) {
      setState(() {
        isLoading = true;
      });

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

    await _getRemainingNutrients('Calories').then((value) => setState((){
      remainingCalories = value;

      if (remainingCalories == null)
        {
          calorieSum = totalCalories;
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
        }
        else{
          sodiumSum = totalSodium-remainingSodium;
        }}));

      await _getRemainingNutrients('Low Cholesterol').then((value) => setState((){
        remainingCholesterol = value;

        if (remainingCholesterol == null)
        {
          cholesterolSum = totalCholesterol;
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
        }

        print("FatSum is: " + fatSum.toString());
      }));




      await _getRemainingNutrients('Low Carb').then((value) => setState(() {
        remainingCarbs = value;

        if (remainingCarbs == null) {
          carbSum = totalCarbs;
        }
        else {
          carbSum = totalCarbs - remainingCarbs;
        }

        print("CarbSum is: " + carbSum.toString());
        }));

      List tList = new List();
      var url = 'https://api.nutritionix.com/v1_1/search';


      try {
        params = generateParams(params, restaurant);
        Response<dynamic> response = await responseCall(url, params);

        while (tList.length < 10 && response.data['hits'] != null) {



          //var url = 'https://api.nutritionix.com/v1_1/search/' + restaurant + '?results='+ index.toString() + ':' + (index+50).toString() + '&fields=item_name,brand_name,nf_calories,nf_sodium,nf_sugars,nf_cholesterol,nf_total_fat,nf_dietary_fiber&appId=816cee15&appKey=aab0a0a4c4224eca770bf5a2a0f4c984';
          //print(url);


          List<String> foodList = <String>[];

          int orig = tList.length;


          for (int i = 0; i < response.data['hits'].length; i++) {
            addFoodtoTList(response, i, category, foodList, tList);
            print("Length of list is: " + tList.length.toString());
          }

          if (tList.length == orig){
            break;
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
    }

  generateParams(params, String restaurant) {
    params = {
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
        "nf_total_carbohydrate"
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
        }
      }
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
        category && !foodList.contains(
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
    final beverageReg =  RegExp("(?:coke|tea|dr. pepper|pepsi|sprite|orange juice|coffee|milk|root beer|latte|cola|mocha|americano|frappe|shake|milk)", caseSensitive: false);
    final entreeReg =  RegExp("(?:salad|bowl|sandwich|soup|burger|pasta|gyro|hoagie|buffalo|sandwich|nuggets|filet|strips|pounder|tenders|mac|chicken|tacos|quesadilla|waffle|toast|pancake|omelette|omelet|sausage|breakfast|bagel|egg|muffin|hotcakes|steak|burrito|pie|fritter)", caseSensitive: false);

    final sideReg =  RegExp("(?:dressing|mustard|jelly|peanuts|coleslaw|sauce|lemonade|fries|potato|corn|rice|balsamic|beans|blue cheese)", caseSensitive: false);



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

}
import 'package:fast_food_health_e/fitness_app/fintness_app_theme.dart';
import 'package:fast_food_health_e/main.dart';
import 'package:fast_food_health_e/models/fastFoodHealthE.dart';
import 'package:fast_food_health_e/services/firebase_services.dart';
import 'package:fast_food_health_e/state/FastFoodHealthEState.dart';
import 'package:fast_food_health_e/utils/firebaseFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';

class MediterranesnDietView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: new DrillDownScreen(),
      // home: DetailPage(),
    );
  }
}

class DrillDownScreen extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  final int calories;



  DrillDownScreen({Key key, this.calories, this.title, this.app, this.animation, this.animationController}) : super(key: key);

  final String title;
  final FirebaseApp app;


  @override
  _DrillDownScreenState createState() => _DrillDownScreenState();
}



class _DrillDownScreenState extends State<DrillDownScreen> {

  int Calories;
  int sodium;
  int carbs;
  int fat;
  int cholesterol;
  int calorieMax;
  int carbMax;
  int sodiumMax;
  int fatMax;
  int cholesterolMax;
  int numDietTrackers = 0;
  bool done = false;
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  List<String> restaurants = <String>[];
  List<String> imageArray = <String>[];
  String graphPlan1;
  String graphPlan2;
  String graphPlan3;
  bool graph1Bool = true, graph2Bool = true, graph3Bool = true;
  int graph1Multiplier, graph1Divide, graph1Divisor, graph1Num, graph2Multiplier, graph2Divide, graph2Divisor, graph3Multiplier, graph3Divide, graph3Divisor;
  var firebaseUser;
  FastFoodHealthEUser fastFoodHealthEUser;
  String userID;
  FirebaseFunctions joe = new FirebaseFunctions();



  @override
  void didChangeDependencies() {

    if(firebaseUser ==null) {
      setUpUsers();
    }



    super.didChangeDependencies();

  }

  _DrillDownScreenState(){






    // _getImageValue().then((value) => setState((){
    //   image1 = value;
    // }));
  }


  void _newGetMoreData() {


  }

  void setUpUsers () async  {



    firebaseUser = context.watch<User>();
    userID  = firebaseUser.uid;
    fastFoodHealthEUser =   Provider.of<FastFoodHealthEState>(context, listen: false).activeVote;


    this._getMoreData();


  }



  void _getMoreData() async {
    bool cals, sodiums, carbies, fats, cholesterols, calmaxs, rests, sodmaxs, carbmax, fatmax, cholmax, graphVals;



    if(fastFoodHealthEUser!=null){
      print("Got here in never never land");



        Calories = fastFoodHealthEUser.todaysCal;

        print("Just testing this: " + Calories.toString());


        sodium = fastFoodHealthEUser.todaysSodium;

        carbs = fastFoodHealthEUser.todaysCarbs;

      print("Just testing this2: " + carbs.toString());

        fat = fastFoodHealthEUser.todaysFat;

        cholesterol = fastFoodHealthEUser.todaysCholesterol;

        calorieMax = fastFoodHealthEUser.calMaxValue;

        sodiumMax = fastFoodHealthEUser.sodiumMaxValue;

        carbMax = fastFoodHealthEUser.carbsMaxValue;

        fatMax = fastFoodHealthEUser.fatMaxValue;

        cholesterolMax = fastFoodHealthEUser.cholesterolmaxValue;

        restaurants = _getRestaurantImages();



      if(restaurants != null){
        for (String restaurant in restaurants) {
          if(!imageArray.contains(joe.getRestaurantIcon(restaurant))) {
            imageArray.add(joe.getRestaurantIcon(restaurant));
          }
        }}


      setGraphVars();



          done = true;



      print("Van McCoy is: " + done.toString());
    }









    // if (sodiumMax == null && cholesterolMax != null){
    //   showingCholesterol = true;
    // }
}

  Future <int> _getMaxValue(String diet) async {
    final referenceDatabase = FirebaseDatabase.instance;
    final ref = referenceDatabase.reference().child('User').child('DietVals');

    String formattedDate = getDate();


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


      return maxValue;
  }

  _getRestaurantImages() {

    String formattedDate = getDate();
    Map<dynamic, dynamic> meals;
    List<String> restaurants = <String>[];

    meals = fastFoodHealthEUser.restaurantList;

if(meals!=null){
//    print(fridgesDs.runtimeType);
    meals.forEach((key, value) {
      print("Value is: " + value['Restaurant'].toString());


      restaurants.add(value['Restaurant'].toString());
    });

  }

    return restaurants;
        }




  String getDate() {
     var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }


  // Future <String> _getImageValue() async {
  //
  //   final referenceDatabase = FirebaseDatabase.instance;
  //   final ref = referenceDatabase.reference().child('User').child('DietVals');
  //
  //   var now = new DateTime.now();
  //   var formatter = new DateFormat('yyyy-MM-dd');
  //   String formattedDate = formatter.format(now);
  //
  //   String result;
  //
  //   final referenceDatabase2 = await FirebaseDatabase.instance
  //       .reference()
  //       .child('User')
  //       .child('DietVals')
  //       .child(formattedDate)
  //       .child('Meals')
  //       .once()
  //       .then((snapshot){result=snapshot.value;});
  //
  //   print("Here it is NICKY: " + result.toString());
  //   done = true;
  //
  //   if(result != null) {
  //     return result;
  //   }
  //   else return null;
  //
  // }




  @override
  Widget build(BuildContext context) {




    int protein;
    int remainingValue;
    String graphMeasure;
    String dietPlan;
    String sodiumPlan;
    String carbPlan;
    String fatPlan;


    dietPlan = preferences.getString("dietPlan") ?? 'Johnny';
    sodiumPlan = preferences.getString("Sodium") ?? null;
    carbPlan = preferences.getString("Low Carb") ?? null;
    fatPlan = preferences.getString("Low Fat") ?? null;





      switch ( dietPlan ) {
        case Constants.LOW_CARB: {
          remainingValue = 100;
          graphMeasure = "g";
        } break;
        case Constants.LOW_SODIUM_1: {
          remainingValue = 1500;
          graphMeasure = "mg";
        } break;

        case Constants.LOW_CALORIE_1: {
          remainingValue = Calories;
          graphMeasure = "Kcal";

        } break;
        case Constants.LOW_CALORIE_2: {
          remainingValue = Calories;
          graphMeasure = "Kcal";
        } break;
        case Constants.LOW_CALORIE_3: {
          remainingValue = Calories;
          graphMeasure = "Kcal";
        } break;
        case Constants.LOW_FAT: {
          remainingValue = 45;
          graphMeasure = "g";
        } break;
        case Constants.LOW_CHOLESTEROL: {
          remainingValue = 150;
          graphMeasure = "mg";
        } break;


        default: {
          graphMeasure = "Kcal";
          print(dietPlan);
        } break;
      }






if(done){

    return InkWell(
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          onTap: () {
            Navigator.pushNamed(context, 'TodaysMeals');

          },
      child: AnimatedBuilder(

        animation: widget.animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
            opacity: widget.animation,
            child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.animation.value), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 16, bottom: 18),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey.withOpacity(0.2),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(

                    children: <Widget>[
                      Row(
                        children: <Widget>[
                  Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 30),),
                    Text('Tap to get information on today\'s meals',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily:
                        FitnessAppTheme.fontName,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        letterSpacing: 0.0,
                        color: FitnessAppTheme.darkerText
                            .withOpacity(1.0),
                      ),

                  ),]),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 4, left: 16, right: 16),
                          child: Row(

                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 8, top: 0, bottom: 5),
                                  child: Column(
                                    children: <Widget>[
                                      // Row(
                                      //   children: <Widget>[
                                      //     Container(
                                      //       height: 48,
                                      //       width: 2,
                                      //       decoration: BoxDecoration(
                                      //         color: HexColor('#87A0E5')
                                      //             .withOpacity(0.5),
                                      //         borderRadius: BorderRadius.all(
                                      //             Radius.circular(4.0)),
                                      //       ),
                                      //     ),
                                      //     Padding(
                                      //       padding: const EdgeInsets.all(8.0),
                                      //       child: Column(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment.center,
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //         children: <Widget>[
                                      //           Padding(
                                      //             padding: const EdgeInsets.only(
                                      //                 left: 4, bottom: 2),
                                      //             child: Text(
                                      //               'Eaten',
                                      //               textAlign: TextAlign.center,
                                      //               style: TextStyle(
                                      //                 fontFamily:
                                      //                     FitnessAppTheme.fontName,
                                      //                 fontWeight: FontWeight.w500,
                                      //                 fontSize: 16,
                                      //                 letterSpacing: -0.1,
                                      //                 color: FitnessAppTheme.grey
                                      //                     .withOpacity(0.5),
                                      //               ),
                                      //             ),
                                      //           ),
                                                Row(

                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: <Widget>[

                                                    imageArray.isNotEmpty ? SizedBox(
                                                      width: 40,
                                                      height: 40,
                                                      child: Image.network(
                                                         imageArray.elementAt(0)),
                                                    ) : SizedBox(height: 0),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4, bottom: 0),
                                                      // child: Text(
                                                      //   '${(1127 * widget.animation.value).toInt()}',
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     fontFamily:
                                                      //         FitnessAppTheme
                                                      //             .fontName,
                                                      //     fontWeight:
                                                      //         FontWeight.w600,
                                                      //     fontSize: 16,
                                                      //     color: FitnessAppTheme
                                                      //         .darkerText,
                                                      //   ),
                                                      // ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4, bottom: 0),


                                                      // child: Text(
                                                      //   "Kcal",
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     fontFamily:
                                                      //         FitnessAppTheme
                                                      //             .fontName,
                                                      //     fontWeight:
                                                      //         FontWeight.w600,
                                                      //     fontSize: 12,
                                                      //     letterSpacing: -0.2,
                                                      //     color: FitnessAppTheme
                                                      //         .grey
                                                      //         .withOpacity(0.5),
                                                      //   ),
                                                      // ),
                                                    ),
                                                    imageArray.isNotEmpty && imageArray.length >= 2? SizedBox(
                                                      width: 40,
                                                      height: 40,
                                                      child: Image.asset(
                                                           imageArray.elementAt(1)),
                                                    ) : SizedBox(height: 0),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 4, bottom: 0),
                                                      // child: Text(
                                                      //   '${(1127 * widget.animation.value).toInt()}',
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     fontFamily:
                                                      //         FitnessAppTheme
                                                      //             .fontName,
                                                      //     fontWeight:
                                                      //         FontWeight.w600,
                                                      //     fontSize: 16,
                                                      //     color: FitnessAppTheme
                                                      //         .darkerText,
                                                      //   ),
                                                      // ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 4, bottom: 0),


                                                      // child: Text(
                                                      //   "Kcal",
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     fontFamily:
                                                      //         FitnessAppTheme
                                                      //             .fontName,
                                                      //     fontWeight:
                                                      //         FontWeight.w600,
                                                      //     fontSize: 12,
                                                      //     letterSpacing: -0.2,
                                                      //     color: FitnessAppTheme
                                                      //         .grey
                                                      //         .withOpacity(0.5),
                                                      //   ),
                                                      // ),
                                                    ),
                                                    imageArray.isNotEmpty && imageArray.length >= 3? SizedBox(
                                                      width: 40,
                                                      height: 40,
                                                      child: Image.asset(
                                                          imageArray.elementAt(2)),
                                                    ) : SizedBox(height: 0),

                                ], ),



                                      SizedBox(
                                        height: 8,
                                      ),
                                      // Row(
                                      //   children: <Widget>[
                                      //     Container(
                                      //       height: 48,
                                      //       width: 2,
                                      //       decoration: BoxDecoration(
                                      //         color: HexColor('#F56E98')
                                      //             .withOpacity(0.5),
                                      //         borderRadius: BorderRadius.all(
                                      //             Radius.circular(4.0)),
                                      //       ),
                                      //     ),
                                      //     Padding(
                                      //       padding: const EdgeInsets.all(8.0),
                                      //       child: Column(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment.center,
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //         children: <Widget>[
                                      //           Padding(
                                      //             padding: const EdgeInsets.only(
                                      //                 left: 4, bottom: 2),
                                      //             child: Text(
                                      //               'Burned',
                                      //               textAlign: TextAlign.center,
                                      //               style: TextStyle(
                                      //                 fontFamily:
                                      //                     FitnessAppTheme.fontName,
                                      //                 fontWeight: FontWeight.w500,
                                      //                 fontSize: 16,
                                      //                 letterSpacing: -0.1,
                                      //                 color: FitnessAppTheme.grey
                                      //                     .withOpacity(0.5),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //           Row(
                                      //             mainAxisAlignment:
                                      //                 MainAxisAlignment.center,
                                      //             crossAxisAlignment:
                                      //                 CrossAxisAlignment.end,
                                      //             children: <Widget>[
                                      //               SizedBox(
                                      //                 width: 28,
                                      //                 height: 28,
                                      //                 child: Image.asset(
                                      //                     "images/fitness_app/burned.png"),
                                      //               ),
                                      //               Padding(
                                      //                 padding:
                                      //                     const EdgeInsets.only(
                                      //                         left: 4, bottom: 3),
                                      //                 child: Text(
                                      //                   '${(102 * animation.value).toInt()}',
                                      //                   textAlign: TextAlign.center,
                                      //                   style: TextStyle(
                                      //                     fontFamily:
                                      //                         FitnessAppTheme
                                      //                             .fontName,
                                      //                     fontWeight:
                                      //                         FontWeight.w600,
                                      //                     fontSize: 16,
                                      //                     color: FitnessAppTheme
                                      //                         .darkerText,
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               Padding(
                                      //                 padding:
                                      //                     const EdgeInsets.only(
                                      //                         left: 8, bottom: 3),
                                      //                 child: Text(
                                      //                   'Kcal',
                                      //                   textAlign: TextAlign.center,
                                      //                   style: TextStyle(
                                      //                     fontFamily:
                                      //                         FitnessAppTheme
                                      //                             .fontName,
                                      //                     fontWeight:
                                      //                         FontWeight.w600,
                                      //                     fontSize: 12,
                                      //                     letterSpacing: -0.2,
                                      //                     color: FitnessAppTheme
                                      //                         .grey
                                      //                         .withOpacity(0.5),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           )
                                      //         ],
                                      //       ),
                                      //     )
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Center(
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: FitnessAppTheme.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(100.0),
                                            ),
                                            border: new Border.all(
                                                width: 4,
                                                color: FitnessAppTheme
                                                    .nearlyDarkBlue
                                                    .withOpacity(0.2)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                Calories.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 24,
                                                  letterSpacing: 0.0,
                                                  color: FitnessAppTheme
                                                      .nearlyDarkBlue,
                                                ),
                                              ),
                                              Text(
                                                graphMeasure + ' used',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  letterSpacing: 0.0,
                                                  color: FitnessAppTheme.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CustomPaint(
                                          painter: CurvePainter(
                                              colors: [
                                                FitnessAppTheme.nearlyDarkBlue,
                                                HexColor("#8A98E8"),
                                                HexColor("#8A98E8")
                                              ],
                                              angle: (Calories/calorieMax)*360 +
                                                  (360 - 140) *
                                                      (1.0 - widget.animation.value)),
                                          child: SizedBox(
                                            width: 108,
                                            height: 108,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

              Padding(
                padding:
                const EdgeInsets.only(top: 0, left: 16, right: 16),
                child: Row(
                    children: <Widget>[
                Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(
                    left: 0, right: 8, top: 0, bottom: 5),
                  child: Column(
                    children: <Widget>[
                  // Row(
                  //   children: <Widget>[
                  //     Container(
                  //       height: 48,
                  //       width: 2,
                  //       decoration: BoxDecoration(
                  //         color: HexColor('#87A0E5')
                  //             .withOpacity(0.5),
                  //         borderRadius: BorderRadius.all(
                  //             Radius.circular(4.0)),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Column(
                  //         mainAxisAlignment:
                  //             MainAxisAlignment.center,
                  //         crossAxisAlignment:
                  //             CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Padding(
                  //             padding: const EdgeInsets.only(
                  //                 left: 4, bottom: 2),
                  //             child: Text(
                  //               'Eaten',
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                 fontFamily:
                  //                     FitnessAppTheme.fontName,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: 16,
                  //                 letterSpacing: -0.1,
                  //                 color: FitnessAppTheme.grey
                  //                     .withOpacity(0.5),
                  //               ),
                  //             ),
                  //           ),
                  Row(

                  mainAxisAlignment:
                  MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.end,
                    children: <Widget>[

                      imageArray.isNotEmpty && imageArray.length >= 4 ? SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                         imageArray.elementAt(3)),
                  ) : SizedBox(height: 0),
              Padding(
                padding:
                const EdgeInsets.only(
                    left: 4, bottom: 3),
                // child: Text(
                //   '${(1127 * widget.animation.value).toInt()}',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontFamily:
                //         FitnessAppTheme
                //             .fontName,
                //     fontWeight:
                //         FontWeight.w600,
                //     fontSize: 16,
                //     color: FitnessAppTheme
                //         .darkerText,
                //   ),
                // ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(
                    left: 4, bottom: 3),


                // child: Text(
                //   "Kcal",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontFamily:
                //         FitnessAppTheme
                //             .fontName,
                //     fontWeight:
                //         FontWeight.w600,
                //     fontSize: 12,
                //     letterSpacing: -0.2,
                //     color: FitnessAppTheme
                //         .grey
                //         .withOpacity(0.5),
                //   ),
                // ),
              ),
              imageArray.isNotEmpty && imageArray.length >= 5? SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                   imageArray.elementAt(4)),
              ) : SizedBox(height: 0),


          ],
          ),
          ],
          )
          ))])),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 8, bottom: 8),
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: FitnessAppTheme.background,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 8, bottom: 16),
                        child:  Row(
                          children: <Widget>[
                            Expanded(
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    graphPlan1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      letterSpacing: -0.2,
                                      color: FitnessAppTheme.darkText,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Container(
                                      height: 4,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color:
                                            HexColor('#87A0E5').withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          graph1Bool? Container(
                                            width: ((graph1Divide/graph1Divisor)*graph1Multiplier),
                                            height: 4,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                HexColor('#87A0E5'),
                                                HexColor('#87A0E5')
                                                    .withOpacity(0.5),
                                              ]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                          ):SizedBox(height: 0),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      graph1Num.toString() + ' mg',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color:
                                            FitnessAppTheme.grey.withOpacity(0.5),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        graphPlan2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: -0.2,
                                          color: FitnessAppTheme.darkText,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Container(
                                          height: 4,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: HexColor('#F56E98')
                                                .withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              graph2Bool? Container(
                                                width: ((graph2Divide/graph2Divisor)*graph2Multiplier),
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    HexColor('#F56E98')
                                                        .withOpacity(0.1),
                                                    HexColor('#F56E98'),
                                                  ]),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(4.0)),
                                                ),
                                              ): SizedBox(height: 0),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          graph2Divide.toString() + 'g',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: FitnessAppTheme.grey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),

                                    ],
                              ),
                            ]),
            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        graphPlan3,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: -0.2,
                                          color: FitnessAppTheme.darkText,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 0, top: 4),
                                        child: Container(
                                          height: 4,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: HexColor('#F1B440')
                                                .withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              graph3Bool? Container(
                                                width: ((graph3Divide/graph3Divisor)*graph3Multiplier),
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    HexColor('#F1B440')
                                                        .withOpacity(0.1),
                                                    HexColor('#F1B440'),
                                                  ]),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(4.0)),
                                                ),
                                              ):SizedBox(height: 0),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          graph3Divide.toString() + 'g',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: FitnessAppTheme.grey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
}
  else
  return Center(child: CircularProgressIndicator());
  }













  void setGraphVars() async{






    if (sodiumMax == null && carbMax == null && cholesterolMax == null && fatMax == null){
      graphPlan1 = "Carbs";
      graph1Multiplier = 70;
      graph1Divide = carbs;
      graph1Divisor = 1;
      graph1Bool = false;
      graph1Num = carbs;

      graphPlan2 = "Sodium";
      graph2Multiplier = 70;
      graph2Divide = sodium;
      graph2Divisor = 1;
      graph2Bool = false;

      graphPlan3 = "Cholesterol";
      graph3Multiplier = 70;
      graph3Divide = cholesterol;
      graph3Divisor = 1;
      graph3Bool = false;
    }

    if (sodiumMax == null && carbMax == null && cholesterolMax == null && fatMax != null){
      graphPlan1 = "Fat";
      graph1Multiplier = 70;
      graph1Num = fat;

      if(fat <= fatMax) {
        graph1Divide = fat;
        graph1Divisor = fatMax;
      }
      else{
        graph1Divide = fatMax;
        graph1Divisor = fatMax;
      }

      graphPlan2 = "Carbs";
      graph2Multiplier = 70;
      graph2Divide = carbs;
      graph2Divisor = 1;
      graph2Bool = false;

      graphPlan3 = "Sodium";
      graph3Multiplier = 70;
      graph3Divide = sodium;
      graph3Divisor = 1;
      graph3Bool = false;


    }

    if (sodiumMax != null && carbMax == null && cholesterolMax == null && fatMax == null){
      graphPlan1 = "Sodium";
      graph1Multiplier = 60;
      graph1Num = sodium;

      if(sodium <= sodiumMax) {
        graph1Divide = sodium;
        graph1Divisor = sodiumMax;
      }
      else{
        graph1Divide = sodiumMax;
        graph1Divisor = sodiumMax;
      }



      graphPlan2 = "Carbs";
      graph2Multiplier = 70;
      graph2Divide = carbs;
      graph2Divisor = 1;
      graph2Bool = false;

      print("Here nick. " + carbs.toString());



      graphPlan3 = "Fat";
      graph3Multiplier = 70;
      graph3Divide = fat;
      graph3Divisor = fatMax;
      graph3Bool = false;
    }

    if (sodiumMax != null && carbMax != null && cholesterolMax == null && fatMax == null){

        graphPlan1 = "Carbs";
        graph1Multiplier = 60;
        graph1Num = carbs;

        if(carbs <= carbMax) {
          graph1Divide = carbs;
          graph1Divisor = carbMax;
        }
        else{
          graph1Divide = carbMax;
          graph1Divisor = carbMax;
        }



        graphPlan2 = "Sodium";
        graph2Multiplier = 60;

        if(sodium <= sodiumMax) {
          graph2Divide = sodium;
          graph2Divisor = sodiumMax;
        }
        else{
          graph2Divide = sodiumMax;
          graph2Divisor = sodiumMax;
        }







      graphPlan3 = "Fat";
      graph3Multiplier = 70;
      graph3Divide = fat;
      graph3Divisor = fatMax;
      graph3Bool = false;
    }

    if (sodiumMax == null && carbMax != null && cholesterolMax != null && fatMax != null){

      graphPlan1 = "Carbs";
      graph1Multiplier = 60;
      graph1Num = carbs;

      if(carbs <= carbMax) {
        graph1Divide = carbs;
        graph1Divisor = carbMax;
      }
      else{
        graph1Divide = carbMax;
        graph1Divisor = carbMax;
      }



      graphPlan2 = "Cholesterol";
      graph2Multiplier = 60;

      if(cholesterol <= cholesterolMax) {
        graph2Divide = cholesterol;
        graph2Divisor = cholesterolMax;
      }
      else{
        graph2Divide = cholesterolMax;
        graph2Divisor = cholesterolMax;
      }







      graphPlan3 = "Fat";
      graph3Multiplier = 70;
      graph3Divide = fat;
      graph3Divisor = fatMax;
      graph3Bool = false;
    }

    if (sodiumMax != null && carbMax != null && cholesterolMax != null && fatMax == null){

      graphPlan1 = "Carbs";
      graph1Multiplier = 60;
      graph1Num = carbs;

      if(carbs <= carbMax) {
        graph1Divide = carbs;
        graph1Divisor = carbMax;
      }
      else{
        graph1Divide = carbMax;
        graph1Divisor = carbMax;
      }



      graphPlan2 = "Sodium";
      graph2Multiplier = 60;

      if(sodium <= sodiumMax) {
        graph2Divide = sodium;
        graph2Divisor = sodiumMax;
      }
      else{
        graph2Divide = sodiumMax;
        graph2Divisor = sodiumMax;
      }







      graphPlan3 = "Cholesterol";
      graph3Multiplier = 60;

      if(cholesterol <= cholesterolMax) {
        graph3Divide = cholesterol;
        graph3Divisor = cholesterolMax;
      }
      else{
        graph3Divide = cholesterolMax;
        graph3Divisor = cholesterolMax;
      }
    }

    if (sodiumMax == null && carbMax != null && cholesterolMax != null && fatMax == null){

      graphPlan1 = "Carbs";
      graph1Multiplier = 60;
      graph1Num = carbs;

      if(carbs <= carbMax) {
        graph1Divide = carbs;
        graph1Divisor = carbMax;
      }
      else{
        graph1Divide = carbMax;
        graph1Divisor = carbMax;
      }



      if(cholesterol <= cholesterolMax) {
        graph2Divide = cholesterol;
        graph2Divisor = cholesterolMax;
      }
      else{
        graph2Divide = cholesterolMax;
        graph2Divisor = cholesterolMax;
      }

      graphPlan3 = "Sodium";
      graph3Multiplier = 70;
      graph3Divide = sodium;
      graph3Bool = false;
      graph3Divisor = 1;








    }

    if (sodiumMax != null && carbMax != null && cholesterolMax != null && fatMax != null){

      graphPlan1 = "Carbs";
      graph1Multiplier = 60;
      graph1Num = carbs;

      if(carbs <= carbMax) {
        graph1Divide = carbs;
        graph1Divisor = carbMax;
      }
      else{
        graph1Divide = carbMax;
        graph1Divisor = carbMax;
      }



      graphPlan2 = "Sodium";
      graph2Multiplier = 60;

      if(sodium <= sodiumMax) {
        graph2Divide = sodium;
        graph2Divisor = sodiumMax;
      }
      else{
        graph2Divide = sodiumMax;
        graph2Divisor = sodiumMax;
      }







      graphPlan3 = "Cholesterol";
      graph3Multiplier = 60;

      if(cholesterol <= cholesterolMax) {
        graph3Divide = cholesterol;
        graph3Divisor = cholesterolMax;
      }
      else{
        graph3Divide = cholesterolMax;
        graph3Divisor = cholesterolMax;
      }
    }

    if (sodiumMax == null && carbMax != null && cholesterolMax != null && fatMax != null){

      graphPlan1 = "Carbs";
      graph1Multiplier = 60;
      graph1Num = carbs;

      if(carbs <= carbMax) {
        graph1Divide = carbs;
        graph1Divisor = carbMax;
      }
      else{
        graph1Divide = carbMax;
        graph1Divisor = carbMax;
      }


      graphPlan2 = "Cholesterol";
      graph2Multiplier = 70;
      graph2Divide = cholesterol;
        graph2Divisor = 1;

      if(cholesterol <= cholesterolMax) {
        graph2Divide = cholesterol;
        graph2Divisor = cholesterolMax;
      }
      else{
        graph2Divide = cholesterolMax;
        graph2Divisor = cholesterolMax;
      }

      graphPlan3 = "Sodium";
      graph3Multiplier = 70;
      graph3Divide = sodium;
      graph3Bool = false;
      graph3Divisor = 1;








    }

    if (sodiumMax == null && carbMax != null && cholesterolMax == null && fatMax == null){

      graphPlan1 = "Carbs";
      graph1Multiplier = 70;
      graph1Num = carbs;

      if(carbs <= carbMax) {
        graph1Divide = carbs;
        graph1Divisor = carbMax;
      }
      else{
        graph1Divide = carbMax;
        graph1Divisor = carbMax;

      }

      graphPlan2 = "Cholesterol";
      graph2Multiplier = 60;
graph2Divisor = 1;
      graph2Divide = cholesterol;
      graph2Bool = false;

      graphPlan3 = "Sodium";
      graph3Multiplier = 70;
      graph3Divide = sodium;
      graph3Bool = false;
      graph3Divisor = 1;








    }

    if (sodiumMax == null && carbMax == null && cholesterolMax != null && fatMax == null){

      graphPlan1 = "Cholesterol";
      graph1Multiplier = 60;
      graph1Num = cholesterol;

      if(cholesterol <= cholesterolMax) {
        graph1Divide = cholesterol;
        graph1Divisor = cholesterolMax;
      }
      else{
        graph1Divide = cholesterolMax;
        graph1Divisor = cholesterolMax;
      }



      graphPlan2 = "Carbs";
      graph2Multiplier = 70;
      graph2Divide = carbs;
      graph2Bool = false;
      graph2Divisor = 1;

      graphPlan3 = "Sodium";
      graph3Multiplier = 70;
      graph3Divide = sodium;
      graph3Bool = false;
      graph3Divisor = 1;








    }

    if (sodiumMax == null && carbMax == null && cholesterolMax == null && fatMax != null){



      graphPlan1 = "Fat";
      graph1Multiplier = 70;
      graph1Num = fat;


      if(fat <= fatMax) {
        graph1Divide = fat;
        graph1Divisor = fatMax;
      }
      else{
        graph1Divide = fatMax;
        graph1Divisor = fatMax;
      }



      graphPlan2 = "Carbs";
      graph2Multiplier = 70;
      graph2Divide = carbs;
      graph2Bool = false;
      graph2Divisor = 1;

      graphPlan3 = "Sodium";
      graph3Multiplier = 70;
      graph3Divide = sodium;
      graph3Bool = false;
      graph3Divisor = 1;








    }

    else

      {
        graphPlan1 = "Carbs";
        graph1Multiplier = 70;
        graph1Divide = carbs;
        graph1Divisor = 1;
        graph1Bool = false;
        graph1Num = carbs;

        graphPlan2 = "Sodium";
        graph2Multiplier = 70;
        graph2Divide = sodium;
        graph2Divisor = 1;
        graph2Bool = false;

        graphPlan3 = "Cholesterol";
        graph3Multiplier = 70;
        graph3Divide = cholesterol;
        graph3Divisor = 1;
        graph3Bool = false;
      }

  }
}

class CurvePainter extends CustomPainter {
  final double angle;
  final List<Color> colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = List<Color>();
    if (colors != null) {
      colorsList = colors;
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }


}
Future <String> _getDietPlan() async {
  String result;
  final referenceDatabase = await FirebaseDatabase.instance
  .reference()
  .child('User')
  .child('DietPlan')
  .once()
      .then((snapshot){result=snapshot.value;});
  print(result);

  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("dietPlan") ?? "No plan selected";
}


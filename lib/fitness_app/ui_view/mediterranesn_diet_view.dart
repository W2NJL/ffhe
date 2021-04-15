import 'package:fast_food_health_e/fitness_app/fintness_app_theme.dart';
import 'package:fast_food_health_e/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/utils/constants.dart';
import 'package:intl/intl.dart';
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
  bool done = false;
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;

  _DrillDownScreenState(){
    _getCalorieValue('Calories').then((value) => setState(() {
      Calories = value;
      done = true;
    }));
    _getCalorieValue('Sodium').then((value) => setState((){
      sodium = value;
    }));
    _getCalorieValue('Low Carb').then((value) => setState((){
      carbs = value;
    }));
    // _getImageValue().then((value) => setState((){
    //   image1 = value;
    // }));
  }



  Future <int> _getCalorieValue(String diet) async {

    final referenceDatabase = FirebaseDatabase.instance;
    final ref = referenceDatabase.reference().child('User').child('DietVals');

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    int result;
    int maxValue;
    final referenceDatabase2 = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('DietVals')
        .child(formattedDate)
        .child(diet)
        .once()
        .then((snapshot){result=snapshot.value;});
    final referenceDatabase3 = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('DietVals')
        .child(diet)
        .child('MaxValue')
        .once()
        .then((snapshot){maxValue=snapshot.value;});

    // if(result == null){
    //
    //   ref.child(formattedDate).child('Calories').set(2000);
    //
    // }

    done = true;

    if(result != null) {
      return maxValue - result;
    }
    else return maxValue;

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


    int fat;

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

    print("Sodium Plan is: " + sodiumPlan);



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
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4),
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

                                                  sodiumPlan != null? SizedBox(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image.asset(
                                                        "images/bob_evans.png"),
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
                              ]),



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
                                              '${(remainingValue * widget.animation.value).toInt()}',
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
                                              graphMeasure + ' left',
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
                                            angle: 140 +
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
                            sodiumPlan != "No sodium plan"? Expanded(
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Sodium',
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
                                          Container(
                                            width: ((80 / 1.2) * widget.animation.value),
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
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      sodium.toString() + ' mg left',
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
                            ):SizedBox(
                width: 1,
                height: 1,
              ),
                            carbPlan != "No carb plan"? Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Carbs',
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
                                              Container(
                                                width: ((70 / 2) *
                                                    widget.animationController.value),
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
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          carbs.toString() + 'g left',
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
                            ): SizedBox(height: 1),
                            fatPlan != null? Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Fat',
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
                                              Container(
                                                width: ((70 / 2.5) *
                                                    widget.animationController.value),
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
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          '10g left',
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
                            ): SizedBox(height: 1)
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


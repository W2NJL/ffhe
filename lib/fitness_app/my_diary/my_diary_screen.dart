import 'package:fast_food_health_e/fitness_app/ui_view/body_measurement.dart';
import 'package:fast_food_health_e/fitness_app/ui_view/glass_view.dart';
import 'package:fast_food_health_e/fitness_app/ui_view/mediterranesn_diet_view.dart';
import 'package:fast_food_health_e/fitness_app/ui_view/title_view.dart';
import 'package:fast_food_health_e/fitness_app/fintness_app_theme.dart';
import 'package:fast_food_health_e/fitness_app/my_diary/meals_list_view.dart';
import 'package:fast_food_health_e/fitness_app/my_diary/water_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen>
    with TickerProviderStateMixin {
  final referenceDatabase = FirebaseDatabase.instance;
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {

    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData () {
    const int count = 4;


    listViews.add(
        Container(
          child: Row(
            children:[
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
              ),
              Text(
                "Diet plan:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: FitnessAppTheme.darkerText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
              ),
            FutureBuilder(
                future: _getDietPlan(),
                initialData: "Loading text..",
                builder: (BuildContext context, AsyncSnapshot<String> text) {
                  return Text(
                    text.data,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: FitnessAppTheme.fontName,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: -0.2,
                      color: FitnessAppTheme.darkerText,
                    ),
                  );}
            ),
      ]
          ),
        ),


    );

    listViews.add(
      Card(

        margin: EdgeInsets.only(top: 20, bottom: 4, left: 20, right: 20),
        child: MaterialButton(minWidth: 5.0,
          height: 30,
          padding: const EdgeInsets.all(20),
          color: Color(0xFF69F0AE),
          child: Text('Add A Meal', style: new TextStyle(fontSize: 24.0, color: Colors.blueAccent)),

          onPressed: () { Navigator.pushNamedAndRemoveUntil(context, "RestaurantScreen", (_) => false);},
        ),
      ),
    );

    // listViews.add(
    //   Card(
    //
    //     margin: EdgeInsets.only(top: 4, bottom: 8, left: 20, right: 20),
    //     child: MaterialButton(minWidth: 5.0,
    //       height: 30,
    //       padding: const EdgeInsets.all(20),
    //       color: Color(0xFF2D3CEB),
    //       child: Text('Change Diet Plan', style: new TextStyle(fontSize: 24.0, color: Colors.white70)),
    //
    //       onPressed: () { Navigator.pushNamedAndRemoveUntil(context, "DietScreen", (_) => false);},
    //     ),
    //   ),
    // );
    // listViews.add(
    // FutureBuilder(
    // future: _getDietPlan(),
    // initialData: "Loading text..",
    // builder: (BuildContext context, AsyncSnapshot<String> text) {
    // return new TitleView(
    // titleTxt: text.data,
    // subTxt: 'Change Diet Plan',
    // animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    // parent: widget.animationController,
    // curve:
    // Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
    // animationController: widget.animationController,
    // );
    // }),
    // );

    listViews.add(
      DrillDownScreen(

        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
    listViews.add(
      TitleView(
        titleTxt: 'Ask A Nutritionist',

        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
    Text(
      "Get fast nutrition advice from our team, which includes a clinical professor and a 30 year nutritionist.",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontFamily: FitnessAppTheme.fontName,
        fontWeight: FontWeight.normal,
        fontSize: 14,
        letterSpacing: -0.2,
        color: FitnessAppTheme.darkerText,
      ),
    ),
    );

    listViews.add(
      Card(

        margin: EdgeInsets.only(top: 20, bottom: 4, left: 20, right: 20),
        child: Image.asset("images\/" + "nutritionist.jpg"),

      ),
    );



    //
    // listViews.add(
    //   TitleView(
    //     titleTxt: 'Body measurement',
    //     subTxt: 'Today',
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController,
    //         curve:
    //             Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController,
    //   ),
    // );
    //
    // listViews.add(
    //   BodyMeasurementView(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController,
    //         curve:
    //             Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController,
    //   ),
    // );
    // listViews.add(
    //   TitleView(
    //     titleTxt: 'Water',
    //     subTxt: 'Aqua SmartBottle',
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController,
    //         curve:
    //             Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController,
    //   ),
    // );
    //
    // listViews.add(
    //   WaterView(
    //     mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //         CurvedAnimation(
    //             parent: widget.animationController,
    //             curve: Interval((1 / count) * 7, 1.0,
    //                 curve: Curves.fastOutSlowIn))),
    //     mainScreenAnimationController: widget.animationController,
    //   ),
    // );
    // listViews.add(
    //   GlassView(
    //       animation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //           CurvedAnimation(
    //               parent: widget.animationController,
    //               curve: Interval((1 / count) * 8, 1.0,
    //                   curve: Curves.fastOutSlowIn))),
    //       animationController: widget.animationController),
    // );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
            return ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.only(
                top: 5,
                bottom: 62 + MediaQuery.of(context).padding.bottom,
                left: 10,
                right: 10,
              ),
              itemCount: listViews.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                widget.animationController.forward();
                return listViews[index];
              },
            );
            }
            );

        }
      },
    );
  }

  Widget getAppBarUI() {
    var now = new DateTime.now();
    var formatter = new  DateFormat.MMMMd('en_US');
    String formattedDate = formatter.format(now);
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                  ),
                                  Text(
                                    "Diet plan:",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      letterSpacing: -0.2,
                                      color: FitnessAppTheme.darkerText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: FutureBuilder(
                                    future: _getDietPlan(),
                                    initialData: "Loading text..",
                                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                                      return Text(
                                          text.data,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          letterSpacing: -0.2,
                                          color: FitnessAppTheme.darkerText,
                                      ),
                                    );}
                              ),
                            ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );

  }
}

void storeDietPlan(String dietPlan) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("dietPlan", dietPlan);
}

Future <String> _getDietPlan() async {
  String result;
  String result2;
  String result3;
  String result4;
  String result5;
  List<String> resultList = <String>[];
  final referenceDatabase = await FirebaseDatabase.instance
      .reference()
      .child('User')
      .child('DietPlan')
      .once()
      .then((snapshot){resultList.add(snapshot.value);});


  final referenceDatabase2 = await FirebaseDatabase.instance
      .reference()
      .child('User')
      .child('Low Carb')
      .once()
      .then((snapshot){resultList.add(snapshot.value);});
  //
  // if(result2 == 'No Carb Plan'){
  //   result2 == ''
  // }


  final referenceDatabase3 = await FirebaseDatabase.instance
      .reference()
      .child('User')
      .child('Sodium')
      .once()
      .then((snapshot){resultList.add(snapshot.value);});


  final referenceDatabase4 = await FirebaseDatabase.instance
      .reference()
      .child('User')
      .child('Low Fat')
      .once()
      .then((snapshot){resultList.add(snapshot.value);});
  print(result);

  final referenceDatabase5 = await FirebaseDatabase.instance
      .reference()
      .child('User')
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


import 'package:fast_food_health_e/fitness_app/fitness_app_home_screen.dart';
import 'package:fast_food_health_e/fitness_app/my_diary/my_diary_screen.dart';
import 'package:fast_food_health_e/models/dietplan.dart';
import 'package:fast_food_health_e/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/screens/detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'newdiet_screen.dart';


class SecondDietScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: new SecondDietPage(title: 'Select a Diet Plan'),
      // home: DetailPage(),
    );
  }
}
class SecondDietPage extends StatefulWidget {
  SecondDietPage({Key key, this.title, this.app}) : super(key: key);

  final String title;
  final FirebaseApp app;

  @override
  _SecondDietPageState createState() => _SecondDietPageState();
}

class _SecondDietPageState extends State<SecondDietPage> {
  String selectedPlan;
  List sodiumPlans;
  List carbPlans;
  List fatPlans;
  var diets = {"Low Carb": "", "Low Fat": "", "Sodium": ""};

  List<String> dietResults = [];
  final referenceDatabase = FirebaseDatabase.instance;

  @override
  void initState() {
    sodiumPlans = getSodiumPlans();
    carbPlans = getCarbPlans();
    fatPlans = getFatPlans();
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    final dietPlan = 'DietPlan';
    DatabaseReference _dietPlanRef;

    super.initState();
  }



  _SecondDietPageState(){
    for(int i =0; i  <diets.length; i++){
      String key = diets.keys.elementAt(i);
      print("Hold The Line: " + key);
    _getDietPlan(key).then((value) => setState(() {
      print("The value is: " + value);
      diets[key] = value;
    }
    ));
  }}

  Future <String> _getDietPlan(String plan) async {
    String result;
    final referenceDatabase = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child(plan)
        .once()
        .then((snapshot){result=snapshot.value;});
    print("The result is: " + result);



    return result;
  }



  static Widget _buildAboutText(DietPlan lesson) {
    return new Text.rich(
      TextSpan(children: [
        TextSpan(text: lesson.content + '\n\n' + lesson.content2 + '\n\n',
            style: const TextStyle(color: Colors.black87)),
        TextSpan(text: "Disclaimer: ",
            style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: lesson.disclaimer,
            style: const TextStyle(color: Colors.black87))
      ],),
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
    );
  }

  static Widget _buildAboutDialog(BuildContext context, DietPlan lesson) {
    return new AlertDialog(
      title: Text(lesson.title),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(lesson),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Select this plan'),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference().child('User');
    ListTile makeListTile(DietPlan lesson) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: GestureDetector(onTap: (){showDialog(
          context: context,
          builder: (BuildContext context) => _buildAboutDialog(context, lesson),
        );

        },child: Icon(Icons.info, color: Colors.white)),
      ),
      title: Text(
        lesson.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
       subtitle: diets[checkDietPlan(lesson.title)] == lesson.title ? Text("Selected Plan", style: TextStyle(color: Colors.white)) : null,

      // subtitle: Row(
      //   children: <Widget>[
      //     // Expanded(
      //     //     flex: 1,
      //     //     child: Container(
      //     //       // tag: 'hero',
      //     //       child: LinearProgressIndicator(
      //     //           backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
      //     //           value: lesson.indicatorValue,
      //     //           valueColor: AlwaysStoppedAnimation(Colors.green)),
      //     //     )),
      //     // Expanded(
      //     //   flex: 4,
      //     //   child: Padding(
      //     //       padding: EdgeInsets.only(left: 10.0),
      //     //       child: Text(lesson.level,
      //     //           style: TextStyle(color: Colors.white))),
      //     // )
      //   ],
      // ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () {


        ref.child(checkDietPlan(lesson.title)).set(lesson.title);
        String result;
        storeDietPlan(lesson.title);

        Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
      },
    );

    Card makeCard(DietPlan lesson) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(color: diets[checkDietPlan(lesson.title)] == lesson.title ?  Color.fromRGBO(233, 2, 16, .9) :  Color.fromRGBO(1, 22, 96, .9) ),
        child: makeListTile(lesson),
      ),
    );

    final makeBody = SingleChildScrollView(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
        child: new Column(
          children:[ SizedBox(height: 10), new Container(
            child: Text('Low Sodium Plans',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Aleo',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.white
              ),
            ),),
            SizedBox(height: 10),
            new Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: sodiumPlans.length,
                itemBuilder: (BuildContext context, int index) {
                  return makeCard(sodiumPlans[index]);
                },
              ),),
            SizedBox(height: 20),
            new Container(
              child: Text('Low Carb Plans',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Aleo',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.white
                ),
              ),),
            SizedBox(height: 10),
            new Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: carbPlans.length,
                itemBuilder: (BuildContext context, int index) {
                  return makeCard(carbPlans[index]);
                },
              ),),
            SizedBox(height: 20),
            new Container(
              child: Text('Other Plans',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Aleo',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.white
                ),
              ),),
            SizedBox(height: 10),
            new Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: fatPlans.length,
                itemBuilder: (BuildContext context, int index) {
                  return makeCard(fatPlans[index]);
                },
              ),),],)
    );






    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,

    );
  }

  void storeDietPlan(String dietPlan) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(checkDietPlan(dietPlan), dietPlan);
  }}

  String checkDietPlan(String title) {
    if(title == Constants.LOW_SODIUM_2 || title == Constants.LOW_SODIUM_1){
      return "Sodium";
    }
    else if
    (title == Constants.LOW_CARB|| title == Constants.KETO) {
      return "Low Carb";
    }
    else if
    (title == Constants.LOW_FAT){
      return "Low Fat";
    }
    else if
    (title == Constants.LOW_CHOLESTROL){
      return "Low Cholestrol";
    }

    return null;
  }


List getCarbPlans(){
  return [ DietPlan(
      title: Constants.LOW_CARB,
      level: "Intermediate",
      indicatorValue: 0.33,
      price: 50,
      content:
      "this diet plan is defined as 25% of total calories from carbohydrates.",
      content2: "Please also select a corresponding calorie plan.",
      disclaimer: "Of course there is always the caveat the this may vary with individuals due to metabolism and activity level."),
    DietPlan(
        title: Constants.KETO,
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
        "This diet plan is defined as 10% of total daily calories from carbohydrates.",
        content2: "Please also select a corresponding calorie plan.",
        disclaimer: "Of course there is always the caveat the this may vary with individuals due to metabolism and activity level."),];
}

List getFatPlans(){
  return[
    DietPlan(
        title: Constants.LOW_FAT,
        level: "Intermediate",
        indicatorValue: 0.33,
        price: 50,
        content:
        "This diet plan is defined as total fat intake less than/equal to 30% of total calories and saturated fat intake less than/equal to 10%.",
        content2: "Please also select a corresponding calorie plan.",
        disclaimer: "Of course there is always the caveat the this may vary with individuals due to metabolism and activity level.")
  ];
}


List getSodiumPlans() {
  return [
    DietPlan(
        title: Constants.LOW_SODIUM_1,
        level: "Intermidiate",
        indicatorValue: 0.33,
        price: 30,
        content:
        "This diet plan is defined as no more than 2300 mg sodium consumed daily.  One meal = no more than 760 mg sodium",
        content2: "American Heart Association recommends no more than 2300 mg sodium a day and moving toward an ideal limit of no more than 1500 mg sodium per day for most adults.",
        disclaimer: "Of course there is always the caveat the this may vary with individuals due to metabolism and activity level."),
    DietPlan(
        title: Constants.LOW_SODIUM_2,
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
        "This diet plan is defined as no more than 1500 mg sodium consumed daily.  One meal= no more than 500 mg sodium ",
        content2: "American Heart Association recommends no more than 2300 mg sodium a day and moving toward an ideal limit of no more than 1500 mg sodium per day for most adults.",
        disclaimer: "Of course there is always the caveat the this may vary with individuals due to metabolism and activity level."),


  ];
}


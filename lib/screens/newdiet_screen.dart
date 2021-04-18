import 'package:fast_food_health_e/models/dietplan.dart';
import 'package:fast_food_health_e/screens/seconddiet_screen.dart';
import 'package:fast_food_health_e/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/screens/detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DietScreen extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: new DietPage(title: 'Select a Calorie Plan'),
      // home: DetailPage(),
    );
  }
}
class DietPage extends StatefulWidget {

  DietPage({Key key, this.title, this.app}) : super(key: key);

  final String title;
  final FirebaseApp app;


  @override
  _DietPageState createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  String selectedPlan;
  List dietPlans;
  final referenceDatabase = FirebaseDatabase.instance;

  final dietPlan = 'DietPlan';
  DatabaseReference _dietPlanRef;



  @override
  void initState() {

    dietPlans = getDietPlans();
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _dietPlanRef = database.reference().child('User');
    super.initState();

  }

  _DietPageState(){
    _getDietPlan().then((value) => setState(() {
      selectedPlan = value;
      _showDialog();
    }));
  }

  Future <String> _getDietPlan() async {
    String result;
    final referenceDatabase = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('DietPlan')
        .once()
        .then((snapshot){result=snapshot.value;});
    print("The result is: " + result);



    return result;
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Select your Calorie plan"),
          content: new Text("First, please choose one of our 3 calorie plans."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
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
       subtitle: selectedPlan == lesson.title ? Text("Selected Plan", style: TextStyle(color: Colors.white)) : null,

      // subtitle: Row(
      //   children: <Widget>[
      //     // Expanded(
      //     //     flex: 1,
      //     //     child: Container(
      //     //       // tag: 'hero',
      //     //       child: LinearProgressIndicator(
      //     //           backgroundColor: Color.fromRGBO(209, 224, 224, 0.2)
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

        ref.child('DietPlan').set(lesson.title);
        ref.child('DietVals').child('Calories').child('MaxValue').set(lesson.number);
        String result;
        storeDietPlan(lesson.title);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => SecondDietScreen())
        );
      },
    );

    Card makeCard(DietPlan lesson) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(color: selectedPlan == lesson.title ?  Color.fromRGBO(233, 2, 16, .9) :  Color.fromRGBO(1, 22, 96, .9) ),
        child: makeListTile(lesson),
      ),
    );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dietPlans.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(dietPlans[index]);
        },
      ),
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

  selectedDietPlan(String title)  {
    String joe;

    // _getDietPlan().then((val) => setState(() {
    //   joe = val;
    // }));

    print("Holler: ");
    if (title == joe){
      return true;
    }

print("I got here!");

  return false;
}



List getDietPlans() {
  return [
    DietPlan(
        title: Constants.LOW_CALORIE_1,
        number: 2000,
        level: "Light",
        indicatorValue: 0.33,
        price: 20,
        content:
        "This 2000 calorie diet plan is defined as 3 meals per day each meal no more than 660 calories; There are no other nutrition restrictions other than calories.",
        content2: "When trying to lose weight, a general rule of thumb is to reduce your calorie intake to 500 fewer calories than your body needs to maintain your current weight. This will help you lose about 1 pound (0.45 kg) of body weight per week.",
        disclaimer: "Of course there is always the caveat the this may vary with individuals due to metabolism and activity level."
    ),
    DietPlan(
        title: Constants.LOW_CALORIE_2,
        number: 1500,
        level: "Intermediate",
        indicatorValue: 0.66,
        price: 50,
        content:
        "This 1500 calorie diet plan is defined as 3 meals per day each meal no more than 500 calories. There are no other nutrient restrictions other than calories.",
        content2: "When trying to lose weight, a general rule of thumb is to reduce your calorie intake to 500 fewer calories than your body needs to maintain your current weight. This will help you lose about 1 pound (0.45 kg) of body weight per week.",
        disclaimer: "Of course there is always the caveat the this may vary with individuals due to metabolism and activity level."),

    DietPlan(
        title: Constants.LOW_CALORIE_3,
        number: 1200,
        level: "Advanced",
        indicatorValue: 0.99,
        price: 30,
        content:
        "This 1200 calorie diet plan is defined as 3 meals per day each meal no more than 400 calories ; There are no other nutrient restrictions other than calories.",
        content2: "When trying to lose weight, a general rule of thumb is to reduce your calorie intake to 500 fewer calories than your body needs to maintain your current weight. This will help you lose about 1 pound (0.45 kg) of body weight per week.",
        disclaimer: "Of course there is always the caveat the this may vary with individuals due to metabolism and activity level."),

  ];
}

void storeDietPlan(String dietPlan) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("dietPlan", dietPlan);
}}
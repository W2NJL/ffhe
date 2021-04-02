import 'package:fast_food_health_e/models/dietplan.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/screens/detail_page.dart';


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
  SecondDietPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SecondDietPageState createState() => _SecondDietPageState();
}

class _SecondDietPageState extends State<SecondDietPage> {
  List dietPlans;

  @override
  void initState() {
    dietPlans = getDietPlans();
    super.initState();
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
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

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
        print("Container clicked");
      },
    );

    Card makeCard(DietPlan lesson) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
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
}



List getDietPlans() {
  return [
    DietPlan(
        title: "Lower Sodium Diet - 2300 mg sodium or less per day",
        level: "Intermidiate",
        indicatorValue: 0.33,
        price: 30,
        content:
        "This diet plan is defined as no more than 2300 mg sodium consumed daily.  One meal = no more than 760 mg sodium",
        content2: "American Heart Association recommends no more than 2300 mg sodium a day and moving toward an ideal limit of no more than 1500 mg sodium per day for most adults.",
        disclaimer: "Of course there is always the caveat the this may vary with individuals due to metabolism and activity level."),
    DietPlan(
        title: "Lowest Sodium Diet - 1500 mg sodium or less per day",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
        "This diet plan is defined as no more than 1500 mg sodium consumed daily.  One meal= no more than 500 mg sodium ",
        content2: "American Heart Association recommends no more than 2300 mg sodium a day and moving toward an ideal limit of no more than 1500 mg sodium per day for most adults.",
        disclaimer: "Of course there is always the caveat the this may vary with individuals due to metabolism and activity level."),
    DietPlan(
        title: "Low Carbohydrate Diet Plan",
        level: "Intermediate",
        indicatorValue: 0.33,
        price: 50,
        content:
        "this diet plan is defined as 25% of total calories from carbohydrates.",
        content2: "Please also select a corresponding calorie plan.",
        disclaimer: "Of course there is always the caveat the this may vary with individuals due to metabolism and activity level."),
    DietPlan(
        title: "Very Low Carbohydrate Diet Plan (Ketogenic) ",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
        "This diet plan is defined as 10% of total daily calories from carbohydrates.",
        content2: "Please also select a corresponding calorie plan.",
        disclaimer: "Of course there is always the caveat the this may vary with individuals due to metabolism and activity level."),
    DietPlan(
        title: "Low FAT Diet Plan ",
        level: "Intermediate",
        indicatorValue: 0.33,
        price: 50,
        content:
        "This diet plan is defined as total fat intake less than/equal to 30% of total calories and saturated fat intake less than/equal to 10%.",
        content2: "Please also select a corresponding calorie plan.",
        disclaimer: "Of course there is always the caveat the this may vary with individuals due to metabolism and activity level.")
  ];
}

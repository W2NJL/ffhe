import 'package:flutter/material.dart';
import 'package:fast_food_health_e/fitness_app/my_diary/my_diary_screen.dart';
import 'package:fast_food_health_e/screens/launch_screen.dart';
import 'package:fast_food_health_e/utils/constants.dart';

class MyDietPage extends StatefulWidget {
  MyDietPage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyDietPageState createState() => _MyDietPageState();
}

class _MyDietPageState extends State<MyDietPage> {


  String valueChoose;
  List listItem =[Constants.LOW_SODIUM_1, Constants.LOW_CALORIE_1, Constants.LOW_CARB, Constants.LOW_FAT, Constants.LOW_CHOLESTEROL,
  ];

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Select your Diet Plan'),
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back),
        onPressed: () =>    Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LaunchScreen())
        )      ),

    ),
    body:  ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Card(child:ListTile(
            title: Text("Dietary Restriction 1"),
            subtitle: Text("Range of calories from Y to Z."),
            leading: CircleAvatar(backgroundImage: NetworkImage("https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
            trailing: Icon(Icons.star))),
        Card(child:ListTile( title: Text("Dietary Restriction 2"),subtitle: Text("Range of carbs from Y to Z."), leading: CircleAvatar(backgroundImage: NetworkImage("https://miro.medium.com/fit/c/64/64/1*WSdkXxKtD8m54-1xp75cqQ.jpeg")), trailing:
        FloatingActionButton(
          // When the user presses the button, show an alert dialog containing
          // the text that the user has entered into the text field.
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Text("This is an explanation of dietary restriction 1."),
                );
              },
            );
          },
          tooltip: 'Show me the value!',
          child: const Icon(Icons.text_fields),
        ),)),
        Card(child:ListTile( title: Text("Dietary Restriction 3"),subtitle: Text("Range of fat from Y to Z."), leading:  CircleAvatar(backgroundImage: NetworkImage("https://miro.medium.com/fit/c/64/64/1*WSdkXxKtD8m54-1xp75cqQ.jpeg")), trailing: Icon(Icons.star))),
        Card(child:ListTile( title: Text("Dietary Restriction 4"),subtitle: Text("Range of sodium from Y to Z."), leading:  CircleAvatar(backgroundImage: NetworkImage("https://miro.medium.com/fit/c/64/64/1*WSdkXxKtD8m54-1xp75cqQ.jpeg")), trailing: Icon(Icons.star)))
      ],
    ),
  );
  }


  }


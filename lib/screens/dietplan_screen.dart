import 'package:flutter/material.dart';
import 'package:fast_food_health_e/fitness_app/my_diary/my_diary_screen.dart';
import 'package:fast_food_health_e/screens/launch_screen.dart';

class MyDietPage extends StatefulWidget {
  MyDietPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyDietPageState createState() => _MyDietPageState();
}

class _MyDietPageState extends State<MyDietPage> {
  String valueChoose;
  List listItem =["Low Sodium", "Low Calorie","Low Carb","Low Fat","Low Cholestrol","Vegetarian",
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
    body: Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right:16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15)
          ),
          child: DropdownButton(
            hint: Text("Choose your diet plan"),
            dropdownColor: Colors.blueGrey,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 36,
            isExpanded: true,
            underline: SizedBox(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 22
            ),
            value: valueChoose,
            onChanged: (newValue){
              setState((){
                valueChoose = newValue;
                storeDietPlan(valueChoose);
              });
            },
            items: listItem.map((valueItem){
              return DropdownMenuItem(
                  value: valueItem,
                  child: Text(valueItem),
              );
            }).toList(),
          ),
        ),
      ),

    ),
  );
  }


  }


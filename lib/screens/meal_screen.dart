import 'package:fast_food_health_e/widgets/appbar.dart';
import 'package:fast_food_health_e/widgets/new_nutritionixList.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/widgets/nutritionixList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealScreen extends StatelessWidget {

  final String restaurant;



  MealScreen({this.restaurant});

  @override
  Widget build(BuildContext context) {
    final title = "Choose a " + restaurant + " meal";

    List choices = const [
      const Choice(
          title: 'Entrees',
          imglink:
          'meatballs.jpg'),
      const Choice(
          title: 'Sides',

          imglink:
          'farhad-ibrahimzade-ou_7_3e-AqU-unsplash.jpg'),
      const Choice(
          title: 'Beverages',

          imglink:
          'elevate-snnhGYNqm44-unsplash.jpg'),


    ];

    return Scaffold(

        appBar: MyAppBar(

          route: 'pop',

          title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(title),),
          context: context,
        ),

        body: new ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: List.generate(choices.length, (index) {
              return Center(

                child: ChoiceCard(
                        choice: choices[index], restaurant: restaurant,item: choices[index]),
                  );

                })));
  }
}

class Choice {
  final String title;
  final String imglink;


  const Choice({this.title,  this.imglink});
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard(
      {Key key,
        this.choice,
        this.onTap,
        @required this.item,
        @required this.restaurant,
               this.selected: false})
      : super(key: key);

  final Choice choice;

  final String restaurant;



  final VoidCallback onTap;

  final Choice item;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline1;

    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => NewNutritionixList(restaurant: restaurant, mealCategory: choice.title)
            )
        );
      },
      child: Card(
          color: Colors.white,
          child: Column(
            children: [
              new Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("images\/" + choice.imglink), width: 300.w, height: 200.h,),
              new Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(choice.title, style: Theme.of(context).textTheme.bodyText1),
                    // Text(choice.date,
                    //     style: TextStyle(color: Colors.black.withOpacity(0.5))),
                    // Text(choice.description),
                  ],
                ),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          )),
    );
  }
}

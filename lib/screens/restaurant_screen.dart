import 'package:fast_food_health_e/screens/meal_screen.dart';
import 'package:fast_food_health_e/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/widgets/nutritionixList.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "Choose a restaurant";

    List choices = const [
      const Choice(
          title: 'Applebee\'s',
                   imglink:
          'applebees.png'),
      const Choice(
          title: 'Bob Evans',

          imglink:
          'bob_evans.png'),
      const Choice(
          title: 'Burger King',

          imglink:
          'bk.jpg'),
      const Choice(
          title: 'Chick-Fil-A',

          imglink:
          'chick-fil-a.gif'),
      const Choice(
          title: 'McDonald\'s',

          imglink:
          'mcdonalds.png'),
      const Choice(
          title: 'Olive Garden',

          imglink:
          'og.jpg'),
      const Choice(
          title: 'P.F. Chang\'s',

          imglink:
          'pfchangs.jpg'),
      const Choice(
          title: 'Panera Bread',

          imglink:
          'panera.jpg'),
      const Choice(
          title: 'Royal Farms',

          imglink:
          'royal_farms.jpg'),
      const Choice(
          title: 'SmashBurger',

          imglink:
          'smash.png'),
      const Choice(
          title: 'Taco Bell',

          imglink:
          'taco.png'),
      const Choice(
          title: 'Wawa',

          imglink:
          'wawa.jpg'),];

    return Scaffold(
        appBar: MyAppBar(

            route: '/home',

        title: Text(title),
          context: context,
    ),

            body: new ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: List.generate(choices.length, (index) {
                  return Center(

                      child: ChoiceCard(
                          choice: choices[index], item: choices[index]),
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
        this.selected: false})
      : super(key: key);

  final Choice choice;

  final VoidCallback onTap;

  final Choice item;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;

    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);

    return GestureDetector(
      onTap: () {


        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => MealScreen(restaurant: choice.title)
            )
        );
      },
      child: Card(
          color: Colors.white,
          child: Column(
            children: [
              new Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("images\/" + choice.imglink)),
              new Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(choice.title, style: Theme.of(context).textTheme.title),
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

import 'package:flutter/material.dart';
import 'package:fast_food_health_e/widgets/nutritionixList.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "Choose a restaurant";

    List choices = const [
      const Choice(
          title: 'Saladworks',
                   imglink:
          'saladworks.jpg'),
      const Choice(
          title: 'Royal Farms',

          imglink:
          'royal_farms.jpg'),
      const Choice(
          title: 'McDonalds',

          imglink:
          'mcdonalds.png'),
      const Choice(
          title: 'Five Guys',

          imglink:
          'five_guys.jpg'),
      const Choice(
          title: 'Chick-Fil-A',

          imglink:
          'chick-fil-a.gif'),
      const Choice(
          title: 'Bob Evans',

          imglink:
          'bob_evans.png'),
    ];

    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: new ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: List.generate(choices.length, (index) {
                  return Center(

                      child: ChoiceCard(
                          choice: choices[index], item: choices[index]),
                    );

                }))));
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
                builder: (context) => NutritionList(restaurant: choice.title)
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

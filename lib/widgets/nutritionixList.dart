
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fast_food_health_e/models/nutritionixCall.dart';
import 'package:fast_food_health_e/services/webservice.dart';
import 'package:fast_food_health_e/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class NutritionListState extends State<NutritionList> {


  final String restaurant;
  final String category;
  TapGestureRecognizer _flutterTapRecognizer;
  TapGestureRecognizer _githubTapRecognizer;
  static const String flutterUrl = 'https://flutter.io/';
  static const String githubUrl = 'http://www.codesnippettalk.com';





  NutritionListState({this.restaurant, this.category});

  List<NutritionixData> _nutritionixData = <NutritionixData>[];

  @override
  void initState() {
    super.initState();

    print(category);
    _populateNutritionListings(restaurant, category);
  }




  void _openUrl(String url) async {
    // Close the about dialog.
    Navigator.pop(context);

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  static Widget _buildAboutDialog(BuildContext context, NutritionixData restaurant) {
    return new AlertDialog(
      title: Text(restaurant.nutritionFields.itemName),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(restaurant),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Add to My Day'),
        ),
      ],
    );
  }

  static Widget _buildAboutText(NutritionixData restaurant) {
    return new RichText(
      text: new TextSpan(
        text: 'Calories: ' + restaurant.nutritionFields.nfCalories.toString() + " calories" + '\n\n' +
            'Sodium: ' + restaurant.nutritionFields.nfSodium.toString() + " mg" + '\n\n' +
            'Total Fat: '  + restaurant.nutritionFields.nfFat.toString() + " g" + '\n\n' +
            'Sugars: ' + restaurant.nutritionFields.nfSugars.toString() + " g" + '\n\n' +
            'Fiber: '  + restaurant.nutritionFields.nfFiber.toString() + " g" + '\n\n' +
            'Cholesterol: ' + restaurant.nutritionFields.nfCholesterol.toString() + " mg" + '\n\n',
        style: const TextStyle(color: Colors.black87),
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
      ),
    );
  }

  // static Widget _buildLogoAttribution() {
  //   return new Padding(
  //     padding: const EdgeInsets.only(top: 16.0),
  //     child: new Row(
  //       children: <Widget>[
  //         new Padding(
  //           padding: const EdgeInsets.only(top: 0.0),
  //           child: new Image.asset(
  //             "assets/flutter.jpeg",
  //             width: 32.0,
  //           ),
  //         ),
  //         const Expanded(
  //           child: const Padding(
  //             padding: const EdgeInsets.only(left: 12.0),
  //             child: const Text(
  //               'Popup window is like a dialog box that gains complete focus when it appears on screen.',
  //               style: const TextStyle(fontSize: 12.0),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }



  void _populateNutritionListings(String restaurant, String category) {

    print(category);

    print(restaurant);

    Webservice().load(NutritionixData.get(restaurant, category)).then((nutritionListings) => {



      setState(() => {
        _nutritionixData = nutritionListings
      })
    });



  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: Text(_nutritionixData[index].nutritionFields.itemName, style: TextStyle(fontSize: 18)),
      subtitle: Text("Calories: " + _nutritionixData[index].nutritionFields.nfCalories.toString(), style: TextStyle(fontSize: 18)),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(category + " from " + restaurant),
        ),
        body: new ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: List.generate(_nutritionixData.length, (index) {
              return Center(

                child: ChoiceCard(
                    choice: _nutritionixData[index].nutritionFields.itemName, nutrition: _nutritionixData[index], item: _nutritionixData[index].nutritionFields.itemName),
              );

            })));
  }




}





class ChoiceCard extends StatelessWidget {
  const ChoiceCard(
      {Key key,
        this.choice,
        @required this.nutrition,
        this.onTap,
        @required this.item,
        this.selected: false})
      : super(key: key);

  final String choice;

  final NutritionixData nutrition;

  final VoidCallback onTap;

  final String item;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;

    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => NutritionListState._buildAboutDialog(context, nutrition),
        );
        // Perform some action
      },
      child: Card(
          color: Colors.white,
          child: Column(
            children: [
              new Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(choice, style: Theme.of(context).textTheme.title),
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







class NutritionList extends StatefulWidget {
  final String restaurant;
  final String mealCategory;



  NutritionList({this.restaurant, this.mealCategory});

  @override
  createState() => NutritionListState(restaurant: restaurant, category: mealCategory);
}
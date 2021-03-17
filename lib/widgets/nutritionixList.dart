
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fast_food_health_e/models/nutritionixCall.dart';
import 'package:fast_food_health_e/services/webservice.dart';
import 'package:fast_food_health_e/utils/constants.dart';

class NutritionListState extends State<NutritionList> {


  final String restaurant;





  NutritionListState({this.restaurant});

  List<NutritionixData> _nutritionixData = <NutritionixData>[];



  @override
  void initState() {
    super.initState();
    _populateNewsArticles(restaurant);
  }

  void _populateNewsArticles(String restaurant) {





    Webservice().load(NutritionixData.get(restaurant)).then((newsArticles) => {
      setState(() => {
        _nutritionixData = newsArticles
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
          title: Text('You chose ' + restaurant),
        ),
        body: ListView.builder(
          itemCount: _nutritionixData.length,
          itemBuilder: _buildItemsForListView,
        )
    );
  }
}

class NutritionList extends StatefulWidget {
  final String restaurant;



  NutritionList({this.restaurant});

  @override
  createState() => NutritionListState(restaurant: restaurant);
}
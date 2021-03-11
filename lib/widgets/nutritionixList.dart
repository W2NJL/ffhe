
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fast_food_health_e/models/nutritionixCall.dart';
import 'package:fast_food_health_e/services/webservice.dart';
import 'package:fast_food_health_e/utils/constants.dart';

class NutritionListState extends State<NutritionList> {

  List<NutritionixData> _nutritionixData = <NutritionixData>[];

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
  }

  void _populateNewsArticles() {

    Webservice().load(NutritionixData.all).then((newsArticles) => {
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
          title: Text('You chose Bob Evans'),
        ),
        body: ListView.builder(
          itemCount: _nutritionixData.length,
          itemBuilder: _buildItemsForListView,
        )
    );
  }
}

class NutritionList extends StatefulWidget {

  @override
  createState() => NutritionListState();
}
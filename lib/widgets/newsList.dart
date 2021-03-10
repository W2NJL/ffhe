
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fast_food_health_e/models/newsArticle.dart';
import 'package:fast_food_health_e/services/webservice.dart';
import 'package:fast_food_health_e/utils/constants.dart';

class NewsListState extends State<NewsList> {

  List<NewsArticle> _newsArticles = List<NewsArticle>();

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
  }

  void _populateNewsArticles() {

    Webservice().load(NewsArticle.all).then((newsArticles) => {
      setState(() => {
        _newsArticles = newsArticles
      })
    });

  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: Text(_newsArticles[index].mrsFields.itemName, style: TextStyle(fontSize: 18)),
      subtitle: Text("Calories: " + _newsArticles[index].mrsFields.nfCalories.toString(), style: TextStyle(fontSize: 18)),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('You chose Bob Evans'),
        ),
        body: ListView.builder(
          itemCount: _newsArticles.length,
          itemBuilder: _buildItemsForListView,
        )
    );
  }
}

class NewsList extends StatefulWidget {

  @override
  createState() => NewsListState();
}
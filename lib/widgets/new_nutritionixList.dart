import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewNutritionixList extends StatefulWidget {
  final String restaurant;
  final String mealCategory;

  NewNutritionixList({this.restaurant, this.mealCategory});

  @override
  State<StatefulWidget> createState() => new NewNutritionixListState(restaurant: restaurant, category: mealCategory);
}

class NewNutritionixListState extends State<NewNutritionixList> {
  final String restaurant;
  final String category;
  static int page = 0;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  List users = new List();
  final dio = new Dio();

  NewNutritionixListState({this.restaurant, this.category});

  @override
  void initState() {
    page = 0;
    this._getMoreData(page, this.restaurant, this.category);
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels ==
          _sc.position.maxScrollExtent) {
        _getMoreData(page, this.restaurant, this.category);
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(restaurant),
      ),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: users.length + 1, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == users.length) {
          return _buildProgressIndicator();
        } else {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildAboutDialog(context, users[index]  ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
// backgroundImage: NetworkImage(
// users[index]['picture']['large'],
// ),
              ),
              title: Text((users[index]['fields']['item_name'])),
              subtitle: Text((users[index]['fields']['nf_calories'].toString()) + ' calories'),
            ),
          );
        }
      },
      controller: _sc,
    );
  }

  static Widget _buildAboutDialog(BuildContext context, user) {
    return new AlertDialog(
      title: Text(user['fields']['item_name']),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(user),
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

  static Widget _buildAboutText(user) {
    return new RichText(
      text: new TextSpan(
        text: 'Calories: ' + user['fields']['nf_calories'].toString() + " calories" + '\n\n' +
            'Sodium: ' + user['fields']['nf_sodium'].toString() + " mg" + '\n\n' +
            'Total Fat: '  + user['fields']['nf_total_fat'].toString() + " g" + '\n\n' +
            'Cholesterol: ' + user['fields']['nf_cholesterol'].toString() + " mg" + '\n\n',
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

  void _getMoreData(int index, String restaurant, String category) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var url = 'https://api.nutritionix.com/v1_1/search/' + restaurant + '?results='+ index.toString() + ':' + (index+50).toString() + '&fields=item_name,brand_name,nf_calories,nf_sodium,nf_sugars,nf_cholesterol,nf_total_fat,nf_dietary_fiber&appId=816cee15&appKey=aab0a0a4c4224eca770bf5a2a0f4c984';
      print(url);
      final response = await dio.get(url);
      List tList = new List();
      for (int i = 0; i < response.data['hits'].length; i++) {
        if(determineFood(response.data['hits'][i]['fields']['item_name']) == category) {
          tList.add(response.data['hits'][i]);
        }
        print(response.data['hits'][i]['fields']['item_name']);
        print(determineFood(response.data['hits'][i]['fields']['item_name']));
      }

      setState(() {
        isLoading = false;
        users.addAll(tList);
        page+=10;
      });
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  determineFood(String category) {

    String categoryWord;
    const int categories = 3;
    final beverageReg =  RegExp("(?:coke|tea|dr. pepper|pepsi|sprite|orange juice|coffee|milk|root beer|latte|cola|mocha|americano|frappe|shake)", caseSensitive: false);
    final entreeReg =  RegExp("(?:salad|sandwich|soup|burger|pasta|gyro|hoagie|buffalo|sandwich|nuggets|filet|strips|pounder|tenders|mac|chicken|tacos|quesadilla|waffle|toast|pancake|omelette|omelet|sausage|breakfast|bagel|egg|muffin|hotcakes|steak|burrito|pie|fritter)", caseSensitive: false);

    final sideReg =  RegExp("(?:dressing|drink|mustard|jelly|peanuts|coleslaw|sauce|lemonade|fries|milk|potato|corn|rice|balsamic|beans|blue cheese)", caseSensitive: false);



    bool getCategory(int i, String string){
      if(i==0){
        return entreeReg.hasMatch(string);
      }
      else if(i==1){
        return sideReg.hasMatch(string);
      }
      else if(i==2){
        return beverageReg.hasMatch(string);
      }

      return false;
    }


    String getCategoryWord(int i){


      if(i==0){
        return "Entrees";
      }
      else if(i==1){
        return "Sides";
      }
      else if(i==2){
        return "Beverages";
      }

      return null;


    }

    for(int i=0; i < categories; i++){
      if (getCategory(i, category))
        categoryWord = getCategoryWord(i);
    }





    return categoryWord;
  }

  _buildAboutDialog2(BuildContext context, user) {}

}
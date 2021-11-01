import 'dart:convert';

import 'package:fast_food_health_e/screens/meal_screen.dart';
import 'package:fast_food_health_e/utils/debouncer.dart';
import 'package:fast_food_health_e/utils/helperFunctions.dart';
import 'package:fast_food_health_e/widgets/appbar.dart';
import 'package:fast_food_health_e/widgets/navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/widgets/nutritionixList.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class NationwideRestaurantScreen extends StatefulWidget {
  @override
  _NationwideRestaurantScreenState createState() => _NationwideRestaurantScreenState();
}



class _NationwideRestaurantScreenState extends State<NationwideRestaurantScreen>  {
  final _debouncer = Debouncer(milliseconds: 500);
  HelperFunctions helperFunctions = new HelperFunctions();
  Dio _dio = new Dio();
  List<Choice> choices = <Choice>[];
  http.Client client;



  Future<List<Choice>> getChoices() async{



    var response = await http.get(Uri.parse('https://d1gvlspmcma3iu.cloudfront.net/restaurants-3d-party.json.gz'));


    //

    var decodedFromTVStudyServer = jsonDecode(response.body);





    final parsed = decodedFromTVStudyServer.cast<Map>();


    choices = parsed.map<Choice>(


            (json) => Choice(json))
        .toList();

    choices.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });



    return choices;

  }

  @override
  void initState() {






    super.initState();


  }









  @override
  Widget build(BuildContext context) {
    var title = "Choose a restaurant";



    // getTown () async{
    //
    //
    //
    //   await helperFunctions.getLocationFromCoordinates(coordinates).then((value) {
    //
    //
    //
    //     title = value;
    //
    //
    //
    //   });
    // }



    // getTown();



    // List choices = const [
    //   const Choice(
    //       name: 'Applebee\'s',
    //                imglink:
    //       'applebees.png'),
    //   const Choice(
    //       name: 'Bob Evans',
    //
    //       imglink:
    //       'bob_evans.png'),
    //   const Choice(
    //       name: 'Burger King',
    //
    //       imglink:
    //       'bk.jpg'),
    //   const Choice(
    //       name: 'Chick-Fil-A',
    //
    //       imglink:
    //       'chick-fil-a.gif'),
    //   const Choice(
    //       name: 'McDonald\'s',
    //
    //       imglink:
    //       'mcdonalds.png'),
    //   const Choice(
    //       name: 'Olive Garden',
    //
    //       imglink:
    //       'og.jpg'),
    //   const Choice(
    //       name: 'P.F. Chang\'s',
    //
    //       imglink:
    //       'pfchangs.jpg'),
    //   const Choice(
    //       name: 'Panera Bread',
    //
    //       imglink:
    //       'panera.jpg'),
    //   const Choice(
    //       name: 'Royal Farms',
    //
    //       imglink:
    //       'royal_farms.jpg'),
    //   const Choice(
    //       name: 'SmashBurger',
    //
    //       imglink:
    //       'smash.png'),
    //   const Choice(
    //       name: 'Taco Bell',
    //
    //       imglink:
    //       'taco.png'),
    //   const Choice(
    //       name: 'Wawa',
    //
    //       imglink:
    //       'wawa.jpg'),];

    return Scaffold(
      drawer: NavDrawer(),
      appBar: MyAppBar(

          route: '/home',

          title:
                  Text(


                      'Nationwide Restaurants'
                  ),context: context),


      body:  FutureBuilder(future:     getChoices(),
        builder: (context,  AsyncSnapshot <List<Choice>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                children: [
                  Center(child: CircularProgressIndicator()),
                  Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.black12,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  )],
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
choices = snapshot.data;
print(snapshot.data);


return
    Column(
    children: [
    StatefulBuilder(builder:
    (BuildContext context, StateSetter setState) {
    return Expanded(child: Column(
    children: [
    TextField(
    decoration: InputDecoration(
    contentPadding: EdgeInsets.all(15.0),
    hintText: "Type in a restaurant",
    ),
    onChanged: (string) {
    _debouncer.run(() {
    setState(() {
    choices = snapshot.data
        .where((u) => (helperFunctions.fixName(u.name)
        .toLowerCase()
        .contains(helperFunctions.fixName(string).toLowerCase())))
        .toList();
    });
    });
    },
    ),
    Expanded(
      child: ListView.builder(
      itemCount: choices.length,itemBuilder: (BuildContext context,int index){

      return ChoiceCard(choice: choices.elementAt(index));
      }
      ),
      ),


    ],
    ));},
    )]);
            //Sort by distance


           }



          else {

            return Text(
              "Could Not Obtain Location",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );}
        },
      ),);


  }}

class Choice {
  final String name;
  Choice._({this.name});



  factory Choice(Map json) => Choice._(




      name: json['name'].toString(),



    );


  @override toString() => 'Name: $name';
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
    TextStyle textStyle = Theme.of(context).textTheme.headline1;

    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);

    return GestureDetector(
      onTap: () {


        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => MealScreen(restaurant: choice.name)
            )
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 300,
        child: Card(


            color: Colors.white,
            child: Column(
              children: [
                new Container(
                  width: 200,
                  height: 200,
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network("https://logo.clearbit.com/" + fixName(choice.name) + ".com",
                      errorBuilder: (context, error, StackTrace){
                        return Image.network(


                            "https://static.wixstatic.com/media/7d5dd4_7314dd4e69d3447e8fcf6319495fdb80~mv2.png/v1/fill/w_150,h_150,al_c,q_85,usm_0.66_1.00_0.01/FastFoodHealthELogo.webp"
                        );
                      },),
                    ),


                new Container(
                  padding: const EdgeInsets.all(10.0),
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(fit: BoxFit.scaleDown,child: Text(choice.name, style: Theme.of(context).textTheme.headline6)
                      ),
                      // Text(choice.date,
                      //     style: TextStyle(color: Colors.black.withOpacity(0.5))),
                      // Text(choice.description),
                    ],
                  ),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            )),
      ),
    );
  }

  String fixName(String name) {
    name = name.replaceAll(" ", "");
    name = name.replaceAll("'", "");
    return name;

  }
}
import 'dart:convert';

import 'package:fast_food_health_e/screens/meal_screen.dart';
import 'package:fast_food_health_e/utils/helperFunctions.dart';
import 'package:fast_food_health_e/widgets/appbar.dart';
import 'package:fast_food_health_e/widgets/navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/widgets/nutritionixList.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class RestaurantScreen extends StatefulWidget {
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}



class _RestaurantScreenState extends State<RestaurantScreen>  {
  HelperFunctions helperFunctions = new HelperFunctions();
  List<double> coordinates;
  Dio _dio = new Dio();
  List<Choice> choices = <Choice>[];
  http.Client client;



  getChoices() async{

    print("Hey yaaaaa!");

    var response = await http.get(Uri.parse('https://d1gvlspmcma3iu.cloudfront.net/restaurants-3d-party.json.gz'));




   //print(response.body);
    print(response.body);

    print('Love is a losing game ' + coordinates.elementAt(0).toString());

    //var response2 = await http.get(Uri.parse('https://api.tomtom.com/search/2/categorySearch/fast%20food.json?lat='+coordinates.elementAt(0).toString()+'&lon='+coordinates.elementAt(1).toString()+'&key=Ui6wPx3DtzvDbWaAgwiQLfGAgIXTj8Ff'));

    Response<dynamic> response2 = await _dio.get('https://api.tomtom.com/search/2/categorySearch/fast%20food.json?lat='+coordinates.elementAt(0).toString()+'&lon='+coordinates.elementAt(1).toString()+'&key=Ui6wPx3DtzvDbWaAgwiQLfGAgIXTj8Ff');

    print(response2.data['results'][0]['poi']['name']);

   var convertDataToJson  = response2.data['results'] as List;

  print(convertDataToJson );

  choices = convertDataToJson.map((e) => Choice.fromJson(e)).toList();

    //print(convertDataToJson.first);

    // choices = (json.decode(response2.data['results'])as List)
    //      .map((data) => Choice.fromJson(data))
    //      .toList();





  print(choices.length);

    return choices;

  }

  @override
  void initState() {


    _getCurrentLocation();



    super.initState();


  }

  _getCurrentLocation() async{
    await helperFunctions.getCoordinates().then((value)  => setState(() {
      print("Got here!");

      coordinates = value;



    }));





  }

  @override
  Widget build(BuildContext context) {
    var title = "Choose a restaurant";

    Future<String> getCoordinates () async{

      await helperFunctions.getCoordinates().then((value) {
          print("Got here!");

        coordinates = value;

        print("Coordinates: "  + coordinates.first.toString());

        return coordinates.first.toString();

      });
    }

    // getTown () async{
    //
    //   print(coordinates.first.toString());
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

        title: FutureBuilder(future:     helperFunctions.getLocationFromCoordinates(coordinates),
          builder: (context,  AsyncSnapshot snapshot) {
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
                      ),
                    )
                  ],
                ),
              );
            }



            if (snapshot.connectionState == ConnectionState.done) {
              //Sort by distance


              return
                Text(


                    snapshot.data
                );
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
        ),context: context),

            body:  FutureBuilder(future:     getChoices(),
    builder: (context,  AsyncSnapshot snapshot) {
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
        //Sort by distance


        return
        ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: List.generate(snapshot.data.length, (index) {
          return Center(

            child: ChoiceCard(
                choice: choices[index], item: choices[index]),
    );
    }));}



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


  const Choice({this.name});

  factory Choice.fromJson(Map<String, dynamic> json) {

    return new Choice(

      name: json['poi']['name'],

    );
  }
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
      child: Card(
          color: Colors.white,
          child: Column(
            children: [
              new Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network("https://logo.clearbit.com/" + fixName(choice.name) + ".com")),
              new Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(choice.name, style: Theme.of(context).textTheme.bodyText1),
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

  String fixName(String name) {
    name = name.replaceAll(" ", "");
    name = name.replaceAll("'", "");
    return name;

  }
}

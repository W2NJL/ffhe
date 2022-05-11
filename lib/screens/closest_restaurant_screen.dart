import 'dart:convert';
import 'dart:ffi';

import 'package:fast_food_health_e/screens/meal_screen.dart';
import 'package:fast_food_health_e/utils/helperFunctions.dart';
import 'package:fast_food_health_e/widgets/appbar.dart';
import 'package:fast_food_health_e/widgets/navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/widgets/nutritionixList.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class LocalRestaurantScreen extends StatefulWidget {
  @override
  _LocalRestaurantScreenState createState() => _LocalRestaurantScreenState();
}



class _LocalRestaurantScreenState extends State<LocalRestaurantScreen>  {
  HelperFunctions helperFunctions = new HelperFunctions();
  List<double> coordinates;
  Dio _dio = new Dio();
  List<Choice> choices = <Choice>[];
  http.Client client;



  getChoices() async{



    var response = await _dio.get('https://d1gvlspmcma3iu.cloudfront.net/restaurants-3d-party.json.gz');







    //var response2 = await http.get(Uri.parse('https://api.tomtom.com/search/2/categorySearch/fast%20food.json?lat='+coordinates.elementAt(0).toString()+'&lon='+coordinates.elementAt(1).toString()+'&key=Ui6wPx3DtzvDbWaAgwiQLfGAgIXTj8Ff'));

    Response<dynamic> response2 = await _dio.get('https://api.tomtom.com/search/2/categorySearch/fast%20food.json?lat='+coordinates.elementAt(0).toString()+'&lon='+coordinates.elementAt(1).toString()+'&key=Ui6wPx3DtzvDbWaAgwiQLfGAgIXTj8Ff');





 Dio dio = new Dio();
 dio.options.headers['Content-Type'] = 'application/json';
 dio.options.headers['x-app-id'] = 'ac70f0ef';
 dio.options.headers['x-app-key'] = 'cef8812f8909504292eacbd1a11acf5e';
 
 Response<dynamic> response3 = await dio.get('https://trackapi.nutritionix.com/v2/locations?ll='+coordinates.elementAt(0).toString()+','+coordinates.elementAt(1).toString()+'&distance=50000m&limit=50');



    var convertDataToJson  = response3.data['locations'] as List;


    var names = response.data as List;



    List tList = new List();



    for(int i=0; i<convertDataToJson.length; i++){

      convertDataToJson[i]['distance'] = "20";
        tList.add(convertDataToJson[i]);



    }





  choices = tList.map((e) => Choice.fromJson(e)).toList();

    //

    // choices = (json.decode(response2.data['results'])as List)
    //      .map((data) => Choice.fromJson(data))
    //      .toList();







    return choices;

  }

  @override
  void initState() {



_getCurrentLocation();


    super.initState();


  }

  _getCurrentLocation() async{
    await helperFunctions.getCoordinates().then((value)  => setState(() {


      coordinates = value;



    }));





  }

  @override
  Widget build(BuildContext context) {
    var title = "Choose a restaurant";

    Future<String> getCoordinates () async{

      await helperFunctions.getCoordinates().then((value) {


        coordinates = value;



        return coordinates.first.toString();

      });
    }

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

    return WillPopScope(
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('Warning'),
          content: Text('Do you really want to exit restaurant search?'),
          actions: [
            FlatButton(
              child: Text('Yes'),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false),
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      ),
      child: Scaffold(
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
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child:


                    Text(


                      snapshot.data + ' nearby restaurants'
                  ));
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
  ),),
    );


}}



class Choice {
  final String name;
  final String address;
  final String city;
  final String state;
  final String distance;
  final String latitude;
  final String longitude;




  const Choice({this.name, this.city, this.state, this.address, this.distance, this.latitude, this.longitude});

  factory Choice.fromJson(Map<String, dynamic> json) {

    return new Choice(

      name: json['name'],
      address: json['address'],
        city: json['city'],
        state: json['state'],
        distance:  json['distance'],






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
    HelperFunctions helperFunctions = new HelperFunctions();

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

        height: 280,
        width: 350,
        child: Card(

            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Container(
                  height: 100,
                    width: 100,
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network("https://logo.clearbit.com/" + helperFunctions.fixName(choice.name) + ".com"

                    ,errorBuilder: (context, error, StackTrace){
                        return Image.network(


                            "https://static.wixstatic.com/media/7d5dd4_7314dd4e69d3447e8fcf6319495fdb80~mv2.png/v1/fill/w_150,h_150,al_c,q_85,usm_0.66_1.00_0.01/FastFoodHealthELogo.webp"
                        );
                      })),
                new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(choice.name, style: Theme.of(context).textTheme.headline4),
                      Text(choice.distance + ' mi.', style: Theme.of(context).textTheme.headline5),
                      Row(children: [Expanded(child: Text(choice.address, style: Theme.of(context).textTheme.bodyText2,
                        maxLines: 2, // you can change it accordingly
                        overflow: TextOverflow.ellipsis,),
                        )]),
                        Text(choice.city + ", " + choice.state, style: Theme.of(context).textTheme.bodyText2),
                       ],),

                      // Text(choice.date,
                      //     style: TextStyle(color: Colors.black.withOpacity(0.5))),
                      // Text(choice.description),

                  ),

              ]

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

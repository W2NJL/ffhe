import 'package:dio/dio.dart';
import 'package:fast_food_health_e/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as Math;
import 'package:us_states/us_states.dart';

class HelperFunctions{

  ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    minimumSize: Size(88, 44),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    backgroundColor: Colors.blue,
  );

  void storeCoordinatesInSharedPrefs(Position position) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble("latitude", position.latitude);
    preferences.setDouble("longitude", position.longitude);

  }

  Future <List<double>> getCoordinates() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List <double> coordinates = <double>[];

    coordinates.add(preferences.getDouble("latitude"));
    coordinates.add(preferences.getDouble("longitude"));
    return coordinates;
  }


  Future<String> getCoordinatesFromLocation(String location, List<double> myCoords) async {


    String geocodeURI = 'https://app.geocodeapi.io/api/v1/search?text=' +
        location + '&apikey=a7abd6d0-4bb1-11ec-95f9-b1fb413adb6c';
    try {
      Dio _dio = new Dio();

      Response<dynamic> response = await _dio.get(
          geocodeURI);
      final geoLocatorResponse = new Map<String, dynamic>.from(response.data);
      final theResponse = geoLocatorResponse['features'][0]['geometry']['coordinates'];



      var distance = Geolocator.distanceBetween(myCoords.elementAt(0), myCoords.elementAt(1), theResponse[1], theResponse[0]);



      return (distance*0.000621).toStringAsPrecision(2);
    }
    catch (exception) {


      throw Exception(exception);
    }
  }


  Future<String> getLocationFromCoordinates(List<double> coords) async {

    List<Placemark> locationPlacemarks = await placemarkFromCoordinates(coords.elementAt(0), coords.elementAt(1));

    String city = locationPlacemarks[0].locality.toString();
    String state = locationPlacemarks[0].administrativeArea.toString();



    return city + ", " + state;
  }

  String fixName(String name) {
    name = name.replaceAll(" ", "");
    name = name.replaceAll("'", "");
    name = name.replaceAll("-", "");
    return name;

  }
}
import 'package:fast_food_health_e/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as Math;

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

  Future<String> getLocationFromCoordinates(List<double> coords) async {

    List<Placemark> locationPlacemarks = await placemarkFromCoordinates(coords.elementAt(0), coords.elementAt(1));

    String city = locationPlacemarks[0].locality.toString();
    String state = locationPlacemarks[0].administrativeArea.toString();



    return city + ", " + state;
  }


}
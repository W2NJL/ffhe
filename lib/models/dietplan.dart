import 'package:flutter/material.dart';

class DietPlan {
  String title;
  String level;
  double indicatorValue;
  int price;
  String content;
  String content2;
  String disclaimer;
  NetworkImage image;
  int number;
  int satFat;
  int transFat;

  DietPlan(
      {this.title, this.level, this.indicatorValue, this.price, this.content, this.content2, this.disclaimer, this.number, this.satFat, this.transFat, this.image});
}

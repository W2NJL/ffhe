

import 'package:fast_food_health_e/state/FastFoodHealthEState.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FastFoodHealthEUser {

final String caloriePlan;
final String sodiumPlan;
final String fatPlan;
final String cholesterolPlan;
final String carbPlan;
final String mealPref;
final int calMaxValue, sodiumMaxValue, carbsMaxValue, cholesterolmaxValue, fatMaxValue, saturatedFatMaxValue, transFatMaxValue;
final int todaysCal, todaysSodium, todaysCarbs, todaysCholesterol, todaysFat, todaysSaturatedFat, todaysTransFat;
final Map<String, dynamic> restaurantList;
final Map<String, dynamic> favsList;


FastFoodHealthEUser(this.restaurantList, this.mealPref, this.sodiumMaxValue, this.carbsMaxValue, this.cholesterolmaxValue, this.fatMaxValue, this.saturatedFatMaxValue, this.transFatMaxValue, this.todaysCal, this.todaysSodium, this.todaysCarbs, this.todaysCholesterol, this.todaysFat, this.todaysSaturatedFat, this.todaysTransFat, this.favsList, { this.caloriePlan, this.sodiumPlan, this.fatPlan, this.cholesterolPlan, this.carbPlan, this.calMaxValue});




FastFoodHealthEUser.fromJson(Map<String, dynamic> parsedJson, BuildContext context)
  :
      caloriePlan = parsedJson['DietPlan'],
      mealPref = parsedJson['MealPref'],
      sodiumPlan = parsedJson['Sodium'],
      fatPlan = parsedJson['Low Fat'],
      carbPlan = parsedJson['Low Carb'],
      cholesterolPlan = parsedJson['Low Cholesterol'],
calMaxValue = parsedJson['DietVals']['Calories']['MaxValue'],
sodiumMaxValue = parsedJson['DietVals'].containsKey('Sodium') ? parsedJson['DietVals']['Sodium']['MaxValue']: null,
      cholesterolmaxValue = parsedJson['DietVals'].containsKey('Low Cholesterol') ? parsedJson['DietVals']['Low Cholesterol']['MaxValue']: null,
      saturatedFatMaxValue = parsedJson['DietVals'].containsKey('Saturated Fat') ? parsedJson['DietVals']['Saturated Fat']['MaxValue']: null,
      transFatMaxValue = parsedJson['DietVals'].containsKey('Trans Fat') ?  parsedJson['DietVals']['Trans Fat']['MaxValue']: null,
      fatMaxValue = parsedJson['DietVals'].containsKey('Low Fat') ? parsedJson['DietVals']['Low Fat']['MaxValue']: null,
      carbsMaxValue = parsedJson['DietVals'].containsKey('Low Carb') ? parsedJson['DietVals']['Low Carb']['MaxValue']: null,



todaysCal = parsedJson['DietVals'].containsKey(getDate(context)) ? parsedJson['DietVals'][getDate(context)]['Calories']: 0,
todaysCarbs = parsedJson['DietVals'].containsKey(getDate(context))  ? parsedJson['DietVals'][getDate(context)]['Low Carb']: 0,
todaysSodium = parsedJson['DietVals'].containsKey(getDate(context))  ? parsedJson['DietVals'][getDate(context)]['Sodium']: 0,
todaysCholesterol = parsedJson['DietVals'].containsKey(getDate(context))  ? parsedJson['DietVals'][getDate(context)]['Low Cholesterol']: 0,
todaysFat = parsedJson['DietVals'].containsKey(getDate(context))  ? parsedJson['DietVals'][getDate(context)]['Low Fat']: 0,
todaysSaturatedFat = parsedJson['DietVals'].containsKey(getDate(context)) ? parsedJson['DietVals'][getDate(context)]['Saturated Fat']: 0,
todaysTransFat = parsedJson['DietVals'].containsKey(getDate(context))  ? parsedJson['DietVals'][getDate(context)]['Trans Fat']: 0,
restaurantList = parsedJson['DietVals'].containsKey(getDate(context)) ? parsedJson['DietVals'][getDate(context)].containsKey('Meals')  ? new Map<String, dynamic>.from(parsedJson['DietVals'][getDate(context)]['Meals']): null: null,
favsList = parsedJson.containsKey('Favorites') ? new Map<String, dynamic>.from(parsedJson['Favorites']): null;


}


String getDate(BuildContext context) {
  var now = Provider.of<FastFoodHealthEState>(context, listen: false).date;

  var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  return formattedDate;
}


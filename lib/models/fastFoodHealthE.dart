import 'package:intl/intl.dart';

class FastFoodHealthEUser {

final String caloriePlan;
final String sodiumPlan;
final String fatPlan;
final String cholesterolPlan;
final String carbPlan;
final int calMaxValue, sodiumMaxValue, carbsMaxValue, cholesterolmaxValue, fatMaxValue, saturatedFatMaxValue, transFatMaxValue;
final int todaysCal, todaysSodium, todaysCarbs, todaysCholesterol, todaysFat, todaysSaturatedFat, todaysTransFat;
final Map<String, dynamic> restaurantList;


FastFoodHealthEUser(this.restaurantList, this.sodiumMaxValue, this.carbsMaxValue, this.cholesterolmaxValue, this.fatMaxValue, this.saturatedFatMaxValue, this.transFatMaxValue, this.todaysCal, this.todaysSodium, this.todaysCarbs, this.todaysCholesterol, this.todaysFat, this.todaysSaturatedFat, this.todaysTransFat, { this.caloriePlan, this.sodiumPlan, this.fatPlan, this.cholesterolPlan, this.carbPlan, this.calMaxValue});




FastFoodHealthEUser.fromJson(Map<String, dynamic> parsedJson)
  :
      caloriePlan = parsedJson['DietPlan'],
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



todaysCal = parsedJson['DietVals'].containsKey(getDate()) ? parsedJson['DietVals'][getDate()]['Calories']: 0,
todaysCarbs = parsedJson['DietVals'].containsKey(getDate())  ? parsedJson['DietVals'][getDate()]['Low Carb']: 0,
todaysSodium = parsedJson['DietVals'].containsKey(getDate())  ? parsedJson['DietVals'][getDate()]['Sodium']: 0,
todaysCholesterol = parsedJson['DietVals'].containsKey(getDate())  ? parsedJson['DietVals'][getDate()]['Low Cholesterol']: 0,
todaysFat = parsedJson['DietVals'].containsKey(getDate())  ? parsedJson['DietVals'][getDate()]['Low Fat']: 0,
todaysSaturatedFat = parsedJson['DietVals'].containsKey(getDate()) ? parsedJson['DietVals'][getDate()]['Saturated Fat']: 0,
todaysTransFat = parsedJson['DietVals'].containsKey(getDate())  ? parsedJson['DietVals'][getDate()]['Trans Fat']: 0,
restaurantList = parsedJson['DietVals'].containsKey(getDate())? new Map<String, dynamic>.from(parsedJson['DietVals'][getDate()]['Meals']): null;



}


String getDate() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  return formattedDate;
}


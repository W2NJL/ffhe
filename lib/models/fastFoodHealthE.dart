class FastFoodHealthEUser {

final String caloriePlan;
final String sodiumPlan;
final String fatPlan;
final String cholesterolPlan;
final String carbPlan;

FastFoodHealthEUser({ this.caloriePlan, this.sodiumPlan, this.fatPlan, this.cholesterolPlan, this.carbPlan});

FastFoodHealthEUser.fromJson(Map<String, dynamic> parsedJson)
  :
      caloriePlan = parsedJson['DietPlan'],
      sodiumPlan = parsedJson['Sodium'],
      fatPlan = parsedJson['Low Fat'],
      carbPlan = parsedJson['Low Carb'],
      cholesterolPlan = parsedJson['Low Cholesterol'];





}



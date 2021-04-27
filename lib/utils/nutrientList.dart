class NutrientList  {





  static int _nf_calories;
 static int _nf_sodium;


  static int _nf_total_fat;
  static int _nf_saturated_fat;
  static int _nf_trans_fatty_acids;
  static int _nf_cholesterol;
  static int _total_carbohydrate;



  static int get nf_saturated_fat => _nf_saturated_fat;

  static set nf_saturated_fat(int value) {
    _nf_saturated_fat = value;
  }

  static Map<String, dynamic> get listOfNutrients  => {








  "nf_total_fat": _nf_total_fat,
  "nf_sodium": _nf_sodium,
  "nf_calories": _nf_calories,
    "nf_saturated_fat": _nf_saturated_fat,
    "nf_trans_fatty_acid": _nf_trans_fatty_acids,
    "nf_cholesterol": _nf_cholesterol,
    "nf_total_carbohydrate": _total_carbohydrate,

};

  static int get nf_calories => _nf_calories;

  static set nf_calories(int value) {
    _nf_calories = value;
  }

  static int get nf_sodium => _nf_sodium;

  static int get nf_total_fat => _nf_total_fat;

  static set nf_total_fat(int value) {
    _nf_total_fat = value;
  }

  static set nf_sodium(int value) {
    _nf_sodium = value;
  }

  static int get nf_trans_fatty_acid => _nf_trans_fatty_acids;

  static set nf_trans_fatty_acid(int value) {
    _nf_trans_fatty_acids = value;
  }

  static int get nf_cholesterol => _nf_cholesterol;

  static set nf_cholesterol(int value) {
    _nf_cholesterol = value;
  }

  static int get total_carbohydrate => _total_carbohydrate;

  static set total_carbohydrate(int value) {
    _total_carbohydrate = value;
  }
}
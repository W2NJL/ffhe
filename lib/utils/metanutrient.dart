class MetaDataNutrient {
  static int _fatValue, _carbValue, _sodiumValue, _satFatValue, _cholesterolValue, _transFatValue;

  static get carbValue => _carbValue;

  static get transFatValue => _transFatValue;

  static set transFatValue(value) {
    _transFatValue = value;
  }

  static set carbValue(value) {
    _carbValue = value;
  }

  static get sodiumValue => _sodiumValue;

  static set sodiumValue(value) {
    _sodiumValue = value;
  }

  MetaDataNutrient joe = new MetaDataNutrient();


  static set fatValue(int value) {
    _fatValue = value;
  }

  static List<Map<String, dynamic>> get macroNutrientTypes  => [
    {





      "nutrient": "FAT",
      "name": "Total Fat",
      "sub": false,
      "dly": {"male": _fatValue, "felame": _fatValue}
    },

    {





      "nutrient": "CARBS",
      "name": "Total Carbohydrates",
      "sub": false,
      "dly": {"male": _carbValue, "felame": _carbValue}
    },

    {





      "nutrient": "CHOLESTEROL",
      "name": "Cholesterol",
      "sub": false,
      "dly": {"male": _cholesterolValue, "felame": _cholesterolValue}
    },

    {





      "nutrient": "SODIUM",
      "name": "Sodium",
      "sub": false,
      "dly": {"male": _sodiumValue, "felame": _sodiumValue}
    },

    {





      "nutrient": "SATFAT",
      "name": "Saturated Fat",
      "sub": false,
      "dly": {"male": _satFatValue, "felame": _satFatValue}
    },

    {





      "nutrient": "TRANSFAT",
      "name": "Trans Fat",
      "sub": false,
      "dly": {"male": _transFatValue, "felame": _transFatValue}
    },


  ];

  static List<Map<String, dynamic>> get vitaminTypes => [

  ];

  static get satFatValue => _satFatValue;

  static get cholesterolValue => _cholesterolValue;

  static set cholesterolValue(value) {
    _cholesterolValue = value;
  }

  static set satFatValue(value) {
    _satFatValue = value;
  }
}

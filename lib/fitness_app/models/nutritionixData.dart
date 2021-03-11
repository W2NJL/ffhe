import 'dart:convert';
import 'package:fast_food_health_e/services/webservice.dart';
import 'package:fast_food_health_e/utils/constants.dart';

class NutritionixLabel {

  final String title;
  final String descrption;
  final String urlToImage;
  final Fields nutritionFields;

  NutritionixLabel({this.title, this.descrption, this.urlToImage, this.nutritionFields});

  factory NutritionixLabel.fromJson(Map<String,dynamic> json) {
    return NutritionixLabel(
        title: json['_index'],
        descrption: json['_type'],
        urlToImage: json['_id'] ?? Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL,
        nutritionFields: Fields.fromJson(json['fields'])
    );

  }

  static Resource<List<NutritionixLabel>> get all {

    return Resource(
        url: Constants.NUTRITIONIX_API_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['hits'];
          return list.map((model) => NutritionixLabel.fromJson(model)).toList();
        }
    );

  }

}

class Fields {
  final String itemName;
  final String brandName;
  final int nfCalories;



  Fields({
    this.itemName,
    this.brandName,
    this.nfCalories,
  });

  factory Fields.fromJson(Map<String, dynamic> json){
    return Fields(
        itemName: json['item_name'],
        brandName: json['brand_name'],
      nfCalories: json['nf_calories'],
    );
  }


}
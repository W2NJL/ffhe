import 'dart:convert';
import 'package:fast_food_health_e/services/webservice.dart';
import 'package:fast_food_health_e/utils/constants.dart';

class NutritionixData {

  final String title;
  final String descrption;
  final String urlToImage;
  final Fields nutritionFields;

  NutritionixData({this.title, this.descrption, this.urlToImage, this.nutritionFields});

  factory NutritionixData.fromJson(Map<String,dynamic> json) {
    return NutritionixData(
        title: json['_index'],
        descrption: json['_type'],
        urlToImage: json['_id'] ?? Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL,
        nutritionFields: Fields.fromJson(json['fields'])
    );

  }

  static Resource<List<NutritionixData>> get (String restaurant) {

    return Resource(
        url: 'https://api.nutritionix.com/v1_1/search/' + restaurant + '?results=0:50&fields=item_name,brand_name,nf_calories&appId=816cee15&appKey=aab0a0a4c4224eca770bf5a2a0f4c984',
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['hits'];
          return list.map((model) => NutritionixData.fromJson(model)).toList();
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
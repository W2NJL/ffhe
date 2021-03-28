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

  static Resource<int> getTotalNum (String restaurant){
    return Resource(
        url: 'https://api.nutritionix.com/v1_1/search/' + restaurant + '?results=0:50&fields=item_name,brand_name,nf_calories,nf_sodium,nf_sugars,nf_cholesterol,nf_total_fat,nf_dietary_fiber&appId=816cee15&appKey=aab0a0a4c4224eca770bf5a2a0f4c984',
        parse: (response) {
          final result = json.decode(response.body);


      print(result['total_hits']);





          return result['total_hits'];
        }
    );
  }

  static Resource<List<NutritionixData>> get (String restaurant, String category, int minResults) {


final nutritionalIncrement = 1;
int maxResults = minResults + nutritionalIncrement;





    return Resource(
        url: 'https://api.nutritionix.com/v1_1/search/' + restaurant + '?results='+ minResults.toString() + ':' + maxResults.toString() + '&fields=item_name,brand_name,nf_calories,nf_sodium,nf_sugars,nf_cholesterol,nf_total_fat,nf_dietary_fiber&appId=816cee15&appKey=aab0a0a4c4224eca770bf5a2a0f4c984',
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['hits'];





          list = list.map((model) => NutritionixData.fromJson(model)).toList();

          return list.where((f) => f.nutritionFields.nfCategory.contains(category)).toList();
        }
    );

  }





}

class Fields {
  final String itemName;
  final String brandName;
  final String nfCalories;
  final String nfSugars;
  final String nfCholesterol;
  final String nfSodium;
  final String nfFat;
  final String nfFiber;
  final List<String> nfCategory;





  Fields({
    this.itemName,
    this.brandName,
    this.nfCalories,
    this.nfCholesterol,
    this.nfSodium,
    this.nfSugars,
    this.nfFat,
    this.nfFiber,
    this.nfCategory,


  });

  factory Fields.fromJson(Map<String, dynamic> json){
    return Fields(
        itemName: json['item_name'],
        brandName: json['brand_name'],
      nfCalories: json['nf_calories'].toString(),
      nfCholesterol: json['nf_cholesterol'].toString(),
      nfSodium: json['nf_sodium'].toString(),
      nfSugars: json['nf_sugars'].toString(),
      nfFat: json['nf_total_fat'].toString(),
      nfFiber: json['nf_dietary_fiber'].toString(),
      nfCategory: determineFood(json['item_name']),


    );
  }


}






determineFood(String category) {
  List<String> categoryArray = <String>[];
  const int categories = 4;

  final breakfastReg =  RegExp("(?:waffle|toast|pancake|omelette|omelet|sausage|breakfast|bagel|egg|muffin|hotcakes)", caseSensitive: false);
  final lunchReg =  RegExp("(?:salad|sandwich|soup|burger|pasta|gyro|hoagie|buffalo|sandwich|nuggets|filet|strips|pounder|tenders|mac|chicken|tacos|quesadilla)", caseSensitive: false);
  final dinnerReg =  RegExp("(?:burger|steak|pork|ribs|chicken|pasta|meatloaf|beef)", caseSensitive: false);
  final sideReg =  RegExp("(?:dressing|drink|mustard|jelly|peanuts|coleslaw|sauce|lemonade|fries|milk|potato|corn|rice)", caseSensitive: false);



  bool getCategory(int i, String string){
    if(i==0){
      return sideReg.hasMatch(string);
    }
    else if(i==1){
      return breakfastReg.hasMatch(string);
    }
    else if(i==2){
      return lunchReg.hasMatch(string);
    }
    else if(i==3){
      return dinnerReg.hasMatch(string);
    }

    return false;
  }


  String getCategoryWord(int i){


    if(i==0){
      return "Sides";
    }
    else if(i==1){
      return "Breakfast";
    }
    else if(i==2){
      return "Lunch";
    }
    else if(i==3){
      return "Dinner";
    }

    return null;


  }

  for(int i=0; i < categories; i++){
    if (getCategory(i, category))
    categoryArray.add(getCategoryWord(i));
  }





  return categoryArray;
}
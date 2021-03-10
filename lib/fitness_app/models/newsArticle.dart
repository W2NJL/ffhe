import 'dart:convert';
import 'package:fast_food_health_e/services/webservice.dart';
import 'package:fast_food_health_e/utils/constants.dart';

class NewsArticle {

  final String title;
  final String descrption;
  final String urlToImage;
  final Fields mrsFields;

  NewsArticle({this.title, this.descrption, this.urlToImage, this.mrsFields});

  factory NewsArticle.fromJson(Map<String,dynamic> json) {
    return NewsArticle(
        title: json['_index'],
        descrption: json['_type'],
        urlToImage: json['_id'] ?? Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL,
        mrsFields: Fields.fromJson(json['fields'])
    );

  }

  static Resource<List<NewsArticle>> get all {

    return Resource(
        url: Constants.HEADLINE_NEWS_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['hits'];
          return list.map((model) => NewsArticle.fromJson(model)).toList();
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
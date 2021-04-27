import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'metanutrient.dart';
import 'nutrients.dart';

class NutrientLabel extends StatefulWidget {
  const NutrientLabel(this.user, this.nutritionList);
  final Map<String, dynamic> user;
  final List<int>nutritionList;




  @override
  _NutrientFacts createState() => _NutrientFacts();
}

class _NutrientFacts extends State<NutrientLabel> {
  var nutrientData;
  var totalCarbs, totalFat, totalSodium, totalCholesterol, totalSatFat,
      totalCalories, nf_total_fat, nf_total_carbohydrate, nf_cholesterol,
      nf_sodium, nf_saturated_fat, nf_trans_fatty_acid, nf_calories;
  List<Nutrients> listy = <Nutrients>[];



  @override
  void initState() {

    print("Teste: ");
    print( widget.user);

    widget.user.entries.forEach((e) => listy.add(Nutrients(e.key, e.value)));
    
    nf_calories = listy.firstWhere((element) => element.nutrient == "nf_calories").value;










    // nf_total_fat = d["nf_total_fat"];
    //     nf_total_carbohydrate = d["nf_total_carbohydrate"];
    //   nf_cholesterol = d["nf_cholesterol"];
    //   nf_sodium = d["nf_sodium"];
    //   nf_sodium = d["nf_sodium"];
    //   nf_saturated_fat = d["nf_saturated_fat"];
    //   nf_trans_fatty_acid = d["nf_trans_fatty_acid"];
    //   nf_calories = d["nf_calories"];







    nutrientData = {

      "FAT": {"amount": listy.firstWhere((element) => element.nutrient == "nf_total_fat").value, "unit": "g"},
      "CARBS": {"amount": listy.firstWhere((element) => element.nutrient == "nf_total_carbohydrate").value, "unit": "g"},
      "CHOLESTEROL": {"amount": listy.firstWhere((element) => element.nutrient == "nf_cholesterol").value, "unit": "mg"},
      "SODIUM": {"amount": listy.firstWhere((element) => element.nutrient == "nf_sodium").value, "unit": "mg"},
      "SATFAT": {"amount": listy.firstWhere((element) => element.nutrient == "nf_saturated_fat").value, "unit": "g"},
      "TRANSFAT": {"amount": listy.firstWhere((element) => element.nutrient == "nf_trans_fatty_acid").value, "unit": "g"},

    };

    totalCalories = widget.nutritionList.elementAt(0);
    totalCarbs = widget.nutritionList.elementAt(1);
    totalSodium = widget.nutritionList.elementAt(2);
    totalCholesterol = widget.nutritionList.elementAt(3);
    totalFat = widget.nutritionList.elementAt(4);
    totalSatFat = widget.nutritionList.elementAt(5);

    print("I need you" + listy.toString());


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.0),
      decoration:
      BoxDecoration(border: new Border.all(color: Colors.black, width: 2.0)),
      child: Container(
        padding: EdgeInsets.all(2.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            nutriHeader(calories: nf_calories,
                servingSize: null),
            nutrientValues(nutrientData: nutrientData),
            vitaminValues(nutrientData: nutrientData),
            footerCalories(),
          ],
        ),
      ),
    );
  }


  Widget nutrientValues({nutrientData}) {
    //final n = (1.3456).toStringAsFixed(2);
    //final s = double.parse("1.2345");

    initNutrients();

    final nutrientTypes = MetaDataNutrient.macroNutrientTypes;


    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: nutrientTypes
          .map((d) =>
          nutrientLiner(
            nutrientName: d["name"],
            qty: nutrientData["${d["nutrient"]}"]["amount"],
            ptg: checkNutrientCondx(d) ? d["dly"]["male"] != null
                ? ((nutrientData["${d["nutrient"]}"]["amount"] * 100) /
                d["dly"]["male"])
                .toStringAsFixed(2)
                : "-" : null,
            sub: d["sub"],
            unit: nutrientData["${d["nutrient"]}"]["unit"],
            showp: d["dly"]["male"] != null ? true : false,
          ))
          .toList(),
    );
  }

  bool checkNutrientCondx(Map<String, dynamic> d) =>
      d["name"] != "Trans Fat" && d["dly"]["male"] != 999999999;

  void initNutrients() {
    print("Garfield is a fat cat: " + totalCarbs.toString());


    MetaDataNutrient.fatValue = totalFat;
    MetaDataNutrient.carbValue = totalCarbs;
    MetaDataNutrient.sodiumValue = totalSodium;
    MetaDataNutrient.cholesterolValue = totalCholesterol;
    MetaDataNutrient.satFatValue = totalSatFat;


  }

  Widget vitaminValues({nutrientData}) {
    //final n = (1.3456).toStringAsFixed(2);
    //final s = double.parse("1.2345");
    final nutrientTypes = MetaDataNutrient.vitaminTypes;
    final vitaminLine = Container(
        margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
        height: 4.0,
        color: Colors.black);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[vitaminLine] +
          nutrientTypes
              .map((d) =>
              vitaminLiner(
                nutrientName: d["name"],
                qty: nutrientData["${d["nutrient"]}"]["amount"],
                ptg: (d["dly"] as Map<String, num>)["male"] != null
                    ? ((nutrientData["${d["nutrient"]}"]["amount"] * 100) /
                    (d["dly"] as Map<String, num>)["male"])
                    .toStringAsFixed(2)
                    : "-",
                unit: nutrientData["${d["nutrient"]}"]["unit"],
                showp: (d["dly"] as Map<String, num>)["male"] != null
                    ? true
                    : false,
              ))
              .toList(),
    );
  }

  Widget nutriHeader({calories, servingSize, servings}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Nutrition Facts",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black, fontSize: 40.0, fontWeight: FontWeight.w700),
        ),

        servings != null ? Text(
          "Weight $servings g",
          style: TextStyle(
              fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w400),
        ) : SizedBox(height: 0),
        Container(
          margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
          height: 5.0,
          color: Colors.black,
        ),
        Text(
          "Ammount Per Serving",
          style: TextStyle(
              fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.w800),
        ),
        Container(
          margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
          height: 1.0,
          color: Colors.black,
        ),
        Row(children: <Widget>[
          Text(
            "Calories",
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontWeight: FontWeight.w900),
          ),
          Text(
            " $calories",
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
        ]),
        Container(
            margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
            height: 3.0,
            color: Colors.black),
        Container(
          alignment: Alignment.topRight,
          child: Text(
            "% Daily Value*",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }

  Widget nutrientLiner({
    @required nutrientName,
    @required qty,
    ptg,
    sub: false,
    unit: "g",
    showp: true,
  }) {
    final textSize = 15.0;
    final textWeight1 = FontWeight.w900;
    final textWeight2 = FontWeight.w500;
    return Container(
        padding: (sub)
            ? EdgeInsetsDirectional.only(start: 26.0, end: 1.0)
            : EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
        child: Column(children: <Widget>[
          Container(
              margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
              height: 1.0,
              color: Colors.black),
          Row(
            children: <Widget>[
              Text(
                nutrientName,
                style: TextStyle(
                    fontSize: textSize,
                    color: Colors.black,
                    fontWeight: (sub) ? textWeight2 : textWeight1),
              ),
              Text(
                "  ${qty}${unit}",
                style: TextStyle(
                    fontSize: textSize,
                    color: Colors.black,
                    fontWeight: textWeight2),
              ),
              Expanded(
                  child: Text(
                    (((ptg == null) || !showp) ? "" : "${ptg}%"),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: textSize,
                      color: Colors.black,
                      fontWeight: textWeight1,
                    ),
                  )),
            ],
          )
        ]));
  }

  Widget vitaminLiner({
    @required nutrientName,
    @required qty,
    ptg,
    showQty: false,
    unit: "g",
    showp: true,
  }) {
    final textSize = 15.0;
    final textWeight = FontWeight.w500;
    return Container(
        padding: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
        child: Column(children: <Widget>[
          Container(
              margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
              height: 1.0,
              color: Colors.black),
          Row(
            children: <Widget>[
              Text(
                nutrientName,
                style: TextStyle(
                    fontSize: textSize,
                    color: Colors.black,
                    fontWeight: textWeight),
              ),
              Text(
                (showQty) ? "  ${qty}${unit}" : "",
                style: TextStyle(
                    fontSize: textSize,
                    color: Colors.black,
                    fontWeight: textWeight),
              ),
              Expanded(
                  child: Text(
                    (((ptg == null) || !showp) ? "" : "${ptg}%"),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: textSize,
                      color: Colors.black,
                      fontWeight: textWeight,
                    ),
                  )),
            ],
          )
        ]));
  }

  Widget footerCalories({caloriesNum: 2000}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
            height: 5.0,
            color: Colors.black,
          ),
          Text(
            "*Percent Daily Values are based on a ${totalCalories} calories diet.",
            style: TextStyle(
                fontSize: 10.0,
                color: Colors.black,
                fontWeight: FontWeight.w400),
          )
        ]);
  }
}
class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String> meals;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'images/fitness_app/breakfast.png',
      titleTxt: 'FirstWatch',
      kacl: 525,
      meals: <String>['Omelet'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'images/fitness_app/lunch.png',
      titleTxt: 'Taco Bell',
      kacl: 602,
      meals: <String>['Quesadilla'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),

    MealsListData(
      imagePath: 'images/fitness_app/dinner.png',
      titleTxt: 'Dinner',
      kacl: 0,
      meals: <String>['Recommend:', '703 kcal'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}

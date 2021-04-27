import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseFunctions {




  Future <List<int>> getTotalNutrients(String diet) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate;
    formattedDate = formatter.format(now);
    List<String> dietList = <String>[];
    dietList.add("Calories");
    dietList.add("Low Carb");
    dietList.add("Sodium");
    dietList.add("Low Cholesterol");
    dietList.add("Low Fat");
    dietList.add("Saturated Fat");
    List<int> nutritionList = <int>[];


    for (int i = 0; i < dietList.length; i++) {
      int result;
      int maxValue;

      final referenceDatabase3 = await FirebaseDatabase.instance
          .reference()
          .child('User')
          .child('DietVals')
          .child(dietList.elementAt(i))
          .child('MaxValue')
          .once()
          .then((snapshot) {
        maxValue = snapshot.value;
      });

      if (maxValue == null) {
        nutritionList.add(999999999);
      }
      else {
        nutritionList.add(maxValue);
      }
    }

    return nutritionList;
  }


}
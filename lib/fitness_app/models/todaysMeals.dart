import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodaysMeals extends StatefulWidget {
  TodaysMeals({this.app});
  final FirebaseApp app;

  @override
  _TodaysMealsState createState() => _TodaysMealsState();
}

class _TodaysMealsState extends State<TodaysMeals> {
  final referenceDatabase = FirebaseDatabase.instance;


  final radioController = TextEditingController();
  static String formattedDate;
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String callLetters;
  int sodiumVal;


  DatabaseReference _callLettersRef;

  @override
  void initState() {
    formattedDate = formatter.format(now);
    callLetters = formattedDate;
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _callLettersRef = database.reference().child('User').child('DietVals').child(formattedDate).child('Meals');

    super.initState();
  }

  Future <String> _getNutrientAmount(String mealName, String diet) async {
    String result;
    final referenceDatabase = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('DietPlan')
        .child(formattedDate)
        .child('Meals')
        .once()
        .then((snapshot){result=snapshot.value;});
    print("The result is: " + result);



    return result;
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();
    return Scaffold(
      appBar:
      AppBar(
leading: new IconButton(
  icon: new Icon(Icons.arrow_back),
    onPressed: (){Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);}
),
        title: Text('Meal selections today'),


      ),

      body: SingleChildScrollView(
        child: Column(
          children:[
            Center(
              child: Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Text(
                      callLetters,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),

                    Flexible(
                        child: new FirebaseAnimatedList(
                            shrinkWrap: true,
                            query: _callLettersRef, itemBuilder: (BuildContext context, DataSnapshot snapshot,
                            Animation<double> animation,
                            int index){
                          return new ListTile(
                            trailing: IconButton(icon: Icon(Icons.delete), onPressed: () =>{
                                ref.child('User').child('DietVals').child(formattedDate).child('Calories').set(ServerValue.increment(-snapshot.value['calories'])),
                              ref.child('User').child('DietVals').child(formattedDate).child('Sodium').set(ServerValue.increment(-snapshot.value['sodium'])),
                              ref.child('User').child('DietVals').child(formattedDate).child('Low Carb').set(ServerValue.increment(-snapshot.value['carbs'])),
                                _callLettersRef.child(snapshot.key).remove(),}),
                            title: new Text(snapshot.key + "\n(Calories: " + snapshot.value['calories'].toString() + " Sodium: " + snapshot.value['sodium'].toString() + ")"
                            ),
                          );
                        })
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}

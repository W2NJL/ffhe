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
  String month;
  int day;
  int year;
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String currDate;
  int sodiumVal;


  DatabaseReference _callLettersRef;

  @override
  void initState() {
    formattedDate = formatter.format(now);
    String returnMonth(DateTime date) {
      return new DateFormat.MMMM().format(date);
    }

    getDate(returnMonth);

    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _callLettersRef = database.reference().child('User').child('DietVals').child(formattedDate).child('Meals');

    super.initState();
  }

  void getDate (String returnMonth(DateTime date)) async {
     String month = returnMonth(now);
    day = now.day;
    year = now.year;

    currDate = month + " " + day.toString() + ", " + year.toString();

    print("Hi :" + currDate);
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

  static Widget _buildAboutText(DataSnapshot snapshot) {
    return new RichText(
      text: new TextSpan(
        text: 'Calories: ' + snapshot.value['calories'].toString() + " calories" + '\n\n' +
            'Total Carbohydrates: ' + snapshot.value['carbs'].toString() + " g" + '\n\n' +
            'Sodium: ' + snapshot.value['sodium'].toString() + " mg" + '\n\n' +
            'Total Fat: '  + snapshot.value['fat'].toString() + " g" + '\n\n' +
            'Saturated Fat: '  + snapshot.value['Saturated Fat'].toString() + " g" + '\n\n' +
            'Cholesterol: ' + snapshot.value['cholesterol'].toString() + " mg" + '\n\n' +
          'Trans Fat: '  + snapshot.value['Trans Fat'].toString() + " g" + '\n\n' ,
        style: const TextStyle(color: Colors.black87),
        // children: <TextSpan>[
        //   const TextSpan(text: 'The app was developed with '),
        //   new TextSpan(
        //     text: 'Flutter',
        //
        //   ),
        //   const TextSpan(
        //     text: ' and it\'s open source; check out the source '
        //         'code yourself from ',
        //   ),
        //   new TextSpan(
        //     text: 'www.codesnippettalk.com',
        //
        //   ),
        //   const TextSpan(text: '.'),
        // ],
      ),
    );
  }

  Widget _buildAboutDialog(BuildContext context, DataSnapshot snapshot) {


    return new AlertDialog(
      title: Text(snapshot.key),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(snapshot),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {

            Navigator.pop(context);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Dismiss'),
        ),
      ],
    );
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
                color: Colors.greenAccent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Text(
                      currDate,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                    ),

                    Flexible(
                        child: new FirebaseAnimatedList(
                            shrinkWrap: true,

                            query: _callLettersRef, itemBuilder: (BuildContext context, DataSnapshot snapshot,
                            Animation<double> animation,
                            int index){
                          return new ListTile(
                            contentPadding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),

                            leading: GestureDetector(
                              onTap: (){



                                  showDialog(

                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildAboutDialog(context, snapshot),
                                  );
                                },

                              child: ConstrainedBox(
                                  constraints:
                                  BoxConstraints(minWidth: 100, minHeight: 100),
                                  child: Image.asset(
                                    getRestaurantIcon(snapshot.value['Restaurant'].toString()),
                                    width: 100,
                                    height: 100,

                                  )),
                            ),

                            trailing: IconButton(icon: Icon(Icons.delete), onPressed: () =>{
                                ref.child('User').child('DietVals').child(formattedDate).child('Calories').set(ServerValue.increment(-snapshot.value['calories'])),
                              ref.child('User').child('DietVals').child(formattedDate).child('Sodium').set(ServerValue.increment(-snapshot.value['sodium'])),
                              ref.child('User').child('DietVals').child(formattedDate).child('Low Carb').set(ServerValue.increment(-snapshot.value['carbs'])),
                              ref.child('User').child('DietVals').child(formattedDate).child('Low Cholesterol').set(ServerValue.increment(-snapshot.value['cholesterol'])),
                              ref.child('User').child('DietVals').child(formattedDate).child('Low Fat').set(ServerValue.increment(-snapshot.value['fat'])),
                              ref.child('User').child('DietVals').child(formattedDate).child('Saturated Fat').set(ServerValue.increment(-snapshot.value['Saturated Fat'])),
                              ref.child('User').child('DietVals').child(formattedDate).child('Trans Fat').set(ServerValue.increment(-snapshot.value['Trans Fat'])),
                                _callLettersRef.child(snapshot.key).remove(),}),
                            title: new Text(snapshot.key
                            ),
                            subtitle: new Text("(Calories: " + snapshot.value['calories'].toString() + " Sodium: " + snapshot.value['sodium'].toString() + ")"),
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

  getRestaurantIcon(String restaurant) {

   
      print("Hmm " + restaurant);


      if(restaurant.contains("Bob"))
      {
        return "images/" + "bob_evans.png";
      }
      else if (restaurant.contains("Apple")){
        return "images/" + "applebees.png";
      }
      else if (restaurant.contains("King")){
        return "images/" + "bk.jpg";
      }
      else if (restaurant.contains("Chick")){
        return "images/" + "chick-fil-a.gif";
      }
      else if (restaurant.contains("Donald")){
        return "images/" + "mcdonalds.png";
      }
      else if (restaurant.contains("Chang")){
        return "images/" + "pfchangs.jpg";
      }
      else if (restaurant.contains("Panera")){
        return "images/" +"panera.jpg";
      }
      else if (restaurant.contains("Royal")){
        return "images/" +"royal_farms.jpg";
      }
      else if (restaurant.contains("Smash")){
        return "images/" +"smash.png";
      }
      else if (restaurant.contains("Taco")){
        return "images/" +"taco.png";
      }
      else if (restaurant.contains("Wawa")){
        return"images/" +"wawa.jpg";
      }



    }
  }


import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:fast_food_health_e/state/FastFoodHealthEState.dart';
import 'package:fast_food_health_e/utils/firebaseFunctions.dart';
import 'package:fast_food_health_e/utils/nutrientList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:fast_food_health_e/utils/nutrientLabel.dart';
import 'package:provider/provider.dart';

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
  DateTime selectedDate;
  int sodiumVal;
  int totalCalories;
  List<int> nutrientList = <int>[];
  var firebaseUser;
  String userID;
  bool done = true;
  bool empty = false;
  var data;
  String nick = "joe";
  FirebaseFunctions joe = new FirebaseFunctions();


  DatabaseReference _callLettersRef;

  @override
  void didChangeDependencies() {

    setUpUsers();

    super.didChangeDependencies();
  }

  void setUpUsers () async  {




    firebaseUser = context.watch<User>();
    userID  = firebaseUser.uid;





    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _callLettersRef = database.reference().child(userID).child('DietVals').child(formattedDate).child('Meals');
    data = await database.reference().child(userID).child('DietVals').child(formattedDate).child('Meals').once();

    checkData(_callLettersRef);



    done = true;
    this._getMoreData(userID);

  }

  void checkData(DatabaseReference callLettersRef) async{
    data = await callLettersRef.once();
    if (data.value != null){
      empty = false;
    }
    else{
      empty = true;
    }


  }


  void updateDate(DateTime date, BuildContext context) {









    setState(() {
      final FirebaseDatabase database = FirebaseDatabase(app: widget.app);





      done = false;
      selectedDate = date;

      formattedDate = formatter.format(date);

      _callLettersRef = database.reference().child(userID).child('DietVals').child(formattedDate).child('Meals');
      checkData(_callLettersRef );
      callTheFunction();



    });









  }


  @override
  void initState() {


      selectedDate = now;
      formattedDate = formatter.format(now);



    super.initState();
  }

  // void getDate (String returnMonth(DateTime date)) async {
  //    String month = returnMonth(now);
  //   day = now.day;
  //   year = now.year;
  //
  //   currDate = month + " " + day.toString() + ", " + year.toString();
  //
  //
  // }

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

  Future <int> _getTotalNutrients(String diet) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);

    int result;
    int maxValue;

    final referenceDatabase3 = await FirebaseDatabase.instance
        .reference()
        .child('User')
        .child('DietVals')
        .child(diet)
        .child('MaxValue')
        .once()
        .then((snapshot) {
      maxValue = snapshot.value;
    });

    if (maxValue == null)
    {
      return 999999999;
    }


    return maxValue;
  }


   void _getMoreData(String userID) async{

    final

    FirebaseFunctions joe = new FirebaseFunctions();

    await joe.getTotalNutrients('Calories', userID).then((value) => setState(() {

      nutrientList = value;


    }));

  }

  Widget _buildAboutDialog(BuildContext context, DataSnapshot snapshot) {






  initNutrients(snapshot);


    // nutrientList.add(int.parse());
    // nutrientList.add(ref.child('User').child('DietVals').child('Low Carb'));
    // nutrientList.add(ref.child('User').child('DietVals').child('Sodium'));
    // nutrientList.add(ref.child('User').child('DietVals').child('Low Cholesterol'));
    // nutrientList.add(ref.child('User').child('DietVals').child('Saturated Fat'));



 final nutrientTypes = NutrientList.listOfNutrients;







    return new AlertDialog(
      title: Text(snapshot.key),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          NutrientLabel(nutrientTypes, nutrientList),
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
      CalendarAppBar(
        onDateChanged: (value) => setState(() => updateDate(value, context),

      ),
        firstDate: DateTime.now().subtract(Duration(days: 140)),
        lastDate: DateTime.now(),
          locale: 'en'
      ),


      body: done? SingleChildScrollView(
        child: Column(
          children:[
            Center(
              child: Container(
                color: Colors.greenAccent,
            constraints: BoxConstraints(
              maxHeight: double.infinity,
            ),
                child: Column(
                  children: [



                        !empty?                           new FirebaseAnimatedList(
                              shrinkWrap: true,

                            physics: NeverScrollableScrollPhysics(),
                              query: _callLettersRef, itemBuilder: (BuildContext context, DataSnapshot snapshot,
                              Animation<double> animation,
                              int index){
                            return new ListTile(
                              contentPadding: EdgeInsets.only(top: 4.h, bottom: 4.h, left: 4.w, right: 4.w),

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
                                    BoxConstraints(minWidth: 100.w, minHeight: 100.h),
                                    child: Image.network(
                                      joe.getRestaurantIcon(snapshot.value['Restaurant'].toString()),
                                      width: 100.h,
                                      height: 100.w,
                                      errorBuilder: (context, error, StackTrace){
                                        return Image.network(


                                            "https://static.wixstatic.com/media/7d5dd4_7314dd4e69d3447e8fcf6319495fdb80~mv2.png/v1/fill/w_150,h_150,al_c,q_85,usm_0.66_1.00_0.01/FastFoodHealthELogo.webp"
                                        );
                                      },
                                    )),
                              ),

                              trailing: IconButton(icon: Icon(Icons.delete), onPressed: () =>{
                                  ref.child(userID).child('DietVals').child(formattedDate).child('Calories').set(ServerValue.increment(-snapshot.value['calories'])),
                                ref.child(userID).child('DietVals').child(formattedDate).child('Sodium').set(ServerValue.increment(-snapshot.value['sodium'])),
                                ref.child(userID).child('DietVals').child(formattedDate).child('Low Carb').set(ServerValue.increment(-snapshot.value['carbs'])),
                                ref.child(userID).child('DietVals').child(formattedDate).child('Low Cholesterol').set(ServerValue.increment(-snapshot.value['cholesterol'])),
                                ref.child(userID).child('DietVals').child(formattedDate).child('Low Fat').set(ServerValue.increment(-snapshot.value['fat'])),
                                ref.child(userID).child('DietVals').child(formattedDate).child('Saturated Fat').set(ServerValue.increment(-snapshot.value['Saturated Fat'])),
                                ref.child(userID).child('DietVals').child(formattedDate).child('Trans Fat').set(ServerValue.increment(-snapshot.value['Trans Fat'])),
                                  _callLettersRef.child(snapshot.key).remove(),
                              Future.microtask(() {
                              Provider.of<FastFoodHealthEState>(context, listen: false).clearState();
                              Provider.of<FastFoodHealthEState>(context, listen: false).loadUserList(context);
                              }
                              ),

                              }),
                              title: new Text(snapshot.key
                              ),
                              subtitle: new Text("(Calories: " + snapshot.value['calories'].toString() + " Sodium: " + snapshot.value['sodium'].toString() + ")"),
                            );
                          })
                      :Column(

                          children: [
                            Image.asset("images\/" + "FastFoodHealthELogo_WhiteSlogan.png",



                            ),
                            Container(

                            margin: EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w, bottom: 15.h),
                            child: Center(child: RichText(

                              text: TextSpan(

                                style: TextStyle(color: Colors.black, fontSize: 36.sp),
                                children: <TextSpan>[
                                  TextSpan(text: 'No meals available! ', style: TextStyle(color: Colors.blue)),

                                ],
                              ),
                            ),

                            ),
                          ),
                            Container(
                              margin: EdgeInsets.only(top: 2.h, right: 20.w, left: 20.w, bottom: 200.h),
                              child: Center(child: RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                                  children: <TextSpan>[
                                    TextSpan(text: 'There were no meal items entered on this date.', style: TextStyle(color: Colors.black)),

                                  ],
                                ),
                              ),

                              ),
                            ),
                          ],
                        ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ):Center(child: CircularProgressIndicator()),

    );
  }





  void initNutrients(DataSnapshot snapshot) {
   NutrientList.nf_calories = snapshot.value['calories'];
   NutrientList.nf_sodium = snapshot.value['sodium'];
   NutrientList.nf_total_fat = snapshot.value['fat'];
   NutrientList.nf_cholesterol = snapshot.value['cholesterol'];
   NutrientList.nf_saturated_fat = snapshot.value['Saturated Fat'];
   NutrientList.nf_trans_fatty_acid = snapshot.value['Trans Fat'];
   NutrientList.total_carbohydrate = snapshot.value['carbs'];



  }

  void callTheFunction() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        done = true;
      });
    });
  }
  }


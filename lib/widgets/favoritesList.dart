import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:fast_food_health_e/models/fastFoodHealthE.dart';
import 'package:fast_food_health_e/state/FastFoodHealthEState.dart';
import 'package:fast_food_health_e/utils/firebaseFunctions.dart';
import 'package:fast_food_health_e/utils/nutrientList.dart';
import 'package:fast_food_health_e/widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fast_food_health_e/utils/nutrientLabel.dart';
import 'package:provider/provider.dart';

class FavoritesList extends StatefulWidget {
  FavoritesList({this.app});
  final FirebaseApp app;

  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
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
  FirebaseFunctions firebaseFunctions = new FirebaseFunctions();
  FastFoodHealthEUser fastFoodHealthEUser;
  bool proceed = false;


  DatabaseReference _callLettersRef;

  @override
  void didChangeDependencies() {

    setUpUsers();

    super.didChangeDependencies();
  }

  void setUpUsers () async  {



    fastFoodHealthEUser =   Provider.of<FastFoodHealthEState>(context, listen: false).activeVote;
    firebaseUser = context.watch<User>();
    userID  = firebaseUser.uid;





    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _callLettersRef = database.reference().child(userID).child('Favorites');
    this._getMoreData(userID);

    checkEmptyList().then((value) => setState(() {
      proceed = value;

    }));

  }

  Future<bool> checkEmptyList() async {
    var data = await _callLettersRef.once();
    if (data.value == null) {
      return false;
    } else {
      return true;
    }
  }


  void updateDate(DateTime date, BuildContext context) {





    setState(() {

      done = false;
      selectedDate = date;
      formattedDate = formatter.format(date);
      final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
      _callLettersRef = database.reference().child(userID).child('DietVals').child(formattedDate).child('Meals');
      callTheFunction();



    });









  }


  @override
  void initState() {


    selectedDate = now;
    formattedDate = formatter.format(now);
    done = true;


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

    final referenceDatabase = FirebaseDatabase.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user2 = auth.currentUser;
    final uid = user2.uid;
    final ref = referenceDatabase.reference().child(uid);




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

            if(firebaseFunctions.checkPercentageOfDay(snapshot.key, ref, fastFoodHealthEUser, context))

            firebaseFunctions.addToMyDay(snapshot.key, ref, fastFoodHealthEUser, context);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Add To My Day'),
        ),
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
    if (proceed){
    return Scaffold(
      appBar:
      MyAppBar(
        title: Text("Favorite Meals"),
        context: context,
        route: '/home',
      ),



      body: done?



      SingleChildScrollView(
        child: Column(
          children:[
            Center(
              child: Container(
                color: Colors.greenAccent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [


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
                                  child: Image.network(
                                    firebaseFunctions.getRestaurantIcon(snapshot.value['Restaurant'].toString()),
                                    width: 100,
                                    height: 100,
                                    errorBuilder: (context, error, StackTrace){
                                      return Image.network(


                                          "https://static.wixstatic.com/media/7d5dd4_7314dd4e69d3447e8fcf6319495fdb80~mv2.png/v1/fill/w_150,h_150,al_c,q_85,usm_0.66_1.00_0.01/FastFoodHealthELogo.webp"
                                      );
                                    },
                                  )
                            )),

                            trailing: IconButton(icon: Icon(Icons.delete), onPressed: () =>{

                              _callLettersRef.child(snapshot.key).remove(),


                            }),
                            title: new Text(snapshot.key
                            ),
                            subtitle: new Text(snapshot.value['Calories'].toString() + " calories"),
                          );
                        })
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ):Center(child: CircularProgressIndicator()),

    );}
    else{
      return Scaffold(
        appBar: MyAppBar(
          title: Text("Favorite Meals"),
          route: '/home',
          context: context,
        ),
        body: Column(

          children: [
            Image.asset("images\/" + "FastFoodHealthELogo_WhiteSlogan.png",



            ),
            Expanded(
              child: Container(

                margin: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 15),
                child: Center(child: RichText(

                  text: TextSpan(

                    style: TextStyle(color: Colors.black, fontSize: 36),
                    children: <TextSpan>[
                      TextSpan(text: 'No meals available! ', style: TextStyle(color: Colors.blue)),

                    ],
                  ),
                ),

                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, right: 20, left: 20, bottom: 200),
              child: Center(child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(text: 'Add some meals as favorites to see them here!', style: TextStyle(color: Colors.black)),

                  ],
                ),
              ),

              ),
            ),
          ],
        ),


      );


    }
  }

  getRestaurantIcon(String restaurant) {





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
    else if (restaurant.contains("Olive")){
      return "images/" + "og.jpg";
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



  void initNutrients(DataSnapshot snapshot) {
    NutrientList.nf_calories = snapshot.value['Calories'];
    NutrientList.nf_sodium = snapshot.value['Sodium'];
    NutrientList.nf_total_fat = snapshot.value['Low Fat'];
    NutrientList.nf_cholesterol = snapshot.value['Low Cholesterol'];
    NutrientList.nf_saturated_fat = snapshot.value['Saturated Fat'];
    NutrientList.nf_trans_fatty_acid = snapshot.value['Trans Fat'];
    NutrientList.total_carbohydrate = snapshot.value['Low Carb'];



  }

  void callTheFunction() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        done = true;
      });
    });
  }
}


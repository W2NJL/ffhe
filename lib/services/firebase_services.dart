
import 'package:fast_food_health_e/models/fastFoodHealthE.dart';
import 'package:fast_food_health_e/state/FastFoodHealthEState.dart';
import 'package:fast_food_health_e/state/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';








  void fetchUser(BuildContext context)
 async{
   // var firebaseUser = context.watch<User>();
   // String userID  = firebaseUser.uid;
   Map<String, dynamic> theMap;
   final FirebaseAuth auth = FirebaseAuth.instance;
   final User user = auth.currentUser;
   final uid = user.uid;



   await FirebaseDatabase.instance
       .reference()
       .child(uid)
        .once()
       .then((snapshot){theMap = new Map<String, dynamic>.from(snapshot.value);});



   Provider.of<FastFoodHealthEState>(context, listen: false).activeVote = FastFoodHealthEUser.fromJson(theMap, context);

 }



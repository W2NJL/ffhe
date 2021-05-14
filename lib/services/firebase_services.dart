
import 'package:fast_food_health_e/models/fastFoodHealthE.dart';
import 'package:fast_food_health_e/state/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';




class FirebaseServices{
  Future<FastFoodHealthEUser> fetchUser()
 async{
   // var firebaseUser = context.watch<User>();
   // String userID  = firebaseUser.uid;
   Map<String, dynamic> theMap;

   final referenceDatabase = await FirebaseDatabase.instance
       .reference()
       .child('e2KlCqGLRqTWdEja9f93udfGmFv1')
        .once()
       .then((snapshot){theMap = new Map<String, dynamic>.from(snapshot.value);});



   print('Check the map: ' + theMap.toString());

   return FastFoodHealthEUser.fromJson(theMap);



 }


}
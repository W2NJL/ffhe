import 'package:fast_food_health_e/models/fastFoodHealthE.dart';
import 'package:fast_food_health_e/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';

class FastFoodHealthEState with ChangeNotifier{

  List <FastFoodHealthEUser> _voteList = <FastFoodHealthEUser>[];
  FastFoodHealthEUser _activeVote;

  void clearState(){
    _voteList = null;
    _activeVote = null;

  }

  void loadUserList(BuildContext context) async {
    //_voteList = getVoteList();
    notifyListeners();
    fetchUser(context);
  }

  FastFoodHealthEUser get activeVote => _activeVote;


  set activeVote(newValue){
    _activeVote = newValue;
    notifyListeners();
  }



}
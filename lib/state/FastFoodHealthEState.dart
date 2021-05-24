import 'package:fast_food_health_e/models/fastFoodHealthE.dart';
import 'package:fast_food_health_e/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';

class FastFoodHealthEState with ChangeNotifier{

  List <FastFoodHealthEUser> _voteList = <FastFoodHealthEUser>[];
  FastFoodHealthEUser _activeVote;
  DateTime _date;

  void clearState(){
    _voteList = null;
    _activeVote = null;
    _date = DateTime.now();

  }

  void loadUserList(BuildContext context) async {
    //_voteList = getVoteList();
    notifyListeners();
    fetchUser(context);
  }

  FastFoodHealthEUser get activeVote => _activeVote;

  DateTime get date => _date;


  set activeVote(newValue){
    _activeVote = newValue;
    notifyListeners();
  }

  set date(newValue){
    _date = newValue;
    notifyListeners();

  }



}
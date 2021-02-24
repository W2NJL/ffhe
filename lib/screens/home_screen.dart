import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:vote/models/ffhe.dart';
import 'package:vote/services/service.dart';
import 'package:vote/state/vote.dart';
import 'package:vote/widgets/vote.dart';
import 'package:vote/widgets/vote_list.dart';
import 'package:vote/state/vote.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentStep = 0;

  @override
  void initState() {

    super.initState();

    //loading votes
    Future.microtask(() {
      Provider.of<VoteState>(context, listen: false).clearState();
      Provider.of<VoteState>(context, listen: false).loadVoteList(context);
    }

    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          if (Provider.of<VoteState>(context, listen: false).voteList == null)
            Container(
              color: Colors.lightBlue,
              child: Center(child:
              Loading(indicator: BallPulseIndicator(), size: 100.0),
              ),
            ),
          if (Provider.of<VoteState>(context, listen: true).voteList != null)
          Expanded(
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              steps: [
                getStep(
                  title: 'Choose',
                  child: VoteListWidget(),
                  isActive: true,
                ),
                getStep(
                  title: 'Vote',
                  child: VoteWidget(),
                  isActive: _currentStep >= 1? true : false,
                ),
              ],
              onStepContinue: () {
                if (_currentStep == 0) {
                  if (step2Required()) {
                    setState(() {
                      _currentStep =
                      (_currentStep + 1) > 1 ? 1 : _currentStep + 1;
                    });
                  }
                  else {
                    showSnackBar(context, 'Please select a vote first!');
                  }
                }
                else if (_currentStep == 1){
                  if (step3Required()){
                    //submit vote
                    markMyVote();

                    //Go to result screen
                    Navigator.pushReplacementNamed(context, '/result');
                  }
                  else{
                    showSnackBar(context, 'Mark your vote fucker!');
                  }
                }
              },
              onStepCancel: (){
                if(_currentStep <=0){
                  Provider.of<VoteState>(context, listen: false).activeVote = null;
                } else if (_currentStep <=1){
                  Provider.of<VoteState>(context, listen: false).selectedOptionInActiveVote = null;
                }
                setState(() {
                  _currentStep = (_currentStep -1)
                      < 0? 0: _currentStep -1;
                });

              },
            ),
          ),
        ],
      ),
    );
  }

  bool step2Required(){
    if (Provider.of<VoteState>(context, listen: false).activeVote == null){
      return false;
    }

    return true;
  }

  bool step3Required() {
    if (Provider.of<VoteState>(context, listen: false).selectedOptionInActiveVote == null){
      return false;
    }

    return true;
  }

  void showSnackBar(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar
      (content: Text(
      msg,
      style: TextStyle(fontSize: 22),
    ),
    ));
  }

  Step getStep({String title, Widget child, bool isActive = false}) {
    return Step(
      title: Text(title),
      content: child,
      isActive: isActive,
    );
  }

  void markMyVote(){
    final voteId =
        Provider.of<VoteState>(context, listen: false).activeVote.voteId;
    final option = Provider.of<VoteState>(context, listen:false).selectedOptionInActiveVote;

    markVote(voteId, option);
  }
}

import 'package:fast_food_health_e/models/ffhe.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fast_food_health_e/state/vote.dart';
import 'package:flutter/material.dart';

List<Vote> getVoteList(){
  //Mock Data
  List <Vote> voteList = <Vote>[];

  voteList.add(
    Vote(
      voteId: Uuid().v4(),
      voteTitle: 'Best iHeart Smooth Jazz Station?',
      options: [
        {'WJJZ': 104},
        {'WNUA': 44},
        {'KKSF': 22},
      ]
    )
  );

  voteList.add(
      Vote(
          voteId: Uuid().v4(),
          voteTitle: 'Best CBS Smooth Jazz Station?',
          options: [
            {'KTWV': 92},
            {'WSJT': 66},
            {'WVMV': 55},
          ]
      )
  );

  voteList.add(
      Vote(
          voteId: Uuid().v4(),
          voteTitle: 'Best local Smooth Jazz Station?',
          options: [
            {'WNWV': 144},
            {'WEIB': 34},
            {'KOAZ': 22},
          ]
      )
  );

  return voteList;
}

// firestore collection name
const String kVotes = 'bidens';
const String kTitle = 'title';

void getVoteListFromFirestore(BuildContext context) async {
//  Firestore.instance.collection(kVotes).snapshots().listen((data) {
//    List<Vote> voteList = List<Vote>();
//
//    data.documents.forEach((DocumentSnapshot document) {
//      Vote vote = Vote(voteId: document.documentID);
//
//      List<Map<String, int>> options = List();
//
//      document.data.forEach((key, value) {
//        if (key == kTitle) {
//          vote.voteTitle = value;
//        } else {
//          options.add({key: value});
//        }
//      });
//
//      vote.options = options;
//      voteList.add(vote);
//    });
//
//    Provider.of<VoteState>(context, listen: false).voteList = voteList;
//  });

  FirebaseFirestore.instance.collection(kVotes).get().then((snapshot) {
    List<Vote> voteList = <Vote>[];



    snapshot.docs.forEach((DocumentSnapshot document) {
      voteList.add(mapFirestoreDocToVote(document));
    });

    Provider.of<VoteState>(context, listen: false).voteList = voteList;
  });
}

Vote mapFirestoreDocToVote(DocumentSnapshot document) {
  Vote vote = Vote(voteId: document.id);
  List<Map<String, int>> options = List();



  document.data().forEach((key, value) {
    if (key == kTitle) {
      vote.voteTitle = value;
    } else {
      options.add({key: value});
    }
  });

  vote.options = options;
  return vote;
}

void markVote(String voteId, String option) async {
  // increment value

  FirebaseFirestore.instance.collection(kVotes).doc(voteId).update({
    option: FieldValue.increment(1),
  });
}

void retrieveMarkedVoteFromFirestore({String voteId, BuildContext context}) {
  // Retrieve updated doc from server
  FirebaseFirestore.instance.collection(kVotes).doc(voteId).get().then((document) {
    Provider.of<VoteState>(context, listen: false).activeVote =
        mapFirestoreDocToVote(document);
  });
}
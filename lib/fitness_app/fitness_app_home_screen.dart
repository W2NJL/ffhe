import 'package:fast_food_health_e/constants.dart';
import 'package:fast_food_health_e/fitness_app/models/tabIcon_data.dart';
import 'package:fast_food_health_e/state/authentication.dart';
import 'package:fast_food_health_e/state/vote.dart';
import 'package:fast_food_health_e/utils/helperFunctions.dart';
import 'package:fast_food_health_e/widgets/appbar.dart';
import 'package:fast_food_health_e/widgets/navdrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'fintness_app_theme.dart';
import 'my_diary/my_diary_screen.dart';
import 'package:fast_food_health_e/widgets/nutritionixList.dart';
import 'package:fast_food_health_e/screens/closest_restaurant_screen.dart';


class FitnessAppHomeScreen extends StatefulWidget {
  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {

  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  static String formattedDate;
  String month;
  int day;
  int year;
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String currDate;
  Position _currentPosition;
  bool locationServicesTimeOut = true;
  HelperFunctions helperFunctions = new HelperFunctions();

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  _getCurrentLocation() async {



      await Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true, timeLimit: Duration(seconds: 5))
          .then((Position position) {



        setState(() {


          _currentPosition = position;
          helperFunctions.storeCoordinatesInSharedPrefs(position);
          locationServicesTimeOut = false;

        });






      }).catchError((e) async {




        if (e.toString().contains("TimeoutException")){
          setState(() {
            locationServicesTimeOut = true;
          });

          //TODO:  HANDLE OTHER EXCEPETIONS HERE
        }



      });

      if (locationServicesTimeOut){
        await _getLastKnownLocation();
      }}

  Future<void> _getLastKnownLocation() async {
    await Geolocator
        .getLastKnownPosition()
        .then((Position position) {



      setState(() {

        _currentPosition = position;
        helperFunctions.storeCoordinatesInSharedPrefs(position);

        //_storeCoordinatesInSharedPrefs(position);
      });



    }).catchError((e) async {






    });}

  void _getDeviceLocationPermissions() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(locationPermsNeeded),
          content: new Text(pleaseAllow),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              style: helperFunctions.flatButtonStyle,
              onPressed: () async {
                await Geolocator.openAppSettings();
              },
              child: Text(getPermissions),
            ),



            new TextButton(
              style: helperFunctions.flatButtonStyle,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(closeWindow),
            ),
          ],
        );
      },
    );
  }




  @override
  void initState() {

    _getCurrentLocation();

    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);




    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title:  Text("...... because fast food can be healthy."),
          content: ConstrainedBox(
            constraints:
            BoxConstraints(minWidth: 10, minHeight: 10),
            child:
            Image.asset("images\/" + "ffhe_logo.PNG",
              width: 70,
              height: 70,


            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        color: FitnessAppTheme.background,
        child: Scaffold(
          drawer: NavDrawer(),
          appBar: DrawerAppBar(
            title: Text(kAppName),
            context: context,


      ),
          backgroundColor: Colors.transparent,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[
                    tabBody,

                  ],
                );
              }
            },
          ),
        ),
      );
    }

  }

  PopupMenuButton getActions(
      BuildContext context ){
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('Change Diet Plan'),
        ),
        PopupMenuItem(
          value: 2,
          child: Text('Limit Listings'),
        ),
        PopupMenuItem(
          value: 3,
          child: Text('Logout'),
        )

      ],
      onSelected: (value) {
        if (value == 1) {
          // logout
          Navigator.pushNamedAndRemoveUntil(context, "DietScreen", (_) => false);
        }

        if (value == 2) {
          // logout
          Navigator.pushNamed(context, 'LimitScreen');
        }


        if (value == 3) {
          // logout
          // authState.checkAuthentication();
          context.read<AuthenticationProvider>().signOut();
Navigator.pushReplacementNamed(context, 'LoginScreen');

        }
      },
    );
  }


  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }





  // Widget bottomBar() {
  //   return Column(
  //     children: <Widget>[
  //       const Expanded(
  //         child: SizedBox(),
  //       ),
  //       BottomBarView(
  //         tabIconsList: tabIconsList,
  //         addClick: () {},
  //         changeIndex: (int index) {
  //           if (index == 0 || index == 2) {
  //             animationController.reverse().then<dynamic>((data) {
  //               if (!mounted) {
  //                 return;
  //               }
  //              Navigator.pushNamed(context, 'RestaurantScreen');
  //             });
  //           } else if (index == 1 || index == 3) {
  //             animationController.reverse().then<dynamic>((data) {
  //               if (!mounted) {
  //                 return;
  //               }
  //               Navigator.pushNamed(context, 'RestaurantScreen');
  //             });
  //           }
  //         },
  //       ),
  //     ],
  //   );
  // }


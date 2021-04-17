import 'package:fast_food_health_e/constants.dart';
import 'package:fast_food_health_e/fitness_app/models/tabIcon_data.dart';
import 'package:fast_food_health_e/fitness_app/traning/training_screen.dart';
import 'package:fast_food_health_e/state/authentication.dart';
import 'package:fast_food_health_e/state/vote.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utilities.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'fintness_app_theme.dart';
import 'my_diary/my_diary_screen.dart';
import 'package:fast_food_health_e/widgets/nutritionixList.dart';
import 'package:fast_food_health_e/screens/restaurant_screen.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationState()),
      ],
    child:
    Consumer<AuthenticationState>(builder: (context, authState, child) {
      return Container(
        color: FitnessAppTheme.background,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
            title: Text(kAppName),
        actions: <Widget>[
          getActions(context, authState),
        ],
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
    )
    );
  }

  PopupMenuButton getActions(
      BuildContext context, AuthenticationState authState) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('Change Diet Plan'),
        ),
        PopupMenuItem(
          value: 2,
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
          // authState.checkAuthentication();
          authState.logout();
          gotoLoginScreen(context, authState);
        }
      },
    );
  }
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


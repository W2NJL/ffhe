import 'package:fast_food_health_e/screens/meal_screen.dart';
import 'package:fast_food_health_e/screens/restaurant_screen.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/constants.dart';
import 'package:fast_food_health_e/screens/home_screen.dart';
import 'package:fast_food_health_e/screens/launch_screen.dart';
import 'package:fast_food_health_e/screens/result_screen.dart';
import 'package:fast_food_health_e/screens/ffhe_screen.dart';
import 'package:fast_food_health_e/screens/dietplan_screen.dart';
import 'package:provider/provider.dart';
import 'package:fast_food_health_e/state/vote.dart';
import 'package:fast_food_health_e/state/authentication.dart';
import 'package:fast_food_health_e/utilities.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fast_food_health_e/fitness_app/fitness_app_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fast_food_health_e/widgets/nutritionixList.dart';
SharedPreferences preferences;


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(VoteApp());
}
class VoteApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => VoteState()),
          ChangeNotifierProvider(create: (_) => AuthenticationState()),
        ],
        child:
        Consumer<AuthenticationState>(builder: (context, authState, child) {
          return MaterialApp(

            initialRoute: '/',
            routes: {
              '/': (context) =>
                Scaffold(
                    body: LaunchScreen(),
                  ),
              'DietScreen': (context) =>  Scaffold(
                body: MyDietPage(),
              ),
              'RestaurantScreen': (context) =>  Scaffold(
                body: RestaurantScreen(),
              ),
              'MealScreen': (context) =>  Scaffold(
                body: MealScreen(),
              ),
              'NutritionList': (context) =>  Scaffold(
                body: NutritionList(),
              ),



              '/home': (context) => Scaffold(
                appBar: AppBar(
                  title: Text(kAppName),
                  actions: <Widget>[
                    getActions(context, authState),
                  ],
                ),
                body: FitnessAppHomeScreen(),
              ),
              '/result': (context) => Scaffold(
                appBar: AppBar(
                  title: Text('Result'),
                  leading: IconButton(
                    icon: Icon(Icons.home),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  actions: <Widget>[
                    getActions(context, authState),
                  ],
                ),
                body: ResultScreen(),
              )
            },
          );
        }));
  }

  PopupMenuButton getActions(
      BuildContext context, AuthenticationState authState) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('Logout'),
        )
      ],
      onSelected: (value) {
        if (value == 1) {
          // logout
          authState.logout();
          gotoLoginScreen(context, authState);
        }
      },
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_health_e/fitness_app/models/todaysMeals.dart';
import 'package:fast_food_health_e/fitness_app/ui_view/testcalendar.dart';
import 'package:fast_food_health_e/screens/Login/login.dart';
import 'package:fast_food_health_e/screens/ask_a_nutritionist.dart';
import 'package:fast_food_health_e/screens/limit_screen.dart';
import 'package:fast_food_health_e/screens/login_screen.dart';
import 'package:fast_food_health_e/screens/meal_screen.dart';
import 'package:fast_food_health_e/screens/resetpw_screen.dart';
import 'package:fast_food_health_e/screens/restaurant_screen.dart';
import 'package:fast_food_health_e/screens/signup_screen.dart';
import 'package:fast_food_health_e/services/firebase_services.dart';
import 'package:fast_food_health_e/state/FastFoodHealthEState.dart';
import 'package:fast_food_health_e/state/authentication.dart';
import 'package:fast_food_health_e/utils/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/constants.dart';
import 'package:fast_food_health_e/screens/home_screen.dart';
import 'package:fast_food_health_e/screens/launch_screen.dart';
import 'package:fast_food_health_e/screens/result_screen.dart';
import 'package:fast_food_health_e/screens/ffhe_screen.dart';
import 'package:fast_food_health_e/screens/dietplan_screen.dart';
import 'package:fast_food_health_e/screens/newdiet_screen.dart';
import 'package:provider/provider.dart';
import 'package:fast_food_health_e/state/vote.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:fast_food_health_e/fitness_app/fitness_app_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fast_food_health_e/widgets/nutritionixList.dart';
SharedPreferences preferences;


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(FastFoodHealthEApp());
}
class FastFoodHealthEApp extends StatelessWidget {
//final FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {



    return MultiProvider(
        providers: [

    Provider<AuthenticationProvider>(
    create: (_) => AuthenticationProvider(FirebaseAuth.instance),
    ),
    StreamProvider(
    create: (context) => context.read<AuthenticationProvider>().authState,
    ),
    ChangeNotifierProvider(create: (_) => FastFoodHealthEState()),
       ],

      child: MaterialApp(

        initialRoute: '/',
        routes: {
          '/': (context) =>
              Scaffold(
                body: Authenticate(),
              ),
          'DietScreen': (context) =>
              Scaffold(
                body: DietScreen(),
              ),
          'RestaurantScreen': (context) =>
              Scaffold(
                body: RestaurantScreen(),
              ),
          'MealScreen': (context) =>
              Scaffold(
                body: MealScreen(),
              ),
          'NutritionList': (context) =>
              Scaffold(
                body: NutritionList(),
              ),
          'TodaysMeals': (context) =>
              Scaffold(
                body: TodaysMeals(),
              ),
          'AskANutritionist': (context) =>
              Scaffold(
                body: AskNutritionist(),
              ),
          'LimitScreen': (context) =>
              Scaffold(
                body: LimitScreen(),
              ),
          'LoginScreen': (context) =>
              Scaffold(
                body: LoginScreen(),
              ),
          'SignUpScreen': (context) =>
              Scaffold(
                body: SignUpScreen(),
              ),
          'ResetPWScreen': (context) =>
              Scaffold(
                body: ResetScreen(),
              ),
          'TestCalendar': (context) =>
              Scaffold(
                body: TestCalendar(),
              ),

          '/home': (context) =>
              Scaffold(
                body: FitnessAppHomeScreen(),
              ),
          '/result': (context) =>
              Scaffold(
                appBar: AppBar(
                  title: Text('Result'),
                  leading: IconButton(
                    icon: Icon(Icons.home),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),

                ),
                body: ResultScreen(),
              )
        },
      ),
    );
  }}


//   PopupMenuButton getActions(
//       BuildContext context, AuthenticationState authState) {
//     return PopupMenuButton<int>(
//       itemBuilder: (context) => [
//         PopupMenuItem(
//           value: 1,
//           child: Text('Logout'),
//         )
//       ],
//       onSelected: (value) {
//         if (value == 1) {
//           // logout
//           authState.logout();
//           gotoLoginScreen(context, authState);
//         }
//       },
//     );
//   }
// }

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
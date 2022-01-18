import 'package:fast_food_health_e/fitness_app/models/todaysMeals.dart';
import 'package:fast_food_health_e/fitness_app/ui_view/testcalendar.dart';
import 'package:fast_food_health_e/screens/Login/login.dart';
import 'package:fast_food_health_e/screens/ask_a_nutritionist.dart';
import 'package:fast_food_health_e/screens/bmi_screen.dart';
import 'package:fast_food_health_e/screens/legal_disclaimer.dart';
import 'package:fast_food_health_e/screens/limit_screen.dart';
import 'package:fast_food_health_e/screens/login_screen.dart';
import 'package:fast_food_health_e/screens/meal_screen.dart';
import 'package:fast_food_health_e/screens/resetpw_screen.dart';
import 'package:fast_food_health_e/screens/closest_restaurant_screen.dart';
import 'package:fast_food_health_e/screens/signup_screen.dart';
import 'package:fast_food_health_e/services/firebase_services.dart';
import 'package:fast_food_health_e/state/FastFoodHealthEState.dart';
import 'package:fast_food_health_e/state/authentication.dart';
import 'package:fast_food_health_e/utils/authenticate.dart';
import 'package:fast_food_health_e/widgets/aboutTheTeam.dart';
import 'package:fast_food_health_e/widgets/favoritesList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/constants.dart';
import 'package:fast_food_health_e/screens/home_screen.dart';
import 'package:fast_food_health_e/screens/launch_screen.dart';
import 'package:fast_food_health_e/screens/ffhe_screen.dart';
import 'package:fast_food_health_e/screens/dietplan_screen.dart';
import 'package:fast_food_health_e/screens/newdiet_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:fast_food_health_e/state/vote.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:fast_food_health_e/fitness_app/fitness_app_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fast_food_health_e/widgets/nutritionixList.dart';

import 'screens/nationwide_restaurant_screen.dart';
SharedPreferences preferences;


void main() async {




  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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

      child: ScreenUtilInit(
    designSize: Size(390, 844),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: () =>MaterialApp(

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
            'BMIScreen': (context) =>
                Scaffold(
                  body: BMIScreen(),
                ),
            'AboutTheTeam': (context) =>
                Scaffold(
                  body: AboutTheTeam(),
                ),
            'FavoritesListScreen': (context) =>
                Scaffold(
                  body: FavoritesList(),
                ),
            'RestaurantScreen': (context) =>
                Scaffold(
                  body: LocalRestaurantScreen(),
                ),
            'NationwideRestaurantScreen': (context) =>
                Scaffold(
                  body: NationwideRestaurantScreen(),
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
            'LegalDisclaimer': (context) =>
                Scaffold(
                  body: LegalDisclaimer(),
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
                )
          },

        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget,

          );
        }
        ),
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
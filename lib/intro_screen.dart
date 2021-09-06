import 'package:fast_food_health_e/fitness_app/fitness_app_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';



/// App widget class.
class IntroScreen extends StatelessWidget {


  // Making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [


    PageViewModel(
      pageBackground: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [0.0, 1.0],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            tileMode: TileMode.repeated,
            colors: [
              Colors.green,
              Colors.blueAccent,
            ],
          ),
        ),
      ),
      iconImageAssetPath: 'assets/images/ffhe_logo.PNG',
      body: Text(
        '...because fast food can be healthy',
        style: GoogleFonts.lato(fontStyle: FontStyle.italic)),
      title: Text('Fast Food Health-E', style: GoogleFonts.lato(fontStyle: FontStyle.normal)),
      mainImage: Image.asset(
        'assets/images/ffhe_logo.PNG',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),


    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
          pages,
          showNextButton: true,
          showBackButton: true,
          onTapDoneButton: () {
            // Use Navigator.pushReplacement if you want to dispose the latest route
            // so the user will not be able to slide back to the Intro Views.
            Navigator.pushReplacementNamed(context, '/home');
          },
          pageButtonTextStyles: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        );

  }
}
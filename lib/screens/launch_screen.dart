import 'dart:math';

import 'package:fast_food_health_e/fitness_app/fitness_app_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_health_e/constants.dart';
import 'package:fast_food_health_e/widgets/shared_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override

  dynamic foodImages = [
    "alex-loup-NcUZLagOHt4-unsplash.jpg",
    "brooke-lark-jUPOXXRNdcA-unsplash.jpg",
    "element5-digital-acrBf9BlfvE-unsplash.jpg",
    "jamie-street-tb5A-QTI6xg-unsplash.jpg",

    "juan-jose-valencia-antia-TTrJMhrkoeY-unsplash.jpg",
    "lum3n-5GK0KjhBLs4-unsplash.jpg",
    "mariana-medvedeva-usfIE5Yc7PY-unsplash.jpg",
    "milada-vigerova-5fj-ShvSEnc-unsplash.jpg",
    "nathan-dumlao-Xt4yZUIpRTo-unsplash.jpg",
    "nutritionbg.jpg",


  ];






  Widget build(BuildContext context) {


    Random rnd;
    int min = 0;
    int max = foodImages.length-1;
    rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    String image_name  = foodImages[r].toString();

   return
 Container(
   decoration: BoxDecoration(
       image: DecorationImage(
           image: AssetImage("images\/" + image_name), fit: BoxFit.cover)),
   child: Container(
        width: 400.w,
        margin: EdgeInsets.all(20.0.r),

        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
        Container(
        margin: EdgeInsets.only(top: 100.h),
        child:  Image.asset("images\/" + "FastFoodHealthELogo_Slogan.png",
height: 250.h,


        ),
      ),
      SizedBox(
      height: 20.0.h,
      ),

       Container(


          child: Column(
          children: <Widget>[
          LoginButton(
          label: 'Sign In',
          onPressed: () =>
      Navigator.pushReplacementNamed(context, 'LoginScreen')
      ),
      SizedBox(
      height: 10.h,
      ),
      LoginButton(
      label: 'Sign Up',
      onPressed: () =>
          Navigator.pushReplacementNamed(context, 'SignUpScreen')
      )]
     ),
      ),]
),
      ),
 );
  }
}




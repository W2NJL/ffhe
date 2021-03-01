import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fast_food_health_e/constants.dart';
import 'package:fast_food_health_e/widgets/shared_widgets.dart';
import 'package:provider/provider.dart';
import 'package:fast_food_health_e/state/authentication.dart';
import 'package:fast_food_health_e/utilities.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic foodImages = [
      "alex-loup-NcUZLagOHt4-unsplash.jpg",
      "brooke-lark-nBtmglfY0HU-unsplash.jpg",
      "brooke-lark-jUPOXXRNdcA-unsplash.jpg",
      "edgar-castrejon-1CsaVdwfIew-unsplash.jpg",
      "element5-digital-acrBf9BlfvE-unsplash.jpg",
      "jamie-street-tb5A-QTI6xg-unsplash.jpg",
      "jony-ariadi-QZub8Ni3x_c-unsplash.jpg",
      "juan-jose-valencia-antia-TTrJMhrkoeY-unsplash.jpg",
      "lum3n-5GK0KjhBLs4-unsplash.jpg",
      "mariana-medvedeva-usfIE5Yc7PY-unsplash.jpg",
      "milada-vigerova-5fj-ShvSEnc-unsplash.jpg",
      "nathan-dumlao-Xt4yZUIpRTo-unsplash.jpg",
      "nutritionbg.jpg",
      "yilmaz-akin-FPKtCl74Hfs-unsplash.jpg",

    ];
    Random rnd;
    int min = 0;
    int max = foodImages.length-1;
    rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    String image_name  = foodImages[r].toString();
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images\/" + image_name), fit: BoxFit.cover)),
      child: Consumer<AuthenticationState>(
        builder: (builder, authState, child) {
          print(authState.authStatus);
          gotoHomeScreen(context, authState);
          return Container(
            width: 400,
            margin: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Text(
                    kAppName,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),



                if (authState.authStatus == kAuthLoading)
                  Text(
                    'loading...',
                    style: TextStyle(fontSize: 12.0),
                  ),
                if (authState.authStatus == null ||
                    authState.authStatus == kAuthError)
                  Container(
                    child: Column(
                      children: <Widget>[
                        LoginButton(
                          label: 'Google Sign In',
                          onPressed: () =>
                              signIn(context, kAuthSignInGoogle, authState),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LoginButton(
                          label: 'Anonymous Sign In',
                          onPressed: () =>
                              signIn(context, kAuthSignInAnonymous, authState),
                        ),
                      ],
                    ),
                  ),
                if (authState.authStatus == kAuthError)
                  Text(
                    'Error...',
                    style: TextStyle(fontSize: 12.0, color: Colors.redAccent),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void signIn(context, String service, AuthenticationState authState) {
    //Navigator.pushReplacementNamed(context, '/home');
    authState.login(serviceName: service);
  }
}
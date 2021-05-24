import 'package:fast_food_health_e/state/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DietAppBar extends AppBar {

  DietAppBar({Key key, Widget title, BuildContext context, String route}) : super(key: key, title: title,
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      automaticallyImplyLeading: false,
      actions: <Widget>[getActions(context), ]);



}



PopupMenuButton getActions(
    BuildContext context ){
  return PopupMenuButton<int>(
    itemBuilder: (context) => [

    PopupMenuItem(
    value: 2,
    child: Text('Favorite Foods'),
    ),

      PopupMenuItem(
        value: 3,
        child: Text('Limit Listings'),
      ),
      PopupMenuItem(
        value: 4,
        child: Text('Logout'),
      )

    ],
    onSelected: (value) {

      if (value == 2) {
        // logout
        Navigator.pushNamed(context, 'FavoritesListScreen');
      }


      if (value == 3) {
        // logout
        Navigator.pushNamed(context, 'LimitScreen');
      }


      if (value == 4) {
        // logout
        // authState.checkAuthentication();
        context.read<AuthenticationProvider>().signOut();
        Navigator.pushReplacementNamed(context, 'LoginScreen');

      }
    },
  );
}
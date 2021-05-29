import 'package:fast_food_health_e/state/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child:ConstrainedBox(
          constraints:
          BoxConstraints(minWidth: 10, minHeight: 10),
      child:
      Image.asset("images\/" + "ffhe_logo.PNG",
        width: 70,
        height: 70,


      ),
    ),
            decoration: BoxDecoration(

                color: Colors.green,
                image: DecorationImage(
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Home'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.food_bank),
            title: Text('Your Meal History'),
            onTap: () => {Navigator.pushNamed(context, 'TodaysMeals')},
          ),
          ListTile(
            leading: Icon(Icons.emoji_food_beverage),
            title: Text('Favorite Foods'),
            onTap: () => {Navigator.pushNamed(context, 'FavoritesListScreen')},
          ),
          ListTile(
            leading: Icon(Icons.emoji_people),
            title: Text('Change Diet Plan'),
            onTap: () => { Navigator.pushNamedAndRemoveUntil(context, "DietScreen", (_) => false)},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Restaurant Listing Setting'),
            onTap: () => {Navigator.pushNamed(context, 'LimitScreen')},
          ),

          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Ask A Nutritionist'),
            onTap: () => {Navigator.pushNamed(context, 'AskANutritionist')},
          ),
          ListTile(
            leading: Icon(Icons.people_sharp),
            title: Text('About The Team'),
            onTap: () => {Navigator.pushNamed(context, 'AboutTheTeam')},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => { context.read<AuthenticationProvider>().signOut(),
    Navigator.pushReplacementNamed(context, 'LoginScreen')},
          ),
        ],
      ),
    );
  }
}
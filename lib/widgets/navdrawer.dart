import 'package:fast_food_health_e/state/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class NavDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var user = context.read<AuthenticationProvider>().getCurrentUser();
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
            leading: Icon(Icons.fact_check_outlined),
            title: Text('Legal Disclaimer'),
            onTap: () => {Navigator.pushNamed(context, 'LegalDisclaimer')},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => { context.read<AuthenticationProvider>().signOut(),
    Navigator.pushReplacementNamed(context, 'LoginScreen')},
          ),
          ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text('Delete Your Account'),
            onTap: () => {
            confirmDeletionAlert(context)


              },
          ),
        ],
      ),
    );
  }
}

void confirmDeletionAlert(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.info,
    title: "Delete your account?",
    style: AlertStyle(
      descStyle: TextStyle(fontSize: 12.sp),
      descTextAlign: TextAlign.start,
    ),
    desc:
    "Delete Your Fast Food Health-E Account?",
    buttons: [
      DialogButton(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "Yes",
            style: TextStyle(
                color: Colors.white, fontSize: 15.sp),
          ),
        ),
        color: Color.fromRGBO(0, 179, 134, 1.0),
        onPressed: () async {




          deleteUser().then((value) => Navigator.pushReplacementNamed(context, 'LoginScreen'));
        },
      ),
      DialogButton(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "No!",
            style: TextStyle(
                color: Colors.white, fontSize: 20.sp),
          ),
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ],
  ).show();
}

Future deleteUser() async {

  User user = await FirebaseAuth.instance.currentUser;
  user.delete();
}
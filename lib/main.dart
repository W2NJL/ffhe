import 'package:flutter/material.dart';
import 'package:vote/constants.dart';
import 'package:vote/screens/home_screen.dart';
import 'package:vote/screens/launch_screen.dart';
import 'package:vote/screens/result_screen.dart';
import 'package:provider/provider.dart';
import 'package:vote/state/vote.dart';
import 'package:vote/state/authentication.dart';
import 'package:vote/utilities.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
              '/': (context) => Scaffold(
                body: LaunchScreen(),
              ),
              '/home': (context) => Scaffold(
                appBar: AppBar(
                  title: Text(kAppName),
                  actions: <Widget>[
                    getActions(context, authState),
                  ],
                ),
                body: HomeScreen(),
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
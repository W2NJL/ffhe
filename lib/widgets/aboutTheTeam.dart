import 'dart:io';

import 'package:fast_food_health_e/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutTheTeam extends StatefulWidget {
  @override
  AboutTheTeamState createState() => AboutTheTeamState();
}

class AboutTheTeamState extends State<AboutTheTeam> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text("About The Team"),
        context: context,
        route: '/home',
      ),
      body: SizedBox(),
    );
  }
}
import 'dart:io';

import 'package:fast_food_health_e/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutTheTeam extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: MyAppBar(
      route: '/home',
      context: context,
      title:   FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('About The Fast Food Health-E Team')
      ),
    ),
  body: SingleChildScrollView(
    child: Column(
    children: <Widget>[
    Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.redAccent, Colors.pinkAccent]
    )
    ),
    child: Container(
    width: double.infinity,
    height: 150.0,
    child: Center(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    CircleAvatar(
    backgroundImage: NetworkImage(
    "https://static.wixstatic.com/media/7d5dd4_83aa8b791f8840bc8aaa0762ec26c77e~mv2.jpg/v1/fill/w_200,h_200,al_c,q_80,usm_0.66_1.00_0.01/Theresa%20Capriotti.webp",
    ),
    radius: 50.0,
    ),
    SizedBox(
    height: 10.0,
    ),
    Text(
    "THERESA CAPRIOTTI",
    style: TextStyle(
    fontSize: 22.0,
    color: Colors.white,
    ),
    ),
    SizedBox(
    height: 10.0,
    ),

    ],
    ),
    ),
    )
    ),
    Container(
    child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text(
    "Bio:",
    style: TextStyle(
    color: Colors.redAccent,
    fontStyle: FontStyle.normal,
    fontSize: 28.0
    ),
    ),
    SizedBox(
    height: 10.0,
    ),
    Text('Teaching and providing health care for 40 years.  Registered nurse since 1979. Family physician since 1983. University clinical professor since 1995.'
    ,style: TextStyle(
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    color: Colors.black,
    letterSpacing: 2.0,
    ),
    ),
    ],
    ),
    ),
    ),
    SizedBox(
    height: 20.0,
    ),
    Container(
    width: 300.00,


    ),
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.redAccent, Colors.pinkAccent]
              )
          ),
          child: Container(
            width: double.infinity,
            height: 150.0,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("images\/" + "cathie.png",
height: 100,


                    ),


                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "CATHIE CAPRIOTTI",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                ],
              ),
            ),
          )
      ),
      Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Bio:",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontStyle: FontStyle.normal,
                    fontSize: 28.0
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('Cathie holds a Bachelor of Science Degree in Dietetics and Food Administration and a Master of Science degree in Food Marketing.  For over 30 years worked as a nutritionist and civil servant.',
                style: TextStyle(
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Container(
        width: 300.00,


      ),
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.redAccent, Colors.pinkAccent]
              )
          ),
          child: Container(
            width: double.infinity,
            height: 150.0,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://static.wixstatic.com/media/7d5dd4_923b0fcd34e04591bacd30f52b5a2a57~mv2.jpg/v1/fill/w_200,h_200,al_c,q_80,usm_0.66_1.00_0.01/DSC00941_JPG.webp",
                    ),
                    radius: 50.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "NICK LANGAN",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                ],
              ),
            ),
          )
      ),
      Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Bio:",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontStyle: FontStyle.normal,
                    fontSize: 28.0
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('Nick Langan is a Software Engineering M.S. student from Tabernacle, NJ.  He graduated with a Bachelor\'s degree in Information Systems and has background working in IT and the radio industry.'
                ,style: TextStyle(
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Container(
        width: 300.00,


      ),
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.redAccent, Colors.pinkAccent]
              )
          ),
          child: Container(
            width: double.infinity,
            height: 150.0,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://static.wixstatic.com/media/7d5dd4_76971b566f6347cfbd1dab42b5a2cf87~mv2.jpg/v1/fill/w_200,h_200,al_c,q_80,usm_0.66_1.00_0.01/IMG_4066_edited.webp",
                    ),
                    radius: 50.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "ROBERT ROTYLIANO",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                ],
              ),
            ),
          )
      ),
      Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Bio:",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontStyle: FontStyle.normal,
                    fontSize: 28.0
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('Robert is a computer engineering student with a minor in computer science and mechatronics.  He is from Medford, NJ. In addition to this project, he is working on the design of a low cost, accurate spectrophotometer.'
                ,style: TextStyle(
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Container(
        width: 300.00,


      )
    ],
    ),
  ),
  );
  }
  }

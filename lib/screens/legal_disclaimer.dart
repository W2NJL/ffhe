import 'package:fast_food_health_e/fitness_app/fintness_app_theme.dart';
import 'package:fast_food_health_e/widgets/appbar.dart';
import 'package:flutter/material.dart';
import '../utils/email_screen.dart';


class LegalDisclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Legal Disclaimer!';

    return Scaffold(
      appBar: MyAppBar(
        route: '/home',
        title: Text(appTitle),
        context: context,
      ),
      body: LegalDisclaimerPage(),
    );

  }
}

// Create a Form widget.
class LegalDisclaimerPage extends StatefulWidget {
  @override
  LegalDisclaimerPageState createState() {
    return LegalDisclaimerPageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class LegalDisclaimerPageState extends State<LegalDisclaimerPage > {


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "Fast Food Health E contains content for informational purposes only and is not intended as medical advice or the substitute of the advice of a physician or other licensed health care professional. Users should consult their health care professional before initiating any new diet or nutritional regimen. ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  letterSpacing: -0.2,
                  color: FitnessAppTheme.darkerText,
                ),
              ),
SizedBox(height: 50,),
              Text("© 2021 Capriotti Preventive Health Care LLC.  FAST FOOD HEALTH-E is a trademark of Capriotti Preventive Health Care LLC.  All restaurant logos and company names are trademarks or registered trademarks of their respective owners, and no affiliation or endorsement is implied."
                  , textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  letterSpacing: -0.2,
                  color: FitnessAppTheme.darkerText,
                ),)
            ],
          ),
        ),
      );
  }
}
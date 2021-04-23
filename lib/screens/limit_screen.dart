import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/email_screen.dart';


class LimitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Toggle Restaurant results limiting';

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: LimitToggle(),
    );

  }
}

// Create a Form widget.
class LimitToggle extends StatefulWidget {
  @override
  LimitToggleState createState() {
    return LimitToggleState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class LimitToggleState extends State<LimitToggle > {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String email = "";
  String name = "";
  String location = "";
  String message = "";
  List<String> sendToNutritionist = <String>[];
  bool setList = true;




  LimitToggleState(){
    _getLimitPref() .then((value) => setState(() {
      setList = value;

    }));}

  void _submit() {
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      sendToNutritionist.add(name);
      sendToNutritionist.add(email);
      sendToNutritionist.add(location);
      sendToNutritionist.add(message);
      sendAnEmail(sendToNutritionist);
      Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Message sent to nutritionist!')));
    }


  }
    @override
  Widget build(BuildContext context) {
    final int count = 4;

    return Scaffold(
      body: Column(
        children: <Widget>[
            ListTile(
              title: Text(
                'Limit restaurant listings based on diet plans',
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.black),
              ),
              leading: Switch(
                value: setList,
                activeColor: Color(0xFF6200EE),
                onChanged: (bool value) {
                  setState(() {
                    setList = value;

                  });

                  _storeLimitPref(setList);
                },
              ),
            ),
        ],
      ),
    );
  }
}

Future <bool> _getLimitPref() async {


  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("listings");
}

void _storeLimitPref(bool preference) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("listings", preference);
}
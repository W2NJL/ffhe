import 'package:flutter/material.dart';
import '../utils/email_screen.dart';


class AskNutritionist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Ask A Nutritionist!';

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: NutritionistForm(),
    );

  }
}

// Create a Form widget.
class NutritionistForm extends StatefulWidget {
  @override
  NutritionistFormState createState() {
    return NutritionistFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class NutritionistFormState extends State<NutritionistForm > {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String email = "";
  String name = "";
  String location = "";
  String message = "";
  List<String> sendToNutritionist = <String>[];

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
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Your Name'),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your name!';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'E-Mail'),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }
                        return null;
                      },
                    ),
                    // this is where the
                    // input goes
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Your Location'),
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your location!';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          location = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 200,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Enter your question!'),
                        keyboardType: TextInputType.multiline,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a message!';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            message = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                         _submit();
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
              // this is where
              // the form field
              // are defined
              SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      );
  }
}
import 'package:fast_food_health_e/screens/Login/text_field_container.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';


class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String initialValue;


  RoundedPasswordField ({this.onChanged, this.initialValue});


  @override
  State<StatefulWidget> createState() => new RoundedPasswordFieldState(onChanged, initialValue);
}



class RoundedPasswordFieldState extends State<RoundedPasswordField>  {
final ValueChanged<String> changed;
final String firstValue;
bool obscure = true;

  RoundedPasswordFieldState(this.changed, this.firstValue);







  @override
  Widget build(BuildContext context) {


    _toggleObscure(){
      setState(() {
        obscure = !obscure;
      });
    }

    return TextFieldContainer(
      child: TextFormField(

                obscureText: obscure,
        onChanged: changed,
        cursorColor: kPrimaryColor,
        initialValue: firstValue,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(

              Icons.visibility,
              color: kPrimaryColor,
            ),
            onPressed:  _toggleObscure(),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

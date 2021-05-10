import 'package:fast_food_health_e/screens/Login/text_field_container.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';


class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String initialValue;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
                obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

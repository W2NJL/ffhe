import 'package:fast_food_health_e/screens/Login/text_field_container.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';


class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String initialValue;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.initialValue,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: onChanged,
       initialValue: initialValue,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,

          border: InputBorder.none,
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends StatelessWidget{
  String label;
  double size;
  Function onPressed;

  LoginButton({this.label, this.size = 300.0, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: size,
      child: MaterialButton(
        height: 40.0.h,
        padding: EdgeInsets.all(15.0.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        color: Colors.blueAccent[200],
        child: Text(
          label,
          style: TextStyle(
            fontSize: 25.0.sp,
            color: Colors.white
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
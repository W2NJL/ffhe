import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestCalendar extends StatefulWidget {
  @override
  _TestCalendarState createState() => _TestCalendarState();
}
class _TestCalendarState extends State<TestCalendar> {
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DatePicker"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(currentDate.toString()),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
            ),
          ],
        ),
      ),
    );
  }
}
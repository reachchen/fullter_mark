import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('日历'),
      ),
      body: Center(
        child: Text(
          this.runtimeType.toString(),
        ),
      ),
    );
  }
  
  
}
import 'package:flutter/material.dart';

class ReusableTextList extends StatelessWidget {
  Color color;
  String typeEventLife;
  String timeEventLife;
  ReusableTextList(
      {@required this.color,
      @required this.typeEventLife,
      @required this.timeEventLife});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        typeEventLife + ' a ' + timeEventLife,
        textScaleFactor: 1.2,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

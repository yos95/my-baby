import 'package:flutter/material.dart';
class ReusableButtonAction extends StatelessWidget {
  Color color;
  String text;
  Function onPressed;
  ReusableButtonAction({this.color, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: RaisedButton(
          color: color,
          child: Text(text),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ReusableCard extends StatelessWidget {
  List<Widget> listText;
  ReusableCard({this.listText});
  var logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 1.1,
          height: MediaQuery.of(context).size.height / 2,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          child: Card(
            color: Colors.white,
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 250,
                        height: 300,
                        child: new ListView(
                          reverse: true,
                          padding: const EdgeInsets.all(8.0),
                          children: listText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

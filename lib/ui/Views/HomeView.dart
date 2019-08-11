import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_baby/core/Models/EventLife.dart';
import 'package:my_baby/ui/Widgets/ReusableButton.dart';
import 'package:my_baby/ui/Widgets/ReusableCard.dart';
import 'package:my_baby/ui/Widgets/ReusableTextList.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:intl/date_symbol_data_local.dart';

var logger = Logger();

DateTime date = DateTime.now();
List<Widget> listText = [];

class HomeView extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting("fr_FR");
  }

  var ColorDynamiqueSwitch;
  List<EventLife> eventLifeOb;
  List<DocumentSnapshot> dataUP;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My baby'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                      child: Text(
                        DateFormat.MMMMEEEEd("fr_FR")
                            .format(new DateTime.now())
                            .toString(),
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 1.6,
                      child: StreamBuilder(
                          stream: Firestore.instance
                              .collection('users-data')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              eventLifeOb = snapshot.data.documents
                                  .map((doc) => EventLife.fromMap(
                                      doc.data["06-06-2019"], doc.documentID))
                                  .toList();
                              listText.clear();

                              for (var a in eventLifeOb[0].eventLifeList) {
                                setColor(a.values.toString());

                                var newKey = a.keys
                                    .toString()
                                    .replaceAll('(', '')
                                    .replaceAll(')', '');
                                var Key = newKey.split(':');
                                var formatedKey = Key[0] + ':' + Key[1];

                                listText.add(
                                  ReusableTextList(
                                    color: ColorDynamiqueSwitch,
                                    typeEventLife: a.values
                                        .toString()
                                        .replaceAll('(', '')
                                        .replaceAll(')', ''),
                                    timeEventLife: formatedKey,
                                  ),
                                );
                              }

                              return ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (buildContext, index) {
                                    return Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.7,
                                      child: Swiper(
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          logger.d(listText.length);
                                          return new ReusableCard(
                                              listText: listText);
                                        },
                                        itemCount: 1,
                                        viewportFraction: 0.8,
                                        scale: 0.9,
                                      ),
                                    );
                                  });
                            } else {
                              return Text('fetching');
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ReusableButtonAction(
                    color: Colors.lightGreen,
                    text: 'Pipi',
                    onPressed: () {
                      updateFirebase(newValue: 'Pipi');
                    },
                  ),
                  ReusableButtonAction(
                    color: Colors.brown,
                    text: 'Caca',
                    onPressed: () {
                      updateFirebase(newValue: 'Caca');
                    },
                  ),
                  ReusableButtonAction(
                    color: Colors.lightBlue,
                    text: 'Manger',
                    onPressed: () {
                      logger.d('manger');
                      updateFirebase(newValue: 'Manger');
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void setColor(String value) {
    switch (value) {
      case '(Pipi)':
        ColorDynamiqueSwitch = Colors.lightGreen;
        break;
      case '(Caca)':
        ColorDynamiqueSwitch = Colors.brown;
        break;
      case '(Manger)':
        ColorDynamiqueSwitch = Colors.lightBlueAccent;
        break;
    }
  }
}

void updateFirebase({String newValue}) {
  DateTime now = DateTime.now();
  String newKey = DateFormat('HH:mm:ss').format(now);

  Firestore.instance
      .collection("users-data")
      .document("ArKH4nWM3pR9qtz70BtPf3fWFbV2")
      .updateData({"06-06-2019.$newKey": newValue});
}

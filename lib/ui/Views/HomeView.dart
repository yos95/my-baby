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
var dateCollectionFirebase =
    new DateFormat("dd-MM-yyyy").format(date).toString();

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

  List<Map<String, String>> eventLifeList = [];

  var ColorDynamiqueSwitch;
  List<EventLife> eventLifeOb;

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
                              .document('ArKH4nWM3pR9qtz70BtPf3fWFbV2')
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            List<Widget> listText = [];
                            var NewMap =
                                snapshot.data.data[dateCollectionFirebase];
                            logger.d(NewMap);
                            if (!(NewMap == null)) {
                              var timet = DateFormat.MMMMEEEEd("fr_FR")
                                  .format(new DateTime.now())
                                  .toString();
                              eventLifeList.clear();
                              NewMap.forEach((k, v) {
                                eventLifeList.add({k: v});
                              });

                              listText.clear();
                              for (var a in eventLifeList.reversed) {
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
                              logger.d('listText lenght ' +
                                  listText.length.toString());
                              return new ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (buildContext, index) {
                                    return Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.7,
                                      child: new Swiper(
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          logger.d('listText : ' +
                                              listText.length.toString());
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
                              listText.add(Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  'Commencez par saisir un event Life',
                                  textScaleFactor: 1.2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ));
                              return ReusableCard(listText: listText);
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
                      setState(() {
                        updateFirebase(newValue: 'Manger');
                      });
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

  void updateFirebase({String newValue}) {
    DateTime now = DateTime.now();
    String newKey = DateFormat('HH:mm:ss').format(now);

    Firestore.instance
        .collection("users-data")
        .document("ArKH4nWM3pR9qtz70BtPf3fWFbV2")
        .updateData({"$dateCollectionFirebase.$newKey": newValue});
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
      case '(test)':
        ColorDynamiqueSwitch = Colors.red;
        break;
    }
  }
}

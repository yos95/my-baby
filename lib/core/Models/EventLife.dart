import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_baby/ui/Views/HomeView.dart';
import 'package:my_baby/ui/Widgets/ReusableTextList.dart';

var logger = Logger();

class EventLife {
  var jour;
  List<Map<String, String>> eventLifeList = [];

  EventLife({this.jour, this.eventLifeList});

  EventLife.fromMap(Map eventLif, var jour) {
    eventLif.forEach((k, v) {
      eventLifeList.add({k: v});
    });
  }
  List<Map<String, String>> getData() {
    return eventLifeList;
  }
}

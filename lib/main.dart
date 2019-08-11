import 'package:flutter/material.dart';

import 'package:my_baby/ui/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      title: 'Product App',
      theme: ThemeData(),
      onGenerateRoute: Router.generateRoute,
    );
  }
}

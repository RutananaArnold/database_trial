import 'package:database_trial/screens/page3.dart';
import 'package:flutter/material.dart';
import 'package:database_trial/screens/page1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.orange,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            centerTitle: true,
            title: Text(
              'Saving and Retrieving data from the database',
              style: TextStyle(color: Colors.black87),
            ),
          ),
          body: Page1(),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kinender_mobile/user_check.dart';
import 'home/home.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kinender_mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: Home(),
      home: UserCheck(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/home_screen/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'news app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: secondaryColor1
      ),
      home: HomeView(),
    );
  }
}

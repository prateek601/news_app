import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';

class Spinner extends StatelessWidget {
  const Spinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor:AlwaysStoppedAnimation<Color>(primaryColor1),
    );
  }
}

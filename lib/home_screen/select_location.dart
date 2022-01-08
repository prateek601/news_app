import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({Key? key}) : super(key: key);

  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  String location = 'India';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'LOCATION',
          style: TextStyle(
            fontSize: 10,
            color: secondaryColor1
          ),
        ),
        Row(
          children: [
            Icon(Icons.location_on,size: 16,),
            Text(
              SelectedVar.country,
              style: TextStyle(
                fontSize: 12,
                color: secondaryColor2
              ),
            )
          ],
        )
      ],
    );
  }
}

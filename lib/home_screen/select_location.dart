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
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Text(
            'LOCATION',
            style: TextStyle(
              fontSize: 13,
              color: secondaryColor1
            ),
          ),
          Row(
            children: [
              Icon(Icons.location_on),
              Text(
                location,
                style: TextStyle(
                  fontSize: 16,
                  color: secondaryColor2
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

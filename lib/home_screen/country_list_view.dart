import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';

class CountryListView extends StatefulWidget {
  const CountryListView({Key? key}) : super(key: key);

  @override
  _CountryListViewState createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: countryList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          bool isChecked = false;
          if(SelectedVar.country == countryList[index]) {
            isChecked = true;
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                countryList[index],
                style: TextStyle(
                    color: isChecked ? primaryColor1 : Colors.black
                ),
              ),
              Radio(
                value: true,
                groupValue: isChecked,
                activeColor: primaryColor1,
                onChanged: (value) {
                  SelectedVar.country = countryList[index];
                  setState(() {});
                },
              )
            ],
          );
        }
    );
  }
}

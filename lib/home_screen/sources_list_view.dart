import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';

class SourcesListView extends StatefulWidget {
  const SourcesListView({Key? key}) : super(key: key);

  @override
  _SourcesListViewState createState() => _SourcesListViewState();
}

class _SourcesListViewState extends State<SourcesListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsSources.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        bool isChecked;
        if(SelectedVar.sources.contains(newsSources[index])) {
          isChecked = true;
        } else {
          isChecked = false;
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              newsSources[index],
              style: TextStyle(
                color: isChecked ? primaryColor1 : Colors.black
              ),
            ),
            Checkbox(
              checkColor: Colors.white,
              value: isChecked,
              onChanged: (bool? value) {
                if(value == true) {
                  SelectedVar.sources.add(newsSources[index]);
                } else {
                  SelectedVar.sources.remove(newsSources[index]);
                }
                print(SelectedVar.sources);
                setState(() {});
              },
            )
          ],
        );
      }
    );
  }
}

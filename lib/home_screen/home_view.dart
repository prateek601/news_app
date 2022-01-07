import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/home_screen/news_list.dart';
import 'package:news_app/home_screen/select_location.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'MyNEWS',
              style: TextStyle(
                color: secondaryColor1
              ),
            ),
            SelectLocation()
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 30),
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: secondaryColor2,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Search for news, topics...',
                        style: TextStyle(
                          fontSize: 12,
                          color:  Colors.grey[500]
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey[700],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Headlines',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor2
                  ),

                ),
                Row(
                  children: [
                    Text(
                      'Sort: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700]
                      ),
                    ),
                    Text(
                      'Newest',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[900],
                      )
                    ),
                    Icon(
                      Icons.arrow_drop_down
                    )
                  ],
                )
              ],
            ),
            NewsList()
          ],
        ),
      ),
    );
  }
}

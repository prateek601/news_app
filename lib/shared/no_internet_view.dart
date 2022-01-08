import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/util/check_internet.dart';

typedef void ConnectionResumed();
class NoInternetView extends StatelessWidget {
  final ConnectionResumed connectionResumed;
  const NoInternetView({
    Key? key,
    required this.connectionResumed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/no_internet.png',
          height: 120,
          width: 120,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15,bottom: 20),
          child: Text(
            'No internet Connection!',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 18
            ),
          ),
        ),
        InkWell(
          onTap: () {
            checkInternet(
              internetConnected: () {
                connectionResumed();
              },
              internetNotConnected: () {}
            );
          },
          child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
                color: primaryColor1,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Center(
                child: Text(
                  'Try again',
                  style: TextStyle(
                    color: secondaryColor2,
                    fontSize: 16
                  ),
                )
            ),
          ),
        )
      ]
    );
  }
}

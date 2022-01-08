import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';

typedef void OnButtonTap();

  Future<void> bottomSheet({
    required BuildContext context,
    required String heading,
    required Widget listWidget,
    required String buttonName,
    required OnButtonTap onButtonTap
  }) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)
        )
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                            color: secondaryColor2,
                            borderRadius: BorderRadius.circular(2)
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20,bottom: 20),
                          child: Text(
                            heading,
                            style: TextStyle(
                                fontSize: 14,
                                color: primaryColor2,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 1,
                      color: secondaryColor2,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          listWidget,
                          Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                onButtonTap();
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
                                      buttonName,
                                      style: TextStyle(
                                          color: secondaryColor2
                                      ),
                                    )
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
    });
  }
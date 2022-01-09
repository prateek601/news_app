import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/data_model/news.dart';
import 'package:news_app/home_screen/country_list_view.dart';
import 'package:news_app/home_screen/select_location.dart';
import 'package:news_app/home_screen/sources_list_view.dart';
import 'package:news_app/search_screen/search_view.dart';
import 'package:news_app/shared/bottom_sheet.dart';
import 'package:news_app/shared/news_list.dart';
import 'package:news_app/shared/no_internet_view.dart';
import 'package:news_app/shared/spinner.dart';
import 'package:news_app/util/check_internet.dart';
import 'package:news_app/util/http_util.dart';

enum screenState {
  loading,
  noInternet,
  dataFetched,
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late News news;
  int page = 1;
  List<Article> articles = [];
  bool reachedMaxScrollExtent = false;
  int totalResults = 0;
  int totalPages = 1;
  late int _pageSize;

  var scrollController = ScrollController();
  var state = screenState.loading;

  @override
  void initState() {
    super.initState();
    checkInternet(
      internetConnected: () {
        setState(() {
          state = screenState.loading;
          fetchData();
        });
      },
      internetNotConnected: () {
        setState(() {
          state = screenState.noInternet;
        });
      }
    );

    _pageSize = int.parse(pageSize);

    String? countryCode = WidgetsBinding.instance!.window.locale.countryCode;
    if(countryCode != null) {
      String countryCodeToLowerCase = countryCode.toLowerCase();
      String country = countryMap.keys.firstWhere((k) => countryMap[k] ==
          countryCodeToLowerCase, orElse: () => 'India');
      SelectedVar.country = country;
    }

    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        print(page);
        page++;
        if(page <= totalPages) {
          fetchData(reachedMaxExtent: true);
          setState(() {
            reachedMaxScrollExtent = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

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
                color: secondaryColor1,
                fontSize: 18
              ),
            ),
            InkWell(
              onTap: () {
                openCountryBottomSheet();
              },
              child: SelectLocation()
            )
          ],
        ),
      ),
      floatingActionButton: state == screenState.noInternet
        ?
      null
        :
      FloatingActionButton(
        onPressed: () {
          openBottomSheet();
        },
        backgroundColor: primaryColor1,
        child: Image.asset(
          'assets/filter.png',
          height: 20,
          width: 20,
        ),
        tooltip: 'News source',
      ),
      body: state == screenState.noInternet
      ?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NoInternetView(
                connectionResumed: () {
                  setState(() {
                    state = screenState.loading;
                  });
                  fetchData();
                },
              ),
            ],
          ),
        ],
      )
      :
      SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 60),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SearchView()));
                },
                child: Padding(
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
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
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
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            items: sortPreference.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: primaryColor2,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if(SelectedVar.sources.isNotEmpty) {
                                setState(() {
                                  state = screenState.loading;
                                  SelectedVar.sortBy = value!;
                                });
                                fetchData();
                              } else {
                                showToast();
                              }
                            },
                            borderRadius: BorderRadius.circular(10),
                            value: SelectedVar.sortBy,
                            isDense: true,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[900]
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              myWidget()
            ],
          ),
        ),
      ),
    );
  }

  void openBottomSheet() {
    bottomSheet(
      context: context,
      heading: 'Filter by sources',
      listWidget: SourcesListView(),
      buttonName: 'Apply Filter',
      onButtonTap: () {
        page = 1;
        fetchData();
        setState(() {
          state = screenState.loading;
        });
      }
    );
  }

  void fetchData({bool reachedMaxExtent = false}) {
    String pageNum = page.toString();
    String url;
    String sources = '';
    String country = countryMap[SelectedVar.country]!;

    if(SelectedVar.sources.isEmpty) {
      url = 'https://newsapi.org/v2/top-headlines?country=$country'
          '&pageSize=$pageSize&page=$pageNum';
    } else {
      for(int i=0; i<SelectedVar.sources.length ; i++) {
        String selectedSources = newsSourceMap[SelectedVar.sources[i]]!;
        if(i == SelectedVar.sources.length - 1) {
          sources = sources + selectedSources;
        } else {
          sources = sources + selectedSources + ',';
        }
      }
      String sortBy = sortPreferenceMap[SelectedVar.sortBy]!;
      url = 'https://newsapi.org/v2/everything?sources=$sources&sortBy=$sortBy'
          '&pageSize=$pageSize&page=$pageNum';
    }

    HttpUtil().makeGetRequest(
        url: url,
        onRequestCompleted: (responseBody) {
          setState(() {
            news = News.fromJson(responseBody);
            state = screenState.dataFetched;
            if(reachedMaxExtent) {
              articles.addAll(news.articles);
              reachedMaxScrollExtent = false;
            } else {
              articles.clear();
              articles.addAll(news.articles);
              totalResults = news.totalResults;
              totalPages = totalResults~/_pageSize + 1;
            }
          });
        },
        onRequestFailed: () {},
        noInternet: () {
          setState(() {
            state = screenState.noInternet;
          });
        }
    );
  }

  void openCountryBottomSheet() {
    bottomSheet(
      heading: 'Choose your location',
      context: context,
      buttonName: 'Apply',
      listWidget: CountryListView(),
      onButtonTap: () {
        // clearing selected news source list as country and sources cannot be
        // used together to make get request
        // https://newsapi.org/docs/endpoints/top-headlines
        SelectedVar.sources.clear();
        page = 1;
        fetchData();
        setState(() {
          state = screenState.loading;
        });
      }
    );
  }

  void showToast() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'First select the news source then apply the sort preference'
        )
      )
    );
  }

   Widget myWidget() {
    switch(state) {
      case screenState.loading:
        return Spinner();
      default:
        return Column(
          children: [
            NewsList(
              articles: articles,
            ),
            reachedMaxScrollExtent
                ?
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Spinner(),
            )
                :
            Container()
          ],
        );
    }
  }

}

import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/data_model/news.dart';
import 'package:news_app/home_screen/select_location.dart';
import 'package:news_app/home_screen/sources_list_view.dart';
import 'package:news_app/shared/bottom_sheet.dart';
import 'package:news_app/shared/news_list.dart';
import 'package:news_app/shared/spinner.dart';
import 'package:news_app/util/http_util.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = true;
  late News news;
  int page = 1;
  List<Article> articles = [];
  bool reachedMaxScrollExtent = false;
  int totalResults = 0;
  int totalPages = 1;
  late int _pageSize;

  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _pageSize = int.parse(pageSize);

    String countryCode = WidgetsBinding.instance!.window.locale.countryCode!;
    SelectedVar.country = countryCode.toLowerCase();

    fetchData();

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openBottomSheet();
        },
        backgroundColor: primaryColor1,
        child: const Icon(Icons.sort),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 60),
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
              ),
              isLoading
              ?
              Spinner()
              :
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
          isLoading = true;
        });
      }
    );
  }

  void fetchData({bool reachedMaxExtent = false}) {
    String pageNum = page.toString();
    String url;
    String sources = '';
    if(SelectedVar.sources.isEmpty) {
      url = 'https://newsapi.org/v2/top-headlines?country=${SelectedVar.country}'
          '&sortBy=${SelectedVar.sortBy}&pageSize=$pageSize&page=$pageNum';
    } else {
      for(int i=0; i<SelectedVar.sources.length ; i++) {
        String selectedSources = newsSourceMap[SelectedVar.sources[i]]!;
        if(i == SelectedVar.sources.length - 1) {
          sources = sources + selectedSources;
        } else {
          sources = sources + selectedSources + ',';
        }
      }
      url = 'https://newsapi.org/v2/top-headlines?sources=$sources'
          '&pageSize=$pageSize&page=$pageNum';
    }

    HttpUtil().makeGetRequest(
        url: url,
        onRequestCompleted: (responseBody) {
          setState(() {
            news = News.fromJson(responseBody);
            isLoading = false;
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
        onRequestFailed: () {}
    );
  }

}

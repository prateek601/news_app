import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/data_model/news.dart';
import 'package:news_app/shared/news_list.dart';
import 'package:news_app/shared/spinner.dart';
import 'package:news_app/util/http_util.dart';

class NewsListWrapper extends StatefulWidget {
  const NewsListWrapper({Key? key}) : super(key: key);

  @override
  _NewsListWrapperState createState() => _NewsListWrapperState();
}

class _NewsListWrapperState extends State<NewsListWrapper> {
  late News news;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    String countryCode = WidgetsBinding.instance!.window.locale.countryCode!;
    SelectedVar.country = countryCode.toLowerCase();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ?
      Spinner()
        :
      NewsList(news: news);
  }

  void fetchData() {
    String url;
    if(SelectedVar.sources.isEmpty) {
      url = 'https://newsapi.org/v2/top-headlines?country=${SelectedVar.country}&sortBy=${SelectedVar.sortBy}';
    } else {
      url = 'https://newsapi.org/v2/top-headlines?sources=${SelectedVar.sources}';
    }

    HttpUtil().makeGetRequest(
      url: url,
      onRequestCompleted: (responseBody) {
        setState(() {
          news = News.fromJson(responseBody);
          isLoading = false;
        });
      },
      onRequestFailed: () {}
    );
  }
}

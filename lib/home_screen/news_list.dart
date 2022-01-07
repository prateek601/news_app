import 'package:flutter/material.dart';
import 'package:news_app/data_model/news.dart';
import 'package:news_app/shared/spinner.dart';
import 'package:news_app/util/http_util.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  News? news;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return news == null
        ?
      Spinner()
        :
      ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          height: 20,
        );
      }
    );
  }

  void fetchData() {
    HttpUtil().makeGetRequest(
      url: 'https://newsapi.org/v2/top-headlines?country=in',
      onRequestCompleted: (responseBody) {
        setState(() {
          news = News.fromJson(responseBody);
        });
      },
      onRequestFailed: () {}
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/data_model/news.dart';
import 'package:news_app/shared/news_list.dart';
import 'package:news_app/shared/spinner.dart';
import 'package:news_app/util/http_util.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var textController = TextEditingController();
  late String query;
  List<Article> articles = [];
  int totalResults = 0;
  late int totalPages;
  late int _pageSize;
  int page = 1;
  bool isLoading = false;

  var scrollController = ScrollController();

  bool reachedMaxScrollExtent = false;
  bool firstTime = true;

  @override
  void initState() {
    super.initState();
    _pageSize = int.parse(pageSize);

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
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search',
            style: TextStyle(
                color: secondaryColor1,
                fontSize: 18
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 30),
                  child: TextField(
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    controller: textController,
                    cursorColor: Colors.black,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      isDense: true,
                      hintText: 'Search for news, topics...',
                      hintStyle: TextStyle(
                        fontSize: 12
                      ),
                      fillColor: secondaryColor2,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                    ),
                    onEditingComplete: () {
                      query = textController.text;
                      if(query.trim().length > 0)
                      fetchData();
                    },
                  ),
                ),
                firstTime
                ?
                Text('Press search key on keyboard to initiate search')
                :
                isLoading
                ?
                Spinner()
                :
                NewsList(
                  articles: articles
                ),
                reachedMaxScrollExtent
                ?
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 20),
                  child: Spinner(),
                )
                :
                Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void fetchData({bool reachedMaxExtent = false}) {
    firstTime = false;
    if(!reachedMaxExtent) {
      setState(() {
        isLoading = true;
      });
    }
    String url = 'https://newsapi.org/v2/everything?q=$query&pageSize='
        '$pageSize&page=$page';

    HttpUtil().makeGetRequest(
      url: url,
      onRequestCompleted: (response) {
        News news = News.fromJson(response);
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
        setState(() {});
      },
      onRequestFailed: () {}
    );
  }
}

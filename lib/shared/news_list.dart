import 'package:flutter/material.dart';
import 'package:news_app/data_model/news.dart';

typedef void OnMaxScrollExtent();

class NewsList extends StatefulWidget {
  final List<Article> articles;
  const NewsList({
    Key? key,
    required this.articles,
  }) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {

  @override
  Widget build(BuildContext context) {
    return this.widget.articles.isEmpty
      ?
    Center(
      child: Text('No results available.Try Again')
    )
      :
    ListView.builder(
        itemCount: this.widget.articles.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  this.widget.articles[index].source.name,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  this.widget.articles[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                            Text(
                              published(index),
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              this.widget.articles[index].urlToImage,
                              fit: BoxFit.cover,
                              height: double.infinity,
                            ),
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  String published(int index) {
    DateTime dateTime = DateTime.parse(this.widget.articles[0].publishedAt);
    var difference = DateTime.now().difference(dateTime);
    if(difference.inDays > 7 ) {
      return 'a week ago';
    } else if(difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if(difference.inDays > 0) {
      return '${difference.inDays} day ago';
    } else if(difference.inHours > 1) {
      return '${difference.inHours} hours ago';
    } else if(difference.inHours > 0) {
      return '${difference.inHours} hour ago';
    } else if(difference.inMinutes > 0) {
      return '${difference.inMinutes} min ago';
    } else {
      return 'a moment ago';
    }
  }
}

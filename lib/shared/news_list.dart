import 'package:flutter/material.dart';
import 'package:news_app/data_model/news.dart';

class NewsList extends StatelessWidget {
  final News news;
  const NewsList({
    Key? key,
    required this.news
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.news.articles.isEmpty
      ?
    Center(
      child: Text('No results available.Try Again')
    )
      :
    ListView.builder(
        itemCount: news.articles.length,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(news.articles[index].source.name),
                          SizedBox(height: 5,),
                          Text(
                            news.articles[index].title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                          Text(news.articles[index].publishedAt)
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            news.articles[index].urlToImage,
                            fit: BoxFit.cover,
                            height: double.infinity,
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
}

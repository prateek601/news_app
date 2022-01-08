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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            this.widget.articles[index].source.name,
                            maxLines: 1,
                          ),
                          SizedBox(height: 5,),
                          Text(
                            this.widget.articles[index].title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                          Text(
                            this.widget.articles[index].publishedAt,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            this.widget.articles[index].urlToImage,
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

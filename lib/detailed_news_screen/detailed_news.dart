import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/data_model/news.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedNews extends StatefulWidget {
  final Article article;
  const DetailedNews({
        Key? key,
        required this.article
      }) : super(key: key);

  @override
  _DetailedNewsState createState() => _DetailedNewsState();
}

class _DetailedNewsState extends State<DetailedNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                this.widget.article.urlToImage,
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                bottom: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        this.widget.article.title,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white
                        )
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 30,top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.widget.article.source.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  publishedAt(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    this.widget.article.description,
                    style: TextStyle(
                      wordSpacing: 1
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: InkWell(
                    onTap: () async {
                      if(this.widget.article.url != null) {
                        String url = this.widget.article.url!;
                        if (await canLaunch(url))
                          await launch(url);
                        else
                          throw "Could not launch $url";
                      } else {
                        showToast();
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'See full story',
                          style: TextStyle(
                            color: primaryColor1,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          size: 20,
                          color: primaryColor1,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String publishedAt() {
    DateTime dateTime = DateTime.parse(this.widget.article.publishedAt);
    String formattedDate = DateFormat('dd-MM-yyyy - kk:mm').format(dateTime);
    return formattedDate;
  }

  void showToast() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Cannot process the request!'
        )
      )
    );
  }
}

class News {
  String status;
  int totalResults;
  List<Article> articles;

  News(this.status, this.totalResults, this.articles);

  factory News.fromJson(Map <String, dynamic> data) {
    return News(
      data['status'],
      data['totalResults'],
      (data['articles'] as List).map((e) => Article.fromJson(e)).toList()
    );
  }
}

class Article {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Article(this.source, this.author, this.title, this.description, this.url,
      this.urlToImage, this.publishedAt, this.content);

  factory Article.fromJson(Map <String, dynamic> data) {
    return Article(
      Source.fromJson(data['source']),
      data['author'],
      data['title'],
      data['description'],
      data['url'],
      data['urlToImage'],
      data['publishedAt'],
      data['content']
    );
  }
}

class Source {
  String? id;
  String? name;

  Source(this.id, this.name);

  factory Source.fromJson(Map <String, dynamic> data) {
    return Source(
      data['id'],
      data['name']
    );
  }
}
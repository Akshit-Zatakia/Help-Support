class NewsR{
  String author;
  String title;
  String desc;
  String url;

  NewsR({this.author, this.title, this.desc, this.url});

  factory NewsR.fromJson(Map<String,dynamic> json){
    return NewsR(
      author: json['author'] as String,
      title: json['title'] as String,
      desc: json['description'] as String,
      url: json['url'] as String,
    );
  }

}
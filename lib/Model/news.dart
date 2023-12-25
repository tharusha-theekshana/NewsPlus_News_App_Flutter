class News {
  String? name;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  News(
      {required this.name,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  factory News.fromJson(Map<String,dynamic> json){
    return News(
        name: json['source']['name'],
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'] ?? "https://usbforwindows.com/storage/img/images_3/function_set_default_image_when_image_not_present.png",
        publishedAt: json['publishedAt'],
        content: json['content']
    );
  }
}

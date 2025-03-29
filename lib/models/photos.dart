class Photos {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photos({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });


  factory Photos.fromJson(Map<String,dynamic> json){
    return Photos(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
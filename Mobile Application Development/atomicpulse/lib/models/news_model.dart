class NewsModel {
  final String id;
  final String title;
  final String summary;
  final String category;
  final String date;
  final String url;
  final bool isHighlight;

  NewsModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
    required this.date,
    required this.url,
    this.isHighlight = false,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      category: json['category'] ?? 'Geral',
      date: json['date'] ?? '',
      url: json['url'] ?? '',
      isHighlight: json['isHighlight'] ?? false,
    );
  }
}

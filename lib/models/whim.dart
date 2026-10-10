class Whim {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime postDate;
  final bool isRead;

  Whim({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.postDate,
    this.isRead = false,
  });

  factory Whim.fromJson(Map<String, dynamic> json) {
    return Whim(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      author: json['author'] ?? '',
      postDate: DateTime.tryParse(json['postDate'] ?? '') ?? DateTime.now(),
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'author': author,
    'postDate': postDate.toIso8601String(),
    'isRead': isRead,
  };
}

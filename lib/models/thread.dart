class Thread {
  String id;
  String title;
  String forum;
  String author;
  DateTime lastPostDate;
  int replyCount;
  bool isSticky;
  bool isClosed;
  bool isWatched;
  bool hasNewPosts;

  Thread({
    required this.id,
    required this.title,
    required this.forum,
    required this.author,
    required this.lastPostDate,
    required this.replyCount,
    this.isSticky = false,
    this.isClosed = false,
    this.isWatched = false,
    this.hasNewPosts = false,
  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      forum: json['forum'] ?? '',
      author: json['author'] ?? '',
      lastPostDate: DateTime.tryParse(json['lastPostDate'] ?? '') ?? DateTime.now(),
      replyCount: json['replyCount'] ?? 0,
      isSticky: json['isSticky'] ?? false,
      isClosed: json['isClosed'] ?? false,
      isWatched: json['isWatched'] ?? false,
      hasNewPosts: json['hasNewPosts'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'forum': forum,
    'author': author,
    'lastPostDate': lastPostDate.toIso8601String(),
    'replyCount': replyCount,
    'isSticky': isSticky,
    'isClosed': isClosed,
    'isWatched': isWatched,
    'hasNewPosts': hasNewPosts,
  };
}

class Forum {
  final String id;
  final String name;
  final String description;
  final int threadCount;
  final int postCount;

  Forum({
    required this.id,
    required this.name,
    required this.description,
    required this.threadCount,
    required this.postCount,
  });

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      threadCount: json['threadCount'] ?? 0,
      postCount: json['postCount'] ?? 0,
    );
  }
}

class Post {
  final String id;
  final String threadId;
  final String author;
  final String content;
  final DateTime postDate;
  final int postNumber;

  Post({
    required this.id,
    required this.threadId,
    required this.author,
    required this.content,
    required this.postDate,
    required this.postNumber,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      threadId: json['threadId'] ?? '',
      author: json['author'] ?? '',
      content: json['content'] ?? '',
      postDate: DateTime.tryParse(json['postDate'] ?? '') ?? DateTime.now(),
      postNumber: json['postNumber'] ?? 0,
    );
  }
}

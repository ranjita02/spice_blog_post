class Blog {
  final int? id;
  final String title;
  final String content;
  final String imageUrl;
  final Author author;
  final DateTime updatedAt;

  const Blog({
    this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.author,
    required this.updatedAt,
  });

  Map toJson() => {
    'title': title,
    'content': content,
    'imageUrl': Uri.encodeFull(imageUrl),
    'email': Uri.encodeFull(author.email),
  };

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    imageUrl: json['imageurl'],
    author: Author(email: json['email'], photoUrl: ""),
    updatedAt: DateTime.parse(json["updatedat"]),
  );
}

class Author {
  final String email;
  final String photoUrl;

  const Author({
    required this.email,
    required this.photoUrl,
  });
}
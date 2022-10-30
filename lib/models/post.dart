import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String author;

  const Post({
    required this.id,
    required this.title,
    required this.author,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
    );
  }

  @override
  List<Object?> get props => [id, title, author];
}

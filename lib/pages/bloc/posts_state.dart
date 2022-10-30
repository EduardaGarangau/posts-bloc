import 'package:equatable/equatable.dart';
import 'package:bloc_posts/models/post.dart';

abstract class PostState extends Equatable {}

class PostInitialState extends PostState {
  @override
  List<Object?> get props => [];
}

class PostLoadingState extends PostState {
  @override
  List<Object?> get props => [];
}

class PostSucessState extends PostState {
  final List<Post> posts;

  PostSucessState({
    required this.posts,
  });

  @override
  List<Object?> get props => [posts];
}

class PostErrorState extends PostState {
  final String message;

  PostErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

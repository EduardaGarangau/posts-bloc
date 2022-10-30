import 'package:equatable/equatable.dart';
import 'package:bloc_posts/models/post.dart';

abstract class PostEvent extends Equatable {}

class LoadPostsEvent extends PostEvent {
  @override
  List<Object?> get props => [];
}

class AddPostEvent extends PostEvent {
  final Post post;

  AddPostEvent({
    required this.post,
  });

  @override
  List<Object?> get props => [post];
}

class RemovePostEvent extends PostEvent {
  final Post post;

  RemovePostEvent({
    required this.post,
  });

  @override
  List<Object?> get props => [post];
}

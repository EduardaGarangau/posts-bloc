import 'package:bloc/bloc.dart';
import 'package:bloc_posts/pages/bloc/posts_event.dart';
import 'package:bloc_posts/pages/bloc/posts_state.dart';
import 'package:bloc_posts/repositories/post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc({required this.repository}) : super(PostInitialState()) {
    emit(PostLoadingState());
    on<LoadPostsEvent>((event, emit) async {
      try {
        var posts = await repository.getPosts();
        emit(PostSucessState(posts: posts));
      } catch (error) {
        emit(PostErrorState(message: 'Error loading posts'));
      }
    });

    on<RemovePostEvent>((event, emit) async {
      try {
        await repository.removePost(event.post);
        emit(PostSucessState(posts: await repository.getPosts()));
      } catch (error) {
        emit(PostErrorState(message: 'Error remove post'));
      }
    });

    on<AddPostEvent>((event, emit) async {
      try {
        await repository.addPost(event.post);
        final list = await repository.getPosts();
        emit(PostSucessState(posts: list));
      } catch (error) {
        emit(PostErrorState(message: 'Error add post'));
      }
    });
  }
}

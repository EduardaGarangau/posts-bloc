import 'package:bloc_posts/dataproviders/post_data_provider.dart';
import 'package:bloc_posts/models/post.dart';

class PostRepository {
  final PostDataProvider dataProvider;

  PostRepository({
    required this.dataProvider,
  });

  Future<List<Post>> getPosts() async {
    final dataList = await dataProvider.getAllPosts();
    return dataList.map((post) => Post.fromJson(post)).toList();
  }

  Future<void> removePost(Post post) async {
    await dataProvider.removePost(post);
  }

  Future<void> addPost(Post post) async {
    await dataProvider.addPost(post);
  }
}

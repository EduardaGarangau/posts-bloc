import 'package:bloc_posts/models/post.dart';
import 'package:bloc_posts/pages/bloc/posts_bloc.dart';
import 'package:bloc_posts/pages/bloc/posts_event.dart';
import 'package:bloc_posts/pages/bloc/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PostBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<PostBloc>(context);
    bloc.add(LoadPostsEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lista de Posts'),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostErrorState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                title: const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 55,
                ),
                content: Text(
                  state.message,
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Exit'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PostInitialState) {
            return const Center(
              child: Text('Nenhum Post :('),
            );
          } else if (state is PostLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PostSucessState) {
            final postsList = state.posts;

            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: postsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(postsList[index].title),
                  subtitle: Text(postsList[index].author),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      BlocProvider.of<PostBloc>(context)
                          .add(RemovePostEvent(post: postsList[index]));
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          var post = const Post(
              id: 9, title: 'ValueNotifier', author: 'Eduarda Garangau');
          BlocProvider.of<PostBloc>(context).add(AddPostEvent(post: post));
        },
      ),
    );
  }
}

import 'package:bloc_posts/dataproviders/post_data_provider.dart';
import 'package:bloc_posts/pages/bloc/posts_bloc.dart';
import 'package:bloc_posts/pages/home_page.dart';
import 'package:bloc_posts/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(
        repository: PostRepository(
          dataProvider: PostDataProvider(),
        ),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

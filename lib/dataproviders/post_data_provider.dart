import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';

class PostDataProvider {
  static const serverURL = 'http://localhost:3000/posts';
  static const Map<String, String> API_HEADERS = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  Future<List<dynamic>> getAllPosts() async {
    try {
      final response = await http.get(Uri.parse(serverURL));
      return jsonDecode(response.body);
    } catch (error) {
      throw Exception('Error load posts - $error');
    }
  }

  Future<void> removePost(Post post) async {
    try {
      await http.delete(Uri.parse('$serverURL/${post.id}'));
    } catch (error) {
      throw Exception('Error remove post - $error');
    }
  }

  Future<void> addPost(Post post) async {
    try {
      await http.post(
        Uri.parse(serverURL),
        headers: API_HEADERS,
        body: jsonEncode({
          'id': post.id,
          'title': post.title,
          'author': post.author,
        }),
      );
    } catch (error) {
      throw Exception('Error add post = $error');
    }
  }
}

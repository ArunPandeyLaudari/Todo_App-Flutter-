import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/post.dart';

class PostViewScreen extends StatefulWidget {
  const PostViewScreen({super.key});

  @override
  State<PostViewScreen> createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  Posts? post;

  Future<Posts?> fetchPostDetail() async {
    try {
      int id = ModalRoute.of(context)!.settings.arguments as int;
      final Dio dio = Dio();
      final response = await dio.get('https://jsonplaceholder.typicode.com/posts/$id');
      post = Posts.fromMap(response.data);
      return post;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View More Details Page'),
      ),
      body: FutureBuilder(
        future: fetchPostDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            Posts post = snapshot.data as Posts;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shadowColor: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        post.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(post.body),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('No Data Found'));
        },
      ),
    );
  }
}
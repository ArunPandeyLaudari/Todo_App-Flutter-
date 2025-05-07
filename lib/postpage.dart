import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app_routes.dart';

class Postpage extends StatefulWidget {
  const Postpage({super.key});

  @override
  State<Postpage> createState() => _PostpageState();
}

class _PostpageState extends State<Postpage> {
  List posts = [];

  fetchTodos() async {
   try {
     final Dio dio = Dio();
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/posts',
    );
    setState(() {
      posts = response.data;
    });
   }
   catch (e){
    print(e);
   }
  }

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Posts From API",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 30, 25, 25),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          final body = post['body'];
          final trimmedBody = body.length > 50 ? body.substring(0, 47) + "..." : body;
          
          return GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.postViewScreen,
            arguments: posts[index].id
            ),
            child: ListTile(
              
              subtitle: Text("Body: $trimmedBody"),
              title: Text(post['title'],style: TextStyle(fontWeight: FontWeight.bold),),
              leading: Text(post['id'].toString()),
             
            ),
          );
        },
      ),
    );
  }
}
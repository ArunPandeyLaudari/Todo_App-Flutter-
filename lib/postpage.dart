import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/app_routes.dart';
// import 'package:flutter_application_1/model/post.dart';
import 'package:todo_app/app_routes.dart';
import 'package:todo_app/model/post.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Posts> posts = [];
  fetchPosts()async{
    try{
    posts.clear();
    final Dio dio = Dio();
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    for(var post in response.data){
      posts.add(Posts.fromMap(post));
    }
    return posts;
  }catch(e){
    print(e.toString());
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if(snapshot.hasData) {
            List<Posts> posts = snapshot.data as List<Posts>;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.of(context) .pushNamed(AppRoutes.postViewScreen, arguments: posts[index].id),
                  child: Padding(
                                padding:  EdgeInsets.symmetric(vertical:8,horizontal: 5),
                                child:Card(
                  shadowColor: Colors.black,
                  child: ListTile(
                    leading: Text("${index+1}"),
                    title: Text(posts[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        ),
                    subtitle: Text(posts[index].body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        ),
                                
                  ),
                                ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}

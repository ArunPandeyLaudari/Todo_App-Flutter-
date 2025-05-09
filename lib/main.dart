import 'package:flutter/material.dart';
import 'package:todo_app/app_routes.dart';
import 'package:todo_app/postpage.dart';
import 'package:todo_app/postviewscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home:PostScreen(),
      routes:{
        AppRoutes.postScreen:(context)=>PostScreen(),
        AppRoutes.postViewScreen:(context)=>postViewScreen(),
      },
    );
  }
}


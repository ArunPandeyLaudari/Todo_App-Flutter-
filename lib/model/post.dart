// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Posts {
 final int userId;
 final int id;
 final String title;
 final String body;


Posts({

  required this.userId,
  required this.id,
  required this.title,
  required this.body,
});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory Posts.fromMap(Map<String, dynamic> map) {
    return Posts(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Posts.fromJson(String source) => Posts.fromMap(json.decode(source) as Map<String, dynamic>);
}

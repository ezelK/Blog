import 'dart:convert';

class CreateBlog {
  final int id;
  final String title;
  final String description;

  CreateBlog({
    required this.title,
    required this.description,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description, 'id': id};
  }
  String toJSON() {
    return json.encode(toMap());
  }

}

import 'dart:convert';

class Blog {
  final int id;
  String title;
  String description;
  final DateTime date;

  Blog(
    this.id,
    this.title,
    this.description,
    this.date,
  );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'created_at': date.toIso8601String()});

    return result;
  }

  Blog copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
  }) {
    return Blog(
      id ?? this.id,
      title ?? this.title,
      description ?? this.description,
      date ?? this.date,
    );
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      map['id']?.toInt() ?? 0,
      map['title'] ?? '',
      map['description'] ?? '',
      DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Blog.fromJson(String source) => Blog.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Blog(id: $id, title: $title, description: $description, created_at: $date)';
  }
}

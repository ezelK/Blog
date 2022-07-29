import 'package:blog_app/screens/blogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlogsPage(),
    ),
  );
}
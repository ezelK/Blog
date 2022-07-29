import 'package:blog_app/models/blog_class.dart';
import 'package:blog_app/models/create_blog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Api {
  static Future<Dio> dioAuth() async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: "http://192.168.1.107", responseType: ResponseType.json);
    return Dio(baseOptions);
  }

  static Future<List<Blog>?> getBlogs(DateTime date) async {
    try {
      Dio dio = await Api.dioAuth();
      Response response = await dio.get("/blog");
      if (response.statusCode == 200) {
        final List<dynamic> list = response.data;
        return list.map((e) => Blog.fromMap(e)).toList();
      }
      return null;
    } on DioError catch (err) {
      debugPrint("Get Blogs Error $err");
      return null;
    }
  }

  static Future<Blog?> createBlog(CreateBlog blog) async {
    try {
      Dio dio = await Api.dioAuth();
      Response response = await dio.post("/blog", data: blog.toJSON());
      if (response.statusCode == 200) {
        return Blog.fromMap(response.data);
      }
      return null;
    } on DioError catch (err) {
      debugPrint("Create Blog Error $err");
      return null;
    }
  }

  static Future<Blog?> updateBlog(int id, CreateBlog blog) async {
    try {
      Dio dio = await Api.dioAuth();
      Response response = await dio.put("/blog", data: blog.toJSON());
      if (response.statusCode == 200) {
        return Blog.fromMap(response.data);
      }
      return null;
    } on DioError catch (err) {
      debugPrint("Update Blog Error $err");
      return null;
    }
  }

  static Future<bool> deleteBlog(int id) async {
    try {
      Dio dio = await Api.dioAuth();
      Response response =
          await dio.delete("/blog", queryParameters: {"id": id});
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioError catch (err) {
      debugPrint("Delete Blog Error $err");
      return false;
    }
  }
}

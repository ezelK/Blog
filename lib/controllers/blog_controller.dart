import 'package:blog_app/models/blog_class.dart';
import 'package:blog_app/models/create_blog.dart';
import 'package:blog_app/screens/edit_blog.dart';
import 'package:blog_app/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {
  final blogs = <Blog>[].obs;

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final date = DateTime.now().obs;

  final isLoading = true.obs;

  @override
  void onInit() {
    ever(date, (_) {
      fetch();
    });

    date.value = DateTime.now();
    super.onInit();
  }

  Future<void> fetch() async {
    isLoading.value = true;
    final result = await Api.getBlogs(date.value);
    if (result == null) {
      Get.snackbar("Error", "Couldn't get blogs.");
    } else {
      blogs.value = result;
    }
    isLoading.value = false;
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }

  Future<void> restart() async {
    await fetch();
  }

  void addBlog() async {
    final createBlog = CreateBlog(
      id: -1,
      title: titleController.text,
      description: contentController.text,
    );
    if (titleController.text != "" && contentController.text != "") {
      final blog = await Api.createBlog(createBlog);
      if (blog == null) {
        return;
      } else {
        blogs.insert(0, blog);
      }
      Get.back();
      titleController.clear();
      contentController.clear();
    }
  }

  void updateBlog(int id) {
    final blog = blogs.firstWhere((element) => element.id == id);
    titleController.text = blog.title;
    contentController.text = blog.description;
    Get.to(EditPage(editId: id));
  }

  void updateBlogComplete(int id) async {
    final createBlog = CreateBlog(
      id: id,
      title: titleController.text,
      description: contentController.text,
    );
    final edit = await Api.updateBlog(id, createBlog);

    if (edit == null) return;

    final idx = blogs.indexWhere((element) => element.id == id);

    final newBlogs = blogs[idx].copyWith(
      title: titleController.text,
      description: contentController.text,
    );
    blogs[idx] = newBlogs;
    blogs.refresh();
    Get.back();
  }

  void removeBlog(int id) async {
    final result = await Api.deleteBlog(id);
    if (result) {
      blogs.removeWhere((element) => element.id == id);
      return;
    }
    Get.snackbar("Error", "Couldn't delete blog.");
    blogs.refresh();
  }
}

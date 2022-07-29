import 'package:blog_app/controllers/blog_controller.dart';
import 'package:blog_app/screens/edit_blog.dart';
import 'package:blog_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogsPage extends StatelessWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BlogController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BLOGS"),
        backgroundColor: black,
        actions: [
          IconButton(
              onPressed: () {
                controller.titleController.clear();
                controller.contentController.clear();
                Get.to(const EditPage());
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : controller.blogs.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.restart();
                    },
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: controller.blogs
                          .map(
                            (blog) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: black,
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onTap: () => controller.updateBlog(blog.id),
                                title: Text(
                                  blog.title,
                                  style: const TextStyle(color: black),
                                ),
                                subtitle: Text(
                                  blog.description,
                                  style: const TextStyle(color: black),
                                ),
                                trailing: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            controller.updateBlog(blog.id);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                          ),
                                          color: black,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            controller.removeBlog(blog.id);
                                          },
                                          icon: const Icon(Icons.delete),
                                          color: black,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
              : const Center(
                  child: Text("Empty", style: TextStyle(color: black)))),
    );
  }
}

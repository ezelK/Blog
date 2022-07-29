import 'package:blog_app/controllers/blog_controller.dart';
import 'package:blog_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key, this.editId}) : super(key: key);
  final int? editId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BlogController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        centerTitle: true,
        title: const Text("Edit Blog"),
        actions: [
          IconButton(
              onPressed: () {
                if (editId == null) {
                  controller.addBlog();
                } else {
                  controller.updateBlogComplete(editId!);
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(color: black),
                ),
                hintText: 'Title',
                hintStyle: const TextStyle(
                  fontSize: 25.0,
                ),
              ),
              style: const TextStyle(
                fontSize: 25.0,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: TextField(
                controller: controller.contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 15,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: const BorderSide(color: black),
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 20.0,
                    ),
                    hintText: 'Content'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

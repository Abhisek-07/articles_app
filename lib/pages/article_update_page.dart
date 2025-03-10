import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/article_controller.dart';
import '../models/article.dart';

class ArticleUpdatePage extends StatelessWidget {
  final Article article;
  final ArticleController controller = Get.find<ArticleController>();

  ArticleUpdatePage({required this.article});

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with current article data
    titleController.text = article.title;
    descriptionController.text = article.description;

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Article"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
                validator: (value) => value!.isEmpty ? "Enter title" : null,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) =>
                    value!.isEmpty ? "Enter description" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Update"),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final updates = {
                      "title": titleController.text,
                      "description": descriptionController.text,
                      // read_time is intentionally not updated
                    };
                    try {
                      await controller.updateArticle(article.id, updates);
                      Get.back();
                    } catch (e) {
                      Get.snackbar("Error", e.toString());
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

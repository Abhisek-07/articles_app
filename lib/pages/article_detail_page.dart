import 'package:articles_app/models/article.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/article_controller.dart';
import 'article_update_page.dart';

class ArticleDetailPage extends StatelessWidget {
  final String articleId;
  final ArticleController controller = Get.find<ArticleController>();

  ArticleDetailPage({required this.articleId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Article>(
      future: controller.getArticleById(articleId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text("Error: ${snapshot.error}")));
        }
        final article = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text(article?.title ?? ""),
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Get.to(() => ArticleUpdatePage(
                      article: article ??
                          Article(
                              updatedAt: DateTime.now(),
                              createdAt: DateTime.now(),
                              author: "",
                              category: "",
                              description: "",
                              id: "",
                              readTime: 0,
                              title: "")));
                },
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Author: ${article?.author}",
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text("Category: ${article?.category}",
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text("Read Time: ${article?.readTime} minutes",
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text(article?.description ?? "",
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        );
      },
    );
  }
}

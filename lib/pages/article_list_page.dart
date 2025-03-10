import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/article_controller.dart';
import 'article_detail_page.dart';
import 'article_create_page.dart';

class ArticleListPage extends StatelessWidget {
  final ArticleController controller = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Articles"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(() => ArticleCreatePage());
            },
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.articles.length,
          itemBuilder: (context, index) {
            final article = controller.articles[index];
            return ListTile(
              title: Text(article.title),
              subtitle: Text("By ${article.author}"),
              onTap: () {
                Get.to(() => ArticleDetailPage(articleId: article.id));
              },
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() => Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: controller.currentPage.value > 1
                        ? () {
                            controller.fetchArticles(
                                page: controller.currentPage.value - 1);
                          }
                        : null,
                    child: Text("Previous")),
                Text("Page ${controller.currentPage.value}"),
                TextButton(
                    onPressed: controller.currentPage.value <
                            controller.totalPages.value
                        ? () {
                            controller.fetchArticles(
                                page: controller.currentPage.value + 1);
                          }
                        : null,
                    child: Text("Next")),
              ],
            ),
          )),
    );
  }
}

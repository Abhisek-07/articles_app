import 'package:get/get.dart';
import '../models/article.dart';
import '../services/api_service.dart';

class ArticleController extends GetxController {
  var articles = <Article>[].obs;
  var isLoading = false.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  void fetchArticles(
      {int page = 1, int size = 10, Map<String, dynamic>? filters}) async {
    try {
      isLoading(true);
      currentPage(page);
      final response = await apiService.getArticles(
          page: page, size: size, filters: filters);
      totalPages(response['data']['last_page']);
      List<dynamic> records = response['data']['records'];
      articles.value = records.map((json) => Article.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<Article> getArticleById(String id) async {
    return await apiService.getArticle(id);
  }

  Future<Article> createArticle(Article article) async {
    final newArticle = await apiService.createArticle(article);
    // refresh list after creation
    fetchArticles(page: currentPage.value);
    return newArticle;
  }

  Future<Article> updateArticle(String id, Map<String, dynamic> updates) async {
    final updatedArticle = await apiService.updateArticle(id, updates);
    // refresh list after update
    fetchArticles(page: currentPage.value);
    return updatedArticle;
  }
}

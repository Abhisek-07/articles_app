import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ApiService {
  static const String baseUrl = "https://flutter.starbuzz.tech";

  Future<Map<String, dynamic>> getArticles(
      {int page = 1, int size = 10, Map<String, dynamic>? filters}) async {
    final filterParam = filters != null ? jsonEncode(filters) : "{}";
    final url = Uri.parse(
        "$baseUrl/articles?filters=$filterParam&page=$page&size=$size");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception("Failed to load articles");
    }
  }

  Future<Article> getArticle(String articleId) async {
    final url = Uri.parse("$baseUrl/articles/$articleId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Article.fromJson(jsonResponse['data']);
    } else {
      throw Exception("Failed to load article");
    }
  }

  Future<Article> createArticle(Article article) async {
    final url = Uri.parse("$baseUrl/articles");
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(article.toJson()));

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      return Article.fromJson(jsonResponse['data']);
    } else {
      throw Exception("Failed to create article");
    }
  }

  Future<Article> updateArticle(
      String articleId, Map<String, dynamic> updates) async {
    final url = Uri.parse("$baseUrl/articles/$articleId");
    final response = await http.patch(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updates));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Article.fromJson(jsonResponse['data']);
    } else {
      throw Exception("Failed to update article");
    }
  }
}

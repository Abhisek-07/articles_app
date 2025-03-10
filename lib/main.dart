import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/article_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Article App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ArticleListPage(),
    );
  }
}

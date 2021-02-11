import 'dart:convert';

import 'package:news_app/APIs/api.dart';
import 'package:news_app/model/article.dart';
import 'package:http/http.dart' as http;

class News {

  List<Article> articles = <Article>[];

  Future <void> getNewsHeadLine() async {
    String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey";

    var response = await http.get(url);
    //print(response);

    var jsonData = jsonDecode(response.body);

    //print(jsonData);

    if(jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {

        if(element['description'] != null && element['urlToImage'] != null) {
          Article article = Article();

          article.title = element['title'];
          article.description = element['description'];
          article.url = element['url'];
          article.urlToImage = element['urlToImage'];
          
          articles.add(article);
        }
      });
    }
  }


  Future <void> getNewsByCategory(String category) async {
    String url = "http://newsapi.org/v2/top-headlines?category=$category&country=in&category=business&apiKey=$apiKey";

    var response = await http.get(url);
    //print(response);

    var jsonData = jsonDecode(response.body);

    //print(jsonData);

    if(jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {

        if(element['description'] != null && element['urlToImage'] != null) {
          Article article = Article();

          article.title = element['title'];
          article.description = element['description'];
          article.url = element['url'];
          article.urlToImage = element['urlToImage'];
          
          articles.add(article);
        }
      });
    }
  }

}
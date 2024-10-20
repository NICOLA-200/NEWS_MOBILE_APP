import 'dart:convert';

import 'package:flutter_application_1/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  
  Future<void> getNews () async {
    String url = 'https://newsapi.org/v2/everything?q=tesla&from=2024-09-19&sortBy=publishedAt&apiKey=902f3529552c485d99a281d250542fc4';

    var response  = await http.get(Uri.parse(url));

    var  jsonData =  jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
          if (element['urlToImage'] != null && element['description'] !=null) {
            ArticleModel article =  ArticleModel(
               title: element['title'],
               description: element['description'],
               content: element['content'],
               author: element['author'],
               urlToImage: element['urlToImage'],
               url: element['url']
            );

            news.add(article);
          }
      });
    }

  } 
}
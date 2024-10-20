import 'dart:convert';
import 'package:flutter_application_1/models/slider_model.dart';
import 'package:http/http.dart' as http;

class Slide {
  List<SliderModel> slidies= [];
  
  Future<void> getSlidies () async {
    String url = 'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=902f3529552c485d99a281d250542fc4';

    var response  = await http.get(Uri.parse(url));

    var  jsonData =  jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
          if (element['urlToImage'] != null && element['description'] !=null) {
            SliderModel slide =  SliderModel(
               title: element['title'],
               description: element['description'],
               content: element['content'],
               author: element['author'],
               urlToImage: element['urlToImage'],
               url: element['url']
            );

            slidies.add(slide);
          }
      });
    }

  } 
}
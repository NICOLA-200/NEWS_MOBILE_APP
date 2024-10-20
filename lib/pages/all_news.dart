import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/article_model.dart';
import 'package:flutter_application_1/models/slider_model.dart';
import 'package:flutter_application_1/pages/article_view.dart';
import 'package:flutter_application_1/services/news.dart';
import 'package:flutter_application_1/services/slider_data.dart';

class AllNews extends StatefulWidget {
  String? news;
   AllNews({super.key, this.news});



  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> slidies = [];
  List<ArticleModel> articles = [];
  bool _loading = true;


 @override
  void initState() {
   
    print(slidies);

    getNews();
    getSlidies();
    super.initState();
  }

  getNews() async {
    News newClass = News();
    await newClass.getNews();
    articles = newClass.news;
    setState(() {
      _loading = false;
    });
  }

  getSlidies() async {
    Slide sliderClass = Slide();
    await sliderClass.getSlidies();
    slidies = sliderClass.slidies;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title: Text(
          widget.news! ,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
        elevation: 0.3,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: widget.news == "breaking news" ? slidies.length : articles.length,
            itemBuilder: (context, index) {
              return allNewSection(
                desc:widget.news == "breaking news" ? slidies[index].description : articles[index].description ,
                title: widget.news == "breaking news" ? slidies[index].title : articles[index].title ,
                image: widget.news == "breaking news" ? slidies[index].urlToImage : articles[index].urlToImage ,
                url:widget.news == "breaking news" ? slidies[index].url : articles[index].url
              );
            }),
      ),
    );
  }
}



class allNewSection extends StatelessWidget {
  String? image, desc, title, url;
  allNewSection({super.key, this.image, this.desc, this.title, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image!,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title!,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              desc!,
              style: TextStyle(fontSize: 16),
              maxLines: 3,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/article_model.dart';
import 'package:flutter_application_1/models/category_model.dart';
import 'package:flutter_application_1/pages/all_news.dart';
import 'package:flutter_application_1/pages/article_view.dart';
import 'package:flutter_application_1/pages/category_news.dart';
import 'package:flutter_application_1/services/data.dart';
import 'package:flutter_application_1/services/news.dart';
import 'package:flutter_application_1/services/slider_data.dart';
import 'package:flutter_application_1/models/slider_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<SliderModel> slidies = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  int activeIndex = 0;
  @override
  void initState() {
    categories = getCategories();

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
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text(
              'News',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueAccent),
            )
          ],
        ),
        elevation: 0.3,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    margin: EdgeInsets.only(left: 10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTitle(
                              image: categories[index].image,
                              categoryName: categories[index].categoryName);
                        }),
                  ),
                  //carousal slider
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Breaking news",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contetxt) => AllNews(
                                  news: 'breaking news',
                                )));
                          },
                          child: Text(
                            "View all",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  CarouselSlider.builder(
                      itemCount: 5,
                      itemBuilder: (context, index, realIndex) {
                        final image = slidies[index].urlToImage;
                        final name = slidies[index].title;

                        return buildImage(image!, index, name!);
                      },
                      options: CarouselOptions(
                          height: 250,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          })),

                  SizedBox(
                    height: 30,
                  ),

                  Center(child: buildIndicator()),

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trending news",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contetxt) => AllNews(
                                  news: 'trending news',
                                )));
                          },
                          child: Text(
                            "View all",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return BlogTile(
                            description: articles[index].description,
                            title: articles[index].title,
                            imageUrl: articles[index].urlToImage,
                            url: articles[index].url,
                          );
                        }),
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'images/lineup.png',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ))),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: Text(
                                  "Rue costa outsprints breakway to win stage 15",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.9,
                                child: Text(
                                  "Rue costa outsprints breakway to win stage 15",
                                  style: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
            ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 200),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 10),
            height: 250,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 19),
            ),
          )
        ],
      ));

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: SlideEffect(
          activeDotColor: Colors.blue,
        ),
      );

  //
  // Image.asset(image,
  //     fit: BoxFit.cover, width: MediaQuery.of(context).size.width),height: 200);
}

class CategoryTitle extends StatelessWidget {
  final image, categoryName;

  CategoryTitle({super.key, required this.image, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(name: categoryName)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                  child: Image.asset(
                image,
                width: 120,
                height: 70,
                fit: BoxFit.cover,
              )),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              width: 120,
              height: 70,
              child: Center(
                  child: Text(
                categoryName,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String? imageUrl, title, description, url;

  BlogTile({super.key, this.description, this.title, this.imageUrl, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ))),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.1,
                        child: Text(
                          title!,
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.9,
                        child: Text(
                          description!,
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.black26,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

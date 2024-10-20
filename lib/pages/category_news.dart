import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/show_category.dart';
import 'package:flutter_application_1/pages/article_view.dart';
import 'package:flutter_application_1/services/category_data.dart';

class CategoryNews extends StatefulWidget {
  String? name;
  CategoryNews({super.key, this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<categoryModel> categories = [];
  bool _loading = true;

  void initState() {
    getcategory();
  }

  getcategory() async {
    CategoryData newClass = CategoryData();
    await newClass.getCategoryData(widget.name!.toLowerCase());

    categories = newClass.categories;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name!,
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
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return showCategory(
                desc: categories[index].description,
                title: categories[index].title,
                image: categories[index].urlToImage,
                url: categories[index].url
              );
            }),
      ),
    );
  }
}

class showCategory extends StatelessWidget {
  String? image, desc, title, url;
  showCategory({super.key, this.image, this.desc, this.title, this.url});

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

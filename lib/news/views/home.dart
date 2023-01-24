// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:logging_task_flog/flogs.dart';

import '../helper/data.dart';
import '../helper/news.dart';
import '../models/article_model.dart';
import '../models/category_model.dart';
import 'article_view.dart';
import 'category_news.dart';

class NewsHomeScreen extends StatefulWidget {
  @override
  _NewsHomeScreenState createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool isLoading = true;

  @override
  void initState() {
    FlogFunctions.logInfo('ENTERED NEWS APP');
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            FlogFunctions.logInfo('POPPED OUT FROM NEWS APP');
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left_sharp,
          ),
        ),
        title: Text("NEWS APP"),
        centerTitle: true,
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Categories
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          imageUrl: categories[index].imageUrl,
                          categoryName: categories[index].categoryName,
                        );
                      },
                    ),
                  ),
                  // News Cards
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(top: 18),
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return BlogTile(
                            title: articles[index].title,
                            imageUrl: articles[index].urlToimage,
                            desc: articles[index].description,
                            webViewUrl: articles[index].url,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl;
  final String categoryName;

  CategoryTile({
    required this.imageUrl,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) {
              return CategoryNews(
                category: categoryName.toLowerCase(),
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black12,
              ),
              width: 120,
              height: 80,
              child: Text(
                categoryName,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String title, imageUrl, desc, webViewUrl;

  BlogTile({
    required this.title,
    required this.imageUrl,
    required this.desc,
    required this.webViewUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) {
              return ArticleView(
                webUrl: webViewUrl,
                title: title,
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 16,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              desc,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_relative_lib_imports

import 'package:flutter/material.dart';
import 'package:logging_task_flog/flogs.dart';
import 'package:logging_task_flog/news/views/article_view.dart';
import '../helper/news.dart';
import 'package:logging/logging.dart';
import '../models/article_model.dart';

class CategoryNews extends StatefulWidget {
  CategoryNews({required this.category});

  final String category;

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  bool isLoading = true;

  List<ArticleModel> articles = <ArticleModel>[];

  @override
  void initState() {
    FlogFunctions.logInfo('ENTERED "${widget.category.toUpperCase()}" CATEGORY PAGE');
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getCategoryNews(widget.category);
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
            FlogFunctions.logInfo('POPPED PUT FROM "${widget.category.toUpperCase()}" CATEGORY PAGE');
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
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
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

class BlogTile extends StatelessWidget {
  final _log = Logger('Article Tile');

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
        _log.info('${title} tile clicked');
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
              style: TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}

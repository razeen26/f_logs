// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';
import 'package:logging_task_flog/flogs.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String urlString = "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=cfcdff2390a142a0bae450a47e5105c7";
    try {
      var url = Uri.parse(urlString);
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);

      if (jsonData["status"] == "ok") {
        FlogFunctions.logInfo('NEWS DATA FETCHED');
        // print("Data fetched");
        jsonData["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            ArticleModel articleModel = ArticleModel(
              author: element["author"] ?? "Null Value",
              title: element["title"] ?? "Null Value",
              description: element["description"] ?? "Null Value",
              url: element["url"] ?? "Null Value",
              content: element["content"] ?? "Null Value",
              urlToimage: element["urlToImage"] ?? "Null Value",
            );

            news.add(articleModel);
          }
        });
      }
    } on SocketException catch (e) {
      FlogFunctions.logException(e.message, e.address.toString());
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getCategoryNews(String category) async {
    String urlString = "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=cfcdff2390a142a0bae450a47e5105c7";
    try {
      var url = Uri.parse(urlString);
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);

      if (jsonData["status"] == "ok") {
        FlogFunctions.logInfo('CATEGORY NEWS DATA FETCHED');
        print("Data for category fetched");
        jsonData["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            ArticleModel articleModel = ArticleModel(
              author: element["author"] ?? "Null Value",
              title: element["title"] ?? "Null Value",
              description: element["description"] ?? "Null Value",
              url: element["url"] ?? "Null Value",
              content: element["content"] ?? "Null Value",
              urlToimage: element["urlToImage"] ?? "Null Value",
            );

            news.add(articleModel);
          }
        });
      }
    } on SocketException catch (e) {
      FlogFunctions.logException(e.message, e.address.toString());
    }
  }
}

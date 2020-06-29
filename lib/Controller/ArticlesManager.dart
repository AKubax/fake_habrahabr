import 'dart:io';

import 'package:fake_habrahabr/Models/Article.dart';
import 'package:fake_habrahabr/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class ArticlesManager {
  static Future<Article> getArticleByChronoOrder(int id) async {
    return getDummyArticle(titleSuffix: ' #' + id.toString());
  }

  static Future<Article> getDummyArticle({String titleSuffix}) async {
    return Article(
      -1,
      User('akubaxx', AssetImage('src/placeholder_profile_picture.png'), 3),
      'Fake Article' + (titleSuffix ?? ''),
      await rootBundle.loadString('src/placeholder_article_content.txt'),
      DateTime.now(),
      AssetImage('src/placeholder_header_pic.png'),
    );
  }

  static List<Future<Article>> getArticlesForTheFrontPage(int startingFrom,  int upTo){
    return [for(int i = 0; i < upTo - startingFrom; i++) getArticleByChronoOrder(0)];
  }
}
import 'package:fake_habrahabr/Models/Article.dart';
import 'package:flutter/material.dart';

class User{
  final String username;
  final AssetImage profilePicture;
  final int numberOfArticlesWritten;

  List<Article> articles = <Article>[];

  User(this.username, this.profilePicture, this.numberOfArticlesWritten);
}
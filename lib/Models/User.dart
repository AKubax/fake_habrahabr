import 'package:fake_habrahabr/Models/Article.dart';
import 'package:flutter/material.dart';

const List<String> userStatuses = ['New contributor', 'Expert'];

class User{
  final String username;
  final AssetImage profilePicture;
  final int numberOfArticlesWritten;
  final String status;

  List<Article> articles = <Article>[];

  User(this.username, this.profilePicture, this.numberOfArticlesWritten, [this.status = "New contibutor"]);
}
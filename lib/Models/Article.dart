import 'package:fake_habrahabr/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Article{
  final String title;
  final String content;
  final User author;
  final int id;
  final DateTime publishedTime;
  final AssetImage headerImage;

  Article(this.id, this.author, this.title, this.content, this.publishedTime, this.headerImage);

  String getContentsPreview() => this.content;//this.content.length > 75? this.content.substring(0,  75) + '...' : this
  // .content;
  String getRelativePublishedTime() => DateFormat.MMMEd('en_US').format(publishedTime);
}
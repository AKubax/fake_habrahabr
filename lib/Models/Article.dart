import 'package:fake_habrahabr/Models/User.dart';
import 'package:intl/intl.dart';

class Article{
  final String title;
  final String content;
  final User author;
  final int id;
  final DateTime publishedTime;

  Article(this.id, this.author, this.title, this.content, this.publishedTime);

  String getContentsPreview() => this.content;//this.content.length > 75? this.content.substring(0,  75) + '...' : this
  // .content;
  String getRelativePublishedTime() => DateFormat.MMMEd('en_US').format(publishedTime);
}
import 'package:fake_habrahabr/Models/Article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';





class ArticleView extends StatelessWidget{
  final Article article;

  ArticleView(this.article);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(children: [
            CircleAvatar(backgroundImage: article.author.profilePicture, radius: 18,),
            Padding(padding: EdgeInsets.only(left: 5), child: Text(article.author.username, style: TextStyle(fontSize: 27, color: Colors.blue)))
          ]),
          Row(children: [Expanded(child: Text(article.title, style: TextStyle(fontSize: 52)))]),
          Expanded(child: SingleChildScrollView(
            child: Text(article.content),
          )),
        ],
      )
    ),
  );
}
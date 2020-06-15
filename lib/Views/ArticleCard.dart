import 'dart:async';

import 'package:fake_habrahabr/Models/Article.dart';
import 'package:fake_habrahabr/Views/ArticleView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fake_habrahabr/Models/User.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final BoxConstraints constraints;

  final double titleFontSize = 36;

  ArticleCard(this.article, {this.constraints = const BoxConstraints()});

  @override
  Widget build(BuildContext context) => Container(
      constraints: constraints,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 3, blurRadius: 3, offset: Offset(0, 0))
          ],
        ),
        child: Column(children: <Widget>[
          Row(children: [Text(article.title, style: TextStyle(fontSize: titleFontSize))]),
          ArticleCardContentPreview(article),
          Container(
            margin: EdgeInsets.only(top: 10),
            //padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.05)),

            child: ArticleCardFoot(article),
          ),
        ]),

      ));
}

class ArticleCardContentPreview extends StatefulWidget {
  final Article article;

  ArticleCardContentPreview(this.article);

  @override
  State<StatefulWidget> createState() => ArticleCardContentPreviewState(article);
}

class ArticleCardContentPreviewState extends State<ArticleCardContentPreview> {
  final double contentsPreviewFontSize = 16;
  final int animationDurationInMillis = 80;

  final Article article;

  bool opened = false;

  ArticleCardContentPreviewState(this.article);

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => setState((){
        opened = !opened;
        return Timer(Duration(milliseconds: animationDurationInMillis), () => setState((){
          Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => ArticleView(article),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                var begin = Offset(1.0, 0.0);
                var end = Offset.zero;
                var tween = Tween(begin: begin, end: end);
                var offsetAnim = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnim,
                  child: child,
                );
              },
          ),);
          opened = !opened;
        }));
      }),

      child: Column(children: [
          AnimatedContainer(
              duration: Duration(milliseconds: animationDurationInMillis),
              constraints: BoxConstraints(
                minHeight: contentsPreviewFontSize * (opened ? 45 : 4.5),
                maxHeight: contentsPreviewFontSize * (opened ? 45 : 4.5),
              ),
              child: Text(
                article.getContentsPreview(),
                style: TextStyle(fontFamily: 'Times New Roman', fontSize: 16),
                overflow: TextOverflow.fade,
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_drop_down), Icon(Icons.arrow_drop_down), Icon(Icons.arrow_drop_down),
              Text('Tap to read full article'),
              Icon(Icons.arrow_drop_down), Icon(Icons.arrow_drop_down), Icon(Icons.arrow_drop_down),
            ],
          ),
      ],)
  );
}

class ArticleCardFoot extends StatelessWidget {
  final Article article;
  final int height = 40;

  ArticleCardFoot(this.article);

  @override
  Widget build(BuildContext context) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Published on:', style: TextStyle(color: Colors.grey.withOpacity(0.9), fontSize: height / 3)),
            Text(
              article.getRelativePublishedTime(),
              style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: height / 2.5),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(5),
          child: UserMiniCard(article.author, height),
        ),
      ]);
}

class UserMiniCard extends StatelessWidget {
  final User user;
  final int height;

  UserMiniCard(this.user, this.height);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
              padding: EdgeInsets.only(right: 2.5),
              child: CircleAvatar(backgroundImage: user.profilePicture, radius: height / 2.5)),
          Container(
            padding: EdgeInsets.only(left: 2.5),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(child: Text(user.username, style: TextStyle(color: Colors.blue, fontSize: height / 2.5))),
              Text(
                'Has ${user.numberOfArticlesWritten - 1} other articles',
                style: TextStyle(color: Colors.grey.withOpacity(0.9), fontSize: height / 4),
              )
            ]),
          ),
        ],
      );
}

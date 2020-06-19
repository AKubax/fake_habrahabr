import 'package:fake_habrahabr/Controller/ArticlesManager.dart';
import 'package:fake_habrahabr/Models/Article.dart';
import 'package:fake_habrahabr/Views/TheApp.dart';
import 'package:fake_habrahabr/Views/single_article_view.dart';
import 'package:fake_habrahabr/Views/views_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ArticlesListView extends StatelessWidget{

  @override
  Widget build(context) => ListView.builder(itemBuilder: (context, i) => GestureDetector(
    onTapDown: (_) => Provider.of<CurrentArticleContainer>(context, listen: false).article_id = i,
    child: ArticleCard(i),
  ));
}



class ArticleCard extends StatelessWidget{
  final int _article_id;
  Article _article;

  ArticleCard(this._article_id, {Key key}) : super(key: key){
    _article = ArticlesManager.getArticleById(_article_id);
  }

  @override
  Widget build(context){
    return _article == null ? Container() : Container(
      margin: EdgeInsets.all(5),

      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),

      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: 5, top: 5, right: 5),
          child: Text(
            _article.title,
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline3.fontFamily,
              fontSize: Theme.of(context).textTheme.headline3.fontSize,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ),
        GestureDetector(
            onTap: (){},/*(){
          Provider.of<CurrentArticleContainer>(context, listen: false).article = article;
          Navigator.push(context,MaterialPageRoute(builder: (context) => SingleArticleView()));
        },*/
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: SizedBox(
                height: ArticlesListViewConfig.articleContentPreviewHeight,
                child: Text(
                    _article.content,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
                      fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
                      color: Colors.black.withOpacity(0.7),
                    ),
                ),
              ),
            )
        ),

        Container(

        ),

        _footer(context),
      ]),
    );
  }

  Widget _footer(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),
    ),
    padding: EdgeInsets.all(10),
    height: ArticlesListViewConfig.articleCardFooterHeight,

    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Published on:', style: Theme.of(context).textTheme.caption),
        Text(_article.getRelativePublishedTime())
      ]),
      Row(children: [
        CircleAvatar(
            backgroundImage: _article.author.profilePicture,
            radius: (ArticlesListViewConfig.articleCardFooterHeight - 10) / 2 - 0.01
        ),
        GestureDetector(
          onTap: (){},
          child: Column(children: [
            Text(_article.author.username, style: TextStyle(fontSize: ArticlesListViewConfig
                .articleCardFooterHeight / 3, color: Colors.blue)),
            Text(
                _article.author.status,
                style: TextStyle(fontSize: ArticlesListViewConfig.articleCardFooterHeight / 5)
            )
          ])
        ),
      ],)
    ]),
  );
}
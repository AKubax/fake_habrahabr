import 'package:fake_habrahabr/Controller/ArticlesManager.dart';
import 'package:fake_habrahabr/Models/Article.dart';
import 'package:fake_habrahabr/Views/articles_list_view.dart';
import 'package:fake_habrahabr/Views/single_article_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class CurrentArticleContainer extends ChangeNotifier{
  int _id;

  set article_id(int id) => _id = id;

  set article(Article article){
    _id = article.id;
    notifyListeners();
  }
  Article get article => ArticlesManager.getArticleById(_id);
}

class TheApp extends StatelessWidget{

  @override
  Widget build(context) => ChangeNotifierProvider(
    create: (context) => CurrentArticleContainer(),
    child: MaterialApp(
        title: 'Fake News',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            body: TabBarView(children: [
              ArticlesListView(),
              SingleArticleView()
            ],),
          )
        ),
    ),
  );
}

/*
Scaffold(
            body: ArticlesListView()//SingleArticleView(article: ArticlesManager.getDummyArticle()),
        )
 */
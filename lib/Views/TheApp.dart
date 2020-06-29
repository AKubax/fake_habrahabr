import 'package:fake_habrahabr/Controller/ArticlesManager.dart';
import 'package:fake_habrahabr/Models/Article.dart';
import 'package:fake_habrahabr/Views/articles_list_view.dart';
import 'package:fake_habrahabr/Views/single_article_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class CurrentArticleContainer extends ChangeNotifier{
  int _id;

  set article_id(int id) => _id = id;

  /* set article(Article article){
    _id = article.id;
    notifyListeners();
  } */

  Future<Article> get article async => ArticlesManager.getArticleByChronoOrder(_id);
}

class TheApp extends StatefulWidget{

  static bool alreadyCreated = false;
  static final GlobalKey _theAppKey = GlobalKey<TheAppState>();

  TheApp._inner() : super(key: _theAppKey);

  factory TheApp() => alreadyCreated ? null : TheApp._inner();

  @override
  void dispose() => alreadyCreated = false;

  @override
  State<StatefulWidget> createState() => TheAppState(_theAppKey);
}

class TheAppState extends State<TheApp> with SingleTickerProviderStateMixin{
  final GlobalKey<TheAppState> _theAppKey;
  TabController tabController;

  TheAppState(this._theAppKey);

  @override
  void initState(){
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(context) => ChangeNotifierProvider(
    create: (context) => CurrentArticleContainer(),
    child: MaterialApp(
      title: 'Fake News',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        body: TabBarView(controller: tabController, children: [
          ArticlesListView(),
          SingleArticleView(_theAppKey),
        ],),
      )
    ),
  );
}
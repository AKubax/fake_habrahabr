
import 'dart:math';

import 'package:fake_habrahabr/Controller/ArticlesManager.dart';
import 'package:fake_habrahabr/Models/Article.dart';
import 'package:fake_habrahabr/Models/User.dart';
import 'package:fake_habrahabr/Views/TheApp.dart';
import 'package:fake_habrahabr/Views/views_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleArticleView extends StatefulWidget{
  final GlobalKey<TheAppState> theAppKey;

  SingleArticleView(this.theAppKey);

  @override
  State<StatefulWidget> createState() => _SingleArticleViewState(theAppKey);
}

class _SingleArticleViewState extends State<SingleArticleView> with TickerProviderStateMixin{
  Article _article;
  bool _disposed = false;
  GlobalKey _titleKey = GlobalKey();

  AnimationController _headerOpacityController, _titleOpacityController;
  Animation _headerOpacityTween, _titleOpacityTween;

  final GlobalKey<TheAppState> theAppKey;

  _SingleArticleViewState(this.theAppKey){
    _headerOpacityController = AnimationController(vsync: this, duration: Duration(seconds: 0));
    _headerOpacityTween = Tween(begin: 1.0, end: 0.0).animate(_headerOpacityController);

    _titleOpacityController = AnimationController(vsync: this, duration: Duration(seconds: 0));
    _titleOpacityTween = Tween(begin: 1.0, end: 0.0).animate(_titleOpacityController);
  }

  @override
  void initState() => super.initState();

  get _titleVerticalOffset => (_titleKey.currentContext.findRenderObject() as RenderBox)
      .localToGlobal(Offset.zero).dy;

  bool _onScroll(ScrollNotification scrollInfo){
    if (scrollInfo.metrics.axis != Axis.vertical) return false;

    _headerOpacityController.animateTo(
        scrollInfo.metrics.pixels / (2.1 * SingleArticleViewConfig.authorMinicardRadius)
    );
    _titleOpacityController.animateTo(
        (scrollInfo.metrics.pixels - _titleVerticalOffset * 0.9) / SingleArticleViewConfig.titleFontSize
    );

    return true;
  }

  @override
  Widget build(context) => NotificationListener<ScrollNotification>(
    onNotification: _onScroll,
    child: Consumer<CurrentArticleContainer>(
      builder: (context, articleContainer, child){
        articleContainer.article.then((newArticle){
          if (!_disposed) setState(() => _article = newArticle,);
        });

        return _article == null ? Container() : Scaffold(
          body: CustomScrollView(slivers: [
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => theAppKey.currentState.tabController.animateTo(0),
              ),
              title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: SingleArticleViewConfig.appBarWidth * 0.58,
                  child: AnimatedBuilder(
                    animation: _titleOpacityController,
                    builder: (context, child) => Opacity(opacity: pow(1 - _titleOpacityTween.value, 2), child: child),
                    child: Text(_article.title, overflow: TextOverflow.fade,),
                  )
                ),
                SizedBox(
                  width: SingleArticleViewConfig.appBarWidth * 0.38,
                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    AnimatedBuilder(
                      animation: _headerOpacityController,
                      builder: (context, child) => Opacity(opacity: pow(1 - _headerOpacityTween.value, 2), child: child),
                      child: UserMiniCard(
                          radius: SingleArticleViewConfig.authorMinicardRadius * 0.8,
                          user: _article.author
                      ),
                    ),
                  ]),
                )
              ],),
              pinned: true
            ),
            SliverList(delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(10),
                child: _header(context, _article),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: AnimatedBuilder(
                  animation: _titleOpacityController,
                  builder: (context, child) => Opacity(opacity: pow(_titleOpacityTween.value, 2), child: child),
                  child: Text(
                      _article.title,
                      key: _titleKey,
                      style: TextStyle(fontSize: SingleArticleViewConfig.titleFontSize)
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(_article.content),
              ),
            ])),
          ],),
        );
      },
    )
  );

  @override
  void dispose(){
    super.dispose();
    _disposed = true;
  }

  Widget _header(context, Article article) => AnimatedBuilder(
    animation: _headerOpacityController,
    builder: (context, child) => Opacity(
      opacity:  pow(_headerOpacityTween.value, 2),
      child: child,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 0.38 * MediaQuery.of(context).size.width,
          child: UserMiniCard(radius: SingleArticleViewConfig.authorMinicardRadius, user: article.author),
        ),
        SizedBox(
            width: 0.18 * MediaQuery.of(context).size.width,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.terrain, size: 40),
            ])
        ),
        SizedBox(
          width: 0.38 * MediaQuery.of(context).size.width,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [ //Space for additional info
            Text(
                'Author of ${article.author.numberOfArticlesWritten} articles',
                style: TextStyle(fontSize: SingleArticleViewConfig.titleFontSize / 3)
            )
          ]),
        ),

      ],
    )
  );



}

class UserMiniCard extends StatefulWidget{
  final double radius;
  final User user;

  UserMiniCard({Key key, @required this.radius, @required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserMiniCardState(radius, user);
}

class _UserMiniCardState extends State<UserMiniCard>{
  final double radius;
  final User user;

  _UserMiniCardState(this.radius, this.user);

  @override
  void initState(){


    super.initState();
  }

  @override
  Widget build(context) => Row(children: [
    CircleAvatar(
      backgroundImage: AssetImage('src/placeholder_profile_picture.png'),
      radius: radius,
    ),
    Padding(
      padding: EdgeInsets.only(left: radius * 0.15),
      child: GestureDetector(
        onTap: (){},
        child: Text(user.username, style: TextStyle(fontSize: 1.25 * radius)),
      ),
    ),
  ],);
}
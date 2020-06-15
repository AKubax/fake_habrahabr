import 'package:fake_habrahabr/Controller/ArticlesManager.dart';
import 'package:fake_habrahabr/Models/Article.dart';
import 'package:fake_habrahabr/Views/ArticleCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'ArticleView.dart';

typedef void OnWidgetSizeChange(Size size);

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key key,
    @required this.onChange,
    @required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}

class ArticlesListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ArticlesListViewState();
}

class ArticlesListViewState extends State<ArticlesListView> {
  List<Article> articles = ArticlesManager.getArticlesForTheFrontPage(0, 5);
  Size cardSize;
  final GlobalKey dummyCardKey = GlobalKey();

  @override
  Widget build(BuildContext context){
    if(cardSize == null){
      return MeasureSize(
        key: dummyCardKey,
        onChange: (size) => setState((){cardSize = size;}),
        child: ArticleCard(ArticlesManager.getDummyArticle()),
      );
    }

    return ListView.builder(
      itemCount: ArticlesManager.getNumberOfArticlesForTheFrontPage(),
      itemBuilder: (context, i) {
        if (i > articles.length - 2)
          articles.addAll(ArticlesManager.getArticlesForTheFrontPage(articles.length, articles.length + 5));

        return LayoutBuilder(builder: (context, constraints) => Container(
          constraints: constraints,
          child: Row(
            //constraints: BoxConstraints(maxWidth: constraints.maxWidth, maxHeight: constraints.maxWidth),
              children: [ArticleCard(articles[i], constraints: constraints,)]
                /*ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth, maxHeight: cardSize.height),
                  child: RefreshIndicator(
                    onRefresh: (){},
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [ArticleCard(articles[i], constraints: constraints)],
                  )),
                )
              ]*/
          )
        ));

        /*return LayoutBuilder(
            builder: (context, constraints) => Draggable(
                axis: Axis.horizontal,
                feedback: Container(
                  color: Colors.red,
                  constraints: BoxConstraints(minWidth: constraints.maxWidth, maxWidth: constraints.maxWidth,
                      minHeight: 300),
                ),
                child: ArticleCard(articles[i], constraints: constraints)
            ),
          );*/
      },
    );
  }
}

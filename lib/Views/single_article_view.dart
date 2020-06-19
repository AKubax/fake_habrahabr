
import 'package:fake_habrahabr/Controller/ArticlesManager.dart';
import 'package:fake_habrahabr/Models/Article.dart';
import 'package:fake_habrahabr/Models/User.dart';
import 'package:fake_habrahabr/Views/TheApp.dart';
import 'package:fake_habrahabr/Views/views_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleArticleView extends StatefulWidget{

  SingleArticleView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SingleArticleViewState();
}

class _SingleArticleViewState extends State<SingleArticleView>{

  @override
  Widget build(BuildContext context) => Consumer<CurrentArticleContainer>(
    builder: (context, articleContainer, child){
      Article article = articleContainer.article;
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(10),

              child: Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 0.38 * MediaQuery.of(context).size.width,
                        child: UserMiniCard(radius: SingleArticlesViewConfig.authorMinicardRadius, user: article.author),
                      ),
                      SizedBox(
                          width: 0.18 * MediaQuery.of(context).size.width,
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Icon(Icons.terrain),
                          ])
                      ),
                      SizedBox(
                        width: 0.38 * MediaQuery.of(context).size.width,
                        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [ //Space for additional info
                          Text(
                              'Author of ${article.author.numberOfArticlesWritten} articles',
                              style: TextStyle(fontSize: SingleArticlesViewConfig.titleFontSize / 3)
                          )
                        ]),
                      ),

                    ],),
                  Text(article.title, style: TextStyle(fontSize: SingleArticlesViewConfig.titleFontSize)),
                  Text(article.content),
                ],),
              )
          ),
        ),
      );
    }
  );

}

class UserMiniCard extends StatelessWidget{
  final double radius;
  final User user;

  UserMiniCard({Key key, @required this.radius, @required this.user}) : super(key: key);

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
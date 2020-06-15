import 'package:fake_habrahabr/Views/ArticleList.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Fake Habr',
      theme: ThemeData(primaryColor: Colors.white),
      home: Scaffold(
        body: Center(
          child: ArticlesListView(),
        ),
      )
    );
  }

}

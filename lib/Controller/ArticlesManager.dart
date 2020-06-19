import 'package:fake_habrahabr/Models/Article.dart';
import 'package:fake_habrahabr/Models/User.dart';
import 'package:flutter/material.dart';



class ArticlesManager {
  static Article getArticleById(int id) {
    return getDummyArticle(titleSuffix: ' #' + id.toString());
  }

  static Article getDummyArticle({String titleSuffix}) => Article(-1, User('akubaxx', AssetImage
    ('src/placeholder_profile_picture.png'),
  3), 'Roses are blue' + (titleSuffix ?? ''), '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
  Aliquam 
  vehicula turpis 
  sem. 
  Proin interdum tortor id 
    convallis feugiat. Quisque sit amet imperdiet elit. Cras egestas dolor vel arcu auctor, eget 
    ullamcorpergfdsgfdsgfds mauris eleifend. Vestibulum id ligula nec ex ultrices convallis ut vitae enim. Sed pretium vel eros bibendum pellentesque. Donec tempus, lorem nec tempor mattis, nunc lacus finibus urna, vitae scelerisque urna enim vitae odio. Sed venenatis ante eu lacinia porta. Praesent ante ligula, sollicitudin nec consectetur non, tempor ac felis. Fusce molestie egestas purus, vel dignissim arcu.
    In sagittis velit vitae dapibus rhoncus. Cras a odio augue. Proin vulputate orci ut porta consectetur. Integer non tincidunt libero, quis eleifend sapien. Integer dignissim porttitor ultricies. Sed consectetur eget sem non posuere. Curabitur porta vestibulum dictum. In blandit est et faucibus tristique. Praesent convallis ex non mattis consectetur. Nullam a nisl elit.
    Sed in tellus id nibh malesuada ullamcorper. Cras sit amet bibendum eros. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Maecenas dui dui, tempor vel dignissim egestas, ornare convallis tortor. Donec eget dictum nibh. Proin gravida pulvinar ante ac elementum. Suspendisse egestas eget lorem vel consectetur. Donec viverra tellus vel metus consectetur, at volutpat diam dictum.
    Aenean nisl magna, efficitur sit amet enim eget, suscipit posuere urna. Mauris sed pharetra odio. Aenean luctus dui et risus rutrum auctor. Cras convallis metus vel lobortis bibendum. Sed porta ligula eget congue volutpat. Sed nec mi tristique, bibendum turpis vel, laoreet diam. Vivamus vitae dictum justo, tincidunt aliquet nibh. Suspendisse ornare ligula ut odio pulvinar, sed faucibus est placerat. Proin quis euismod est, id porttitor ex. Curabitur sit amet fermentum nisl. Nam ornare sodales dui. Donec sit amet augue gravida, fringilla tellus porttitor, scelerisque augue. Proin lacus est, pretium posuere bibendum vitae, malesuada non nunc. Donec nec eleifend ipsum. Suspendisse ante libero, faucibus id scelerisque non, hendrerit eget mi.
    Aliquam porttitor posuere dignissim. Cras laoreet, justo vitae vehicula tincidunt, sem diam facilisis tortor, et lobortis velit magna id eros. Nunc a felis nulla. In enim dolor, dapibus eget fringilla volutpat, cursus id enim. Donec ante erat, tempor sed eros non, finibus finibus neque. Aliquam ac egestas augue, sed suscipit nisi. Phasellus sapien quam, finibus vitae fringilla ut, fringilla eu magna. Nulla vitae vehicula turpis. In neque risus, molestie et velit ac, convallis auctor sapien. Cras finibus, eros nec volutpat suscipit, elit magna blandit erat, ac aliquam tellus odio lacinia justo. Phasellus eleifend arcu ultricies est tristique, ut ornare massa iaculis. Duis congue dui quis est dictum gravida....''', DateTime.now());

  static List<Article> getArticlesForTheFrontPage(int startingFrom,  int upTo){
    return [for(int i = 0; i < upTo - startingFrom; i++) getArticleById(0)];
  }

  static int getNumberOfArticlesForTheFrontPage() => 50;
}
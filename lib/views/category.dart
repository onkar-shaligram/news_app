import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/views/home.dart';

import 'News Pages/forYou.dart';


class CategoryScreen extends StatefulWidget {
  
  final String category;
  CategoryScreen(this.category);
  

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  //List<Article> articles = List<Article> ();
  List<Article> articles = <Article>[];

   News news = News();

  @override
  void initState() {
    getAndSetNews();
    super.initState();
  }

  getAndSetNews() async {
    await news.getNewsByCategory(widget.category);
    articles = news.articles;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('${widget.category} News'),
      ),
      body: Container(
        child: ListView.builder(
                itemCount: articles.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return NewsTileForYou(
                    title: articles[index].title,
                    description: articles[index].description,
                    imageUrl : articles[index].urlToImage,
                    url: articles[index].url,
                    );
                }
                ),
      )
    );
  }
}
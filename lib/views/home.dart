import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/loader.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/views/articleview.dart';
import 'package:news_app/views/category.dart';

import 'News Pages/forYou.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<Category> categories = List<Category>();
  // List<Article> articles = List<Article>();
  List<Category> categories = <Category>[];
  List<Article> articles = <Article>[];

  News news = News();

  bool loading = true;
  var cindex = 0;

  @override
  void initState() {
    loading = true;
    categories = getCategoryData();
    getAndSetNews();
    super.initState();
  }

  getAndSetNews() async {
    await news.getNewsHeadLine();
    articles = news.articles;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Update",
                      style: TextStyle(color: Colors.brown),
                    ),
                    Text("  "),
                    Text(
                      "Me",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    // Container(
                    //   height: 200,
                    //   child: ListView.builder(
                    //     padding: EdgeInsets.symmetric(horizontal: 16),
                    //     itemCount: categories.length,
                    //     shrinkWrap: true,
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (context, index) {
                    //       return CategoryTile(categories[index].imgUrl,
                    //           categories[index].label);
                    //     },
                    //   ),
                    // ),
                    ListView.builder(
                        itemCount: articles.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          //return Text(articles[index].title);
                          return NewsTileForYou(
                            title: articles[index].title,
                            description: articles[index].description,
                            imageUrl: articles[index].urlToImage,
                            url: articles[index].url,
                            index: index,
                          );
                        })
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                currentIndex: cindex,
                items: [
                  BottomNavigationBarItem(
                    icon: InkWell(
                        onTap: () {
                          setState(() {
                            cindex = 0;
                          });
                        },
                        child: Icon(Icons.person)),
                    label: "For You",
                  ),
                  BottomNavigationBarItem(
                    icon: InkWell(
                        onTap: () {
                          setState(() {
                            cindex = 1;
                          });
                        },
                        child: Icon(Icons.add_circle_outline)),
                    label: "Headlines",
                  ),
                  BottomNavigationBarItem(
                    icon: InkWell(
                        onTap: () {
                          setState(() {
                            cindex = 2;
                          });
                        },
                        child: Icon(Icons.star_border_outlined)),
                    label: "Favorites",
                  ),
                  BottomNavigationBarItem(
                    icon: InkWell(
                        onTap: () {
                          setState(() {
                            cindex = 3;
                          });
                        },
                        child: Icon(Icons.fiber_new_sharp)),
                    label: "Newsstand",
                  ),
                ]),
          );
  }
}

class CategoryTile extends StatelessWidget {
  final String imgUrl, label;
  CategoryTile(this.imgUrl, this.label);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CategoryScreen(label)));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imgUrl,
                  height: 200,
                  width: 120,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black45,
                  height: 200,
                  width: 120,
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/views/articleview.dart';
import 'package:news_app/views/category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = List<Category>();
  List<Article> articles = List<Article>();

  News news = News();

  @override
  void initState() {
    categories = getCategoryData();
    getAndSetNews();
    super.initState();
  }

  getAndSetNews() async {
    await news.getNewsHeadLine();
    articles = news.articles;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News App'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                          categories[index].imgUrl, categories[index].label);
                    },
                  ),
                ),
                ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      //return Text(articles[index].title);
                      return NewsTile(
                        title: articles[index].title,
                        description: articles[index].description,
                        imageUrl: articles[index].urlToImage,
                        url: articles[index].url,
                      );
                    })
              ],
            ),
          ),
        ));
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
                // Image.network(
                // imgUrl,
                // height: 200,
                // width: 120,
                // fit: BoxFit.cover,
                // ),
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

class NewsTile extends StatelessWidget {
  final String imageUrl, title, description, url;

  NewsTile({this.imageUrl, this.title, this.description, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ArticleView(url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 18),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 180,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              description,
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

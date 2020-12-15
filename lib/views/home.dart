import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/model/category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Category> categories = List<Category>();

  @override
  void initState() {
    categories = getCategoryData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Container(
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
                    return CategoryTile(categories[index].imgUrl, categories[index].label);
                  },
                ),
            )
          ],
        ),
      )
    );
  }
}


class CategoryTile extends StatelessWidget {
  final String imgUrl, label;
  CategoryTile(this.imgUrl, this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          child: Stack(
            children: [
              Image.network(
              imgUrl, 
              height: 200, 
              width: 120,
              fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black45,
                height: 200, 
                width: 120,
                alignment: Alignment.center,
                child: Text(label, style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
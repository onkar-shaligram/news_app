import 'package:flutter/material.dart';
import 'package:news_app/views/articleview.dart';

class NewsTileForYou extends StatelessWidget {
  final String imageUrl, title, description, url;
  final int index;

  NewsTileForYou({this.imageUrl, this.title, this.description, this.url, this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Card(
          //color: Colors.white70,
          elevation: 2,
          //shadowColor: Colors.blueAccent,
          //margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ArticleView(url)));
            },
            child: Container(
              child: index == 0
                  ? Container(
                      margin: EdgeInsets.only(bottom: 18),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl,
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
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
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    description,
                                    style: TextStyle(fontSize: 12),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              )),
                          Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl,
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

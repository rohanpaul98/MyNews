import 'package:NewsApp/Helper/data.dart';
import 'package:NewsApp/Helper/news.dart';
import 'package:NewsApp/Models/ArticleModel.dart';
import 'package:NewsApp/Models/categorymodel.dart';
import 'package:NewsApp/Views/article_view.dart';
import 'package:NewsApp/Views/category_news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading;
  @override
  void initState() {
    _loading = true;
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = new News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'My',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            Text(
              'News',
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.yellow[200],
        child: SafeArea(
          child: _loading
              ? Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          height: 70,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return Categorytile(
                                img: categories[index].imageUrl,
                                catName: categories[index].categoryname,
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: articles.length,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BlogTile(
                                imageUrl: articles[index].urltoImage,
                                title: articles[index].title,
                                desc: articles[index].description,
                                url: articles[index].url,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  //bool get newMethod => _loading;
}

class Categorytile extends StatelessWidget {
  final img, catName;
  Categorytile({this.img, this.catName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryNews(
                category: catName.toLowerCase(),
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: img,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                catName,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  BlogTile({this.imageUrl, this.title, this.desc, this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(
                blogurl: url,
              ),
            ));
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrange, width: 4),
          borderRadius: BorderRadius.circular(10),
        ),
        duration: Duration(seconds: 3),
        curve: Curves.fastLinearToSlowEaseIn,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                desc,
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

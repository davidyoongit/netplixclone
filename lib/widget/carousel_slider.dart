import 'package:flutter/material.dart';
import 'package:helloworld/model/model_movie.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;
  CarouselImage({this.movies});
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  List<Movie> movies;
  List<Widget> images;
  List<String> keywords;
  List<bool> likes;
  int _currentPage = 0;
  String _currentKeyword;

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies.map((m) => Image.asset('./images/' + m.poster)).toList();
    keywords = movies.map((m) => m.keyword).toList();
    likes = movies.map((m) => m.like).toList();
    _currentKeyword = keywords[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(20),
      ),
      CarouselSlider(
          items: images,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
                _currentKeyword = keywords[_currentPage];
              });
            },
          )), //Carousel Slider
      Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
        child: Text(_currentKeyword),
      ), //Text
      Container(
          child: Row(children: <Widget>[
        Container(
          child: Column(children: <Widget>[
            likes[_currentPage]
                ? IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {},
                  )
                : IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {},
                  ),
            Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 11),
            )
          ]),
        ),
        Container(
          child: Column(children: <Widget>[
            likes[_currentPage]
                ? IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {},
                  )
                : IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {},
                  ),
            Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 11),
            )
          ]),
        ),
      ]))
    ]));
  }
}

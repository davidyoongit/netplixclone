import 'package:flutter/material.dart';
import 'package:helloworld/model/model_movie.dart';

class CarouseImage extends StatefulWidget {
  final List<Movie> movie;
  CarouseImage({this.movie});
  _CarouseImage createState() => _CarouseImageState();
}

class _CarouseImageState extends State<CarouselImage> {
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
    _currentKeyword = keyword[0];
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
        onPageChange: (index) {
          setState(() {
            _currentPage = index;
            _currentKeyword = keywords[_currentPage];
          });
        },
      ), //Carousel Slider
      Container(
        child: Text(_currentKeyword),
      )
    ]));
  }
}

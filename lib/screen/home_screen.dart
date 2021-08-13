import 'package:flutter/material.dart';
import 'package:helloworld/model/model_movie.dart';
import 'package:helloworld/widget/carousel_slider.dart';
import 'package:helloworld/widget/circle_slider.dart';
import 'package:helloworld/widget/box_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //더미데이터
  // List<Movie> movies = [
  //   Movie.fromMap({
  //     'title': '사랑의 불시착',
  //     'keyword': '사랑/로맨스/판타지',
  //     'poster': 'test_movie_1.png',
  //     'like': false
  //   }),
  //   Movie.fromMap({
  //     'title': '사랑의 불시착',
  //     'keyword': '사랑/로맨스/판타지',
  //     'poster': 'test_movie_1.png',
  //     'like': false
  //   }),
  //   Movie.fromMap({
  //     'title': '사랑의 불시착',
  //     'keyword': '사랑/로맨스/판타지',
  //     'poster': 'test_movie_1.png',
  //     'like': false
  //   }),
  //   Movie.fromMap({
  //     'title': '사랑의 불시착',
  //     'keyword': '사랑/로맨스/판타지',
  //     'poster': 'test_movie_1.png',
  //     'like': false
  //   }),
  // ];
  Firestore firestore = Firestore.instance;
  Stream<QuerySnapshot> streamData;

  @override
  void initState() {
    super.initState();
    //데이터 가져오기
    streamData = firestore.collection('movie').snapshots();
  }

  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildBody(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Movie> movies = snapshot.map((d) => Movie.fromSnapshot(d)).toList();
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            CarouselImage(movies: movies),
            TopBar(),
          ],
        ),
        CircleSlider(movies: movies),
        BoxSlider(movies: movies),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);

    // build Body로 이동
    // ListView(
    //   children: <Widget>[
    //     Stack(
    //       children: <Widget>[
    //         CarouselImage(movies: movies),
    //         TopBar(),
    //       ],
    //     ), //Stack
    //     CircleSlider(
    //       movies: movies,
    //     ),
    //     BoxSlider(
    //       movies: movies,
    //     ),
    //   ],
    // );

    //return TopBar();
    // return Container(
    //   child: Center(
    //     child: Text('real home'),
    // ),);
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'images/bbongflix_logo.png',
            fit: BoxFit.contain,
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '영화',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

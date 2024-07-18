import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix_ui_app/model/movie_model.dart';
import 'package:netflix_ui_app/screen/detail_screen.dart';

class CarouselSliderWidget extends StatefulWidget {
  final List<Movie> movies;
  const CarouselSliderWidget({
    super.key,
    required this.movies,
  });

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  List<Movie> movies = [];
  List<Widget> images = [];
  List<String> keywords = [];
  List<bool> likes = [];
  int _currentPage = 0;
  String _currentKeyword = '';

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies.map((movie) => Image.network(movie.poster)).toList();
    keywords = movies.map((movie) => movie.keyword).toList();
    likes = movies.map((movie) => movie.like).toList();
    _currentKeyword = keywords[0];
  }

  @override
  Widget build(BuildContext context) {
    movies = widget.movies;
    likes = movies.map((movie) => movie.like).toList();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
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
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              _currentKeyword,
              style: const TextStyle(fontSize: 11),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      likes[_currentPage]
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  likes[_currentPage] = !likes[_currentPage];
                                  movies[_currentPage].reference?.update({'like': likes[_currentPage]});
                                });
                              },
                              icon: const Icon(Icons.check),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  likes[_currentPage] = !likes[_currentPage];
                                  movies[_currentPage].reference?.update({'like': likes[_currentPage]});
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                      const Text(
                        '내가 찜한 콘텐츠',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {},
                    child: const Row(
                      children: <Widget>[
                        Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.all(3),
                        ),
                        Text(
                          '재생',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => DetailScreen(movie: movies[_currentPage])));
                        },
                        icon: const Icon(Icons.info),
                      ),
                      const Text(
                        '정보',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: makeIndicator(likes, _currentPage),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> makeIndicator(List list, int currentPage) {
  List<Widget> results = [];
  for (int i = 0; i < list.length; i++) {
    results.add(
      Container(
        width: 8,
        height: 8,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: i == currentPage ? const Color.fromRGBO(255, 255, 255, 0.9) : const Color.fromRGBO(255, 255, 255, 0.4),
        ),
      ),
    );
  }

  return results;
}

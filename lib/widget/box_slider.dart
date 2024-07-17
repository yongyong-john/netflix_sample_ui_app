import 'package:flutter/material.dart';
import 'package:netflix_ui_app/model/movie_model.dart';
import 'package:netflix_ui_app/screen/detail_screen.dart';

class BoxSlider extends StatelessWidget {
  final List<Movie> movies;
  const BoxSlider({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('지금 뜨는 콘텐츠'),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeBoxImages(context, movies),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> makeBoxImages(BuildContext context, List<Movie> movies) {
    List<Widget> results = [];

    for (int i = 0; i < movies.length; i++) {
      results.add(
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(movie: movies[i])));
          },
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.network(movies[i].poster),
            ),
          ),
        ),
      );
    }

    return results;
  }
}

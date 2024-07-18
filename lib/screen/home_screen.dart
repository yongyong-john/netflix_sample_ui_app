import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix_ui_app/model/movie_model.dart';
import 'package:netflix_ui_app/widget/box_slider.dart';
import 'package:netflix_ui_app/widget/carousel_slider.dart';
import 'package:netflix_ui_app/widget/circle_slider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('movie').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return _buildBody(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshots) {
    List<Movie> movies = snapshots.map((doc) => Movie.fromSnapshot(doc)).toList();
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            CarouselSliderWidget(movies: movies),
            const TopBar(),
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
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'images/bbongflix_logo.png',
            fit: BoxFit.contain,
            height: 25,
          ),
          Container(
            padding: const EdgeInsets.only(right: 1),
            child: const Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 1),
            child: const Text(
              '영화',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 1),
            child: const Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

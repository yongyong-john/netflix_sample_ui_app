import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String title;
  final String keyword;
  final String poster;
  final bool like;
  final DocumentReference? reference;

  Movie({
    required this.title,
    required this.keyword,
    required this.poster,
    required this.like,
    this.reference,
  });

  Movie.fromMap(Map<String, dynamic> map, {this.reference})
      : title = map['title'] ?? '',
        keyword = map['keyword'] ?? '',
        poster = map['poster'] ?? '',
        like = map['like'] ?? false;

  Movie.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

  @override
  String toString() => "Movie<$title:$keyword>";
}

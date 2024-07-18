import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix_ui_app/model/movie_model.dart';
import 'package:netflix_ui_app/screen/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _searchText = "";

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<DocumentSnapshot> searchResults = [];
    for (DocumentSnapshot d in snapshot) {
      if (d.data.toString().contains(_searchText)) {
        searchResults.add(d);
      }
    }
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.5,
        padding: const EdgeInsets.all(3),
        children: searchResults.map((data) => _buildListItem(context, data)).toList(),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final movie = Movie.fromSnapshot(data);
    return InkWell(
      child: Image.network(movie.poster),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(movie: movie);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.black,
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextField(
                    focusNode: _focusNode,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    autofocus: true,
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white60,
                        size: 20,
                      ),
                      suffixIcon: _focusNode.hasFocus
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _filter.clear();
                                  _searchText = "";
                                });
                              },
                              icon: const Icon(
                                Icons.cancel,
                                size: 20,
                              ),
                            )
                          : Container(),
                      hintText: '검색',
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                _focusNode.hasFocus
                    ? Expanded(
                        child: TextButton(
                          child: const Text(
                            '취소',
                            style: TextStyle(color: Colors.white60),
                          ),
                          onPressed: () {
                            setState(() {
                              _filter.clear();
                              _searchText = "";
                              _focusNode.unfocus();
                            });
                          },
                        ),
                      )
                    : Expanded(
                        flex: 0,
                        child: Container(),
                      ),
              ],
            ),
          ),
          _buildBody(context),
        ],
      ),
    );
  }
}

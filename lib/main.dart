import 'package:flutter/material.dart';
import 'package:netflix_ui_app/screen/home_screen.dart';
import 'package:netflix_ui_app/screen/like_screen.dart';
import 'package:netflix_ui_app/screen/search_screen.dart';
import 'package:netflix_ui_app/widget/bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix UI',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.black,
          secondary: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.grey[900], // Scaffold의 배경 색상 설정
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              const SearchScreen(),
              const LikeScreen(),
              Container(
                child: const Center(
                  child: Text('more'),
                ),
              ),
            ],
          ),
          bottomNavigationBar: const BottomBar(),
        ),
      ),
    );
  }
}

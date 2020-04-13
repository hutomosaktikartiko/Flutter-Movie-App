import 'package:flutter/material.dart';
import 'package:movie_app/utilities/app_style.dart';
import 'tab_bar_views/home_movies.dart' as homeMovies;
import 'tab_bar_views/popular_movies.dart' as popularMovies;
import 'tab_bar_views/search_movies.dart' as searchMovies;
import 'tab_bar_views/profile.dart' as profile;

void main() => runApp(MoviesApp());

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new homeMovies.HomeMovies(),
          new popularMovies.PopularMovie(),
          new searchMovies.SearchMovies(),
          new profile.Profile()
        ],
      ),
      bottomNavigationBar: new Material(
          color: AppStyle.bg2,
          child: new TabBar(
            indicatorColor: Colors.transparent,
            controller: controller,
            tabs: <Widget>[
              new Tab(
                icon: new Icon(Icons.movie),
                text: "Movie",
              ),
              new Tab(
                icon: new Icon(Icons.spa),
                text: "Ranking",
              ),
              new Tab(
                icon: new Icon(Icons.search),
                text: "Find",
              ),
              new Tab(
                icon: new Icon(Icons.account_box),
                text: "About",
              ),
            ],
          )),
    );
  }
}

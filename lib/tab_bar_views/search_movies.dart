import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/services/api_provider.dart';
import 'package:movie_app/tab_bar_views/detail_movies.dart';
import 'package:movie_app/utilities/app_style.dart';
import 'package:movie_app/utilities/loading.dart';

class SearchMovies extends StatefulWidget {
  @override
  _SearchMoviesState createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  ApiProvider apiProvider = ApiProvider();
  Future<SearchMovie> searchMovie;

  TextEditingController editingController = TextEditingController();
  String searchText = "";
  
  @override
  Widget build(BuildContext context) {
    if(searchText.length > 0) {
      setState(() {
        searchMovie = apiProvider.getSearchMovie(searchText);
      });
    } else {
      Text("Input something");
    }
    String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Movie',
          style: AppStyle.title,
        ),
        backgroundColor: AppStyle.bg,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        color: AppStyle.bg,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white30),
                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) {
                        setState(() {
                          searchText = editingController.text;
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        });
                      },
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppStyle.bg2,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hintText: "Search what you looking for ...",
                        hintStyle: TextStyle(color: Colors.white30),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white30,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.transparent),
                          borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.transparent),
                          borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: searchMovie,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.results.length,
                        itemBuilder: (context, index) {
                          return searchMovieItem(
                              poster:
                                  '$imageBaseUrl${snapshot.data.results[index].posterPath}',
                              title: '${snapshot.data.results[index].title}',
                              originalLanguage:
                                  '${snapshot.data.results[index].originalLanguage}',
                              popularity:
                                  '${snapshot.data.results[index].popularity}',
                              voteAverage:
                                  '${snapshot.data.results[index].voteAverage}',
                              index: index,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailSearchMovie(
                                          searchMovieDetail:
                                              snapshot.data.results[index],
                                        )));
                              });
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    print("Has Error: ${snapshot.hasError}");
                    return Center(
                        child: Text(
                      'Error, Check your connections !',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                      ),
                    ));
                  } else {
                    print("Loading...");
                    return Loading();
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget searchMovieItem(
      {String poster,
      String title,
      String popularity,
      String voteAverage,
      String originalLanguage,
      int index,
      Function onTap}) {
    return Stack(children: <Widget>[
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(left: 5, right: 5, top: 25),
            child: Stack(children: <Widget>[
              Card(
                color: AppStyle.bg2,
                child: Container(
                  height: 140,
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  0.0,
                  -20.0,
                  0.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4)),
                        width: 100,
                        height: 150,
                        child: CachedNetworkImage(
                          imageUrl: poster,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 45),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              title,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                RatingBarIndicator(
                                  rating: double.parse(voteAverage) * 0.5,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemSize: 15.0,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: AppStyle.ambr,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    voteAverage,
                                    style: TextStyle(color: AppStyle.ambr),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text("Popularity " + popularity,
                                  style: AppStyle.subtitleMovies),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    ]);
  }
}

class SearchMovie {
  int page;
  int totalResults;
  int totalPages;
  List<SearchMovieResult> results;

  SearchMovie({this.page, this.totalResults, this.totalPages, this.results});

  SearchMovie.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['TOTAL_RESULTS'];
    totalPages = json['TOTAL_PAGES'];
    if (json['results'] != null) {
      results = new List<SearchMovieResult>();
      json['results'].forEach((v) {
        results.add(new SearchMovieResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['TOTAL_RESULTS'] = this.totalResults;
    data['TOTAL_PAGES'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchMovieResult {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  SearchMovieResult(
      {this.popularity,
      this.voteCount,
      this.video,
      this.posterPath,
      this.id,
      this.adult,
      this.backdropPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.title,
      this.voteAverage,
      this.overview,
      this.releaseDate});

  SearchMovieResult.fromJson(Map<String, dynamic> json) {
    popularity = json['popularity'];
    voteCount = json['vote_count'];
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage = json['vote_average'].toDouble();
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['vote_count'] = this.voteCount;
    data['video'] = this.video;
    data['poster_path'] = this.posterPath;
    data['id'] = this.id;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }
}

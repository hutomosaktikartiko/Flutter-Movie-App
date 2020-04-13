import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/tab_bar_views/detail_movies.dart';
import 'package:movie_app/utilities/loading.dart';
import 'package:movie_app/services/api_provider.dart';
import 'package:movie_app/utilities/app_style.dart';

class PopularMovie extends StatefulWidget {
  @override
  _PopularMovieState createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie> {
  ApiProvider apiProvider = ApiProvider();
  Future<PopularMovies> popularMovies;
  String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    popularMovies = apiProvider.getPopularMovies();
    super.initState();
  }

  int i = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ranking',
          style: AppStyle.title,
        ),
        backgroundColor: AppStyle.bg,
        elevation: 0.0,
      ),
      body: Container(
        color: AppStyle.bg,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: FutureBuilder(
            future: popularMovies,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print("Has Data: ${snapshot.hasData}");
                return ListView.builder(
                  itemCount: snapshot.data.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    return moviesItem(
                        poster:
                            '$imageBaseUrl${snapshot.data.results[index].posterPath}',
                        title: '${snapshot.data.results[index].title}',
                        originalLanguage:
                            '${snapshot.data.results[index].originalLanguage}',
                        popularity: '${snapshot.data.results[index].popularity}',
                        voteAverage:
                            '${snapshot.data.results[index].voteAverage}',
                            index: index,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailPopularMovies(
                                    popularMovieDetail:
                                        snapshot.data.results[index],
                                  )));
                        });
                  },
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
            },
          ),
        ),
      ),
    );
  }

  Widget moviesItem(
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
                          borderRadius: BorderRadius.circular(4)
                        ),
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
      Container(
        transform: Matrix4.translationValues(
                                    0.0,
                                    -5.0,
                                    0.0,
                                  ),
        margin: EdgeInsets.only(right: 30,),
        child: Align(
            alignment: Alignment.topRight,
            child: Stack(children: <Widget>[
              Icon(
                Icons.spa,
                size: 50,
                color: AppStyle.blue,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 27, 15, 13),
                child: Text(
                  (index < 9 ? "0"+(index+1).toString() : index+1).toString(),
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            ])),
      )
    ]);
  }
}

class PopularMovies {
  int page;
  int totalResults;
  int totalPages;
  List<PopularResults> results;

  PopularMovies({this.page, this.totalResults, this.totalPages, this.results});

  PopularMovies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['TOTAL_RESULTS'];
    totalPages = json['TOTAL_PAGES'];
    if (json['results'] != null) {
      results = new List<PopularResults>();
      json['results'].forEach((v) {
        results.add(new PopularResults.fromJson(v));
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

class PopularResults {
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

  PopularResults(
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

  PopularResults.fromJson(Map<String, dynamic> json) {
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

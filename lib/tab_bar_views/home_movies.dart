import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/tab_bar_views/detail_movies.dart';
import 'package:movie_app/services/api_provider.dart';
import 'package:movie_app/utilities/app_style.dart';
import 'package:movie_app/utilities/loading.dart';

class HomeMovies extends StatefulWidget {
  @override
  _HomeMoviesState createState() => _HomeMoviesState();
}

class _HomeMoviesState extends State<HomeMovies> {
  ApiProvider apiProvider = ApiProvider();

  Future<UpComingMovies> upComingMovies;
  Future<HomePopularMovies> homePopularMovies;
  Future<GenreMovies> genreMovies;

  String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    upComingMovies = apiProvider.getUpComingMovies();
    homePopularMovies = apiProvider.getHomePopularMovies();
    genreMovies = apiProvider.getGenreMovies();
    super.initState();
  }

  double currentPageValue = 0;

  int _current = 0;
  List imgList = [
    'https://image.tmdb.org/t/p/w500/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg',
    'https://image.tmdb.org/t/p/w500/xFxk4vnirOtUxpOEWgA1MCRfy6J.jpg',
    'https://image.tmdb.org/t/p/w500/qsxhnirlp7y4Ae9bd11oYJSX59j.jpg',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bg,
      appBar: AppBar(
        title: Text('Movie', style: AppStyle.title),
        backgroundColor: AppStyle.bg,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 940),
            child: Column(
              children: <Widget>[
                Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                      CarouselSlider(
                        height: 200.0,
                        initialPage: 0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        reverse: false,
                        enableInfiniteScroll: true,
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlayAnimationDuration: Duration(milliseconds: 2000),
                        pauseAutoPlayOnTouch: Duration(seconds: 10),
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {
                          setState(() {
                            _current = index;
                          });
                        },
                        items: imgList.map((imgUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: AppStyle.bg2,
                                ),
                                child: Image.network(
                                  imgUrl,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: map<Widget>(imgList, (index, url) {
                          return Container(
                            width: 17.0,
                            height: 3.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: _current == index
                                  ? AppStyle.blue
                                  : AppStyle.bg2,
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ])),
                    FutureBuilder(
                      future: genreMovies,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            flex: 4,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.genres.length,
                              itemBuilder: (BuildContext context, int index) {
                                return genreItem(
                                  name: '${snapshot.data.genres[index].name}',
                                  bgColor: index % 2 == 0 ? "AppStyle.skyBlue" : "AppStyle.ambr",
                                  onTap: () {

                                  }
                                );
                              }),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error, Check your connection", style: TextStyle(color: Colors.red, fontSize: 20),));
                        } else {
                          print("Loading...");
                          return Loading();
                        }
                      }),
                Container(
                  margin: EdgeInsets.only(left: 14, bottom: 10),
                  height: 30,
                  child: Row(children: <Widget>[
                    Text(
                      "Popular",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )
                  ]),
                ),
                FutureBuilder(
                    future: homePopularMovies,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                            flex: 10,
                            child: ListView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return homePopularMoviesItem(
                                      poster:
                                          '$imageBaseUrl${snapshot.data.results[index].posterPath}',
                                      title:
                                          '${snapshot.data.results[index].title}',
                                      originalLanguage:
                                          '${snapshot.data.results[index].originalLanguage}',
                                      popularity:
                                          '${snapshot.data.results[index].popularity}',
                                      voteAverage:
                                          '${snapshot.data.results[index].voteAverage}',
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailHomePopularMovies(
                                                      homePopularMoviesDetail:
                                                          snapshot.data
                                                              .results[index],
                                                    )));
                                      });
                                }));
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
                Container(
                  margin: EdgeInsets.only(left: 14, top: 20, bottom: 10),
                  height: 30,
                  child: Row(children: <Widget>[
                    Text(
                      "Coming Soon",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )
                  ]),
                ),
                FutureBuilder(
                    future: upComingMovies,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                            flex: 10,
                            child: ListView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return upComingMoviesItem(
                                      poster:
                                          '$imageBaseUrl${snapshot.data.results[index].posterPath}',
                                      title:
                                          '${snapshot.data.results[index].title}',
                                      originalLanguage:
                                          '${snapshot.data.results[index].originalLanguage}',
                                      popularity:
                                          '${snapshot.data.results[index].popularity}',
                                      voteAverage:
                                          '${snapshot.data.results[index].voteAverage}',
                                      releaseDate:
                                          '${snapshot.data.results[index].releaseDate}',
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailUpComingMovies(
                                                      upComingMovieDetail:
                                                          snapshot.data
                                                              .results[index],
                                                    )));
                                      });
                                }));
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
        ),
      ),
    );
  }

  Widget genreItem (
    {String name, var bgColor, Function onTap}) {
      return InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(left: 10, bottom: 10),
          child: Card(
            color: AppStyle.bg2,
            child: Container(
              width: 130,
              child: Row(
                children: <Widget>[
                  Expanded(child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )
                  ),)
                ]
              )
            )
          ),
        ),);
  }

  Widget homePopularMoviesItem(
      {String poster,
      String title,
      String popularity,
      String voteAverage,
      String originalLanguage,
      Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Card(
          color: AppStyle.bg,
          elevation: 0.0,
          child: Container(
            width: 120,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          poster,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  width: 120,
                  height: 180,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        child: Row(
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget upComingMoviesItem(
      {String poster,
      String title,
      String popularity,
      String voteAverage,
      String originalLanguage,
      String releaseDate,
      Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10, bottom: 10),
        child: Card(
          color: AppStyle.bg,
          elevation: 0.0,
          child: Container(
            width: 120,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          poster,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  width: 120,
                  height: 180,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            title,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3),
                          child: Text(
                            releaseDate,
                            style:
                                TextStyle(color: AppStyle.ambr, fontSize: 13),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenreMovies {
  List<GenreMoviesResults> genres;

  GenreMovies({this.genres});

  GenreMovies.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genres = new List<GenreMoviesResults>();
      json['genres'].forEach((v) {
        genres.add(new GenreMoviesResults.fromJson(v));
      });
    }
  }
}

class GenreMoviesResults {
  int id;
  String name;

  GenreMoviesResults({this.id, this.name});

  GenreMoviesResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class HomePopularMovies {
  int page;
  int totalResults;
  int totalPages;
  List<HomePopularMoviesResults> results;

  HomePopularMovies(
      {this.page, this.totalResults, this.totalPages, this.results});

  HomePopularMovies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['TOTAL_RESULTS'];
    totalPages = json['TOTAL_PAGES'];
    if (json['results'] != null) {
      results = new List<HomePopularMoviesResults>();
      json['results'].forEach((v) {
        results.add(new HomePopularMoviesResults.fromJson(v));
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

class HomePopularMoviesResults {
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

  HomePopularMoviesResults(
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

  HomePopularMoviesResults.fromJson(Map<String, dynamic> json) {
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

class UpComingMovies {
  int page;
  int totalResults;
  int totalPages;
  List<UpComingResults> results;

  UpComingMovies({this.page, this.totalResults, this.totalPages, this.results});

  UpComingMovies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['TOTAL_RESULTS'];
    totalPages = json['TOTAL_PAGES'];
    if (json['results'] != null) {
      results = new List<UpComingResults>();
      json['results'].forEach((v) {
        results.add(new UpComingResults.fromJson(v));
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

class UpComingResults {
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

  UpComingResults(
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

  UpComingResults.fromJson(Map<String, dynamic> json) {
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

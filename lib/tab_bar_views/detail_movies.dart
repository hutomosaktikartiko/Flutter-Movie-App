import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/tab_bar_views/popular_movies.dart';
import 'package:movie_app/tab_bar_views/home_movies.dart';
import 'package:movie_app/tab_bar_views/search_movies.dart';
import 'package:movie_app/utilities/app_style.dart';

class DetailPopularMovies extends StatelessWidget {
  final PopularResults popularMovieDetail;

  const DetailPopularMovies({Key key, this.popularMovieDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        color: AppStyle.bg,
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Flexible(
                  flex: 2,
                  child: Container(
                    transform: Matrix4.translationValues(
                      0.0,
                      -56.0,
                      0.0,
                    ),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            '$imageBaseUrl/' + popularMovieDetail.backdropPath),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(30, 30),
                          bottomRight: Radius.elliptical(30, 30)),
                    ),
                    // child: Image.network('$imageBaseUrl'+ popularMovieDetail.backdropPath, fit: BoxFit.cover,),
                  )),
              Flexible(
                  flex: 3,
                  child: Container(
                    transform: Matrix4.translationValues(
                      0.0,
                      -30.0,
                      0.0,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                popularMovieDetail.title,
                                style: AppStyle.titleDetailMovie,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              // Text(" | ", style: TextStyle(color: Colors.white30, fontSize: 20),),
                              Text(popularMovieDetail.releaseDate, style: TextStyle(color: Colors.white30),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: Row(
                            children: <Widget>[
                              RatingBarIndicator(
                                rating: popularMovieDetail.voteAverage * 0.5,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 20.0,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: AppStyle.ambr,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  popularMovieDetail.voteAverage.toString(),
                                  style: TextStyle(
                                      color: AppStyle.ambr, fontSize: 20),
                                ),
                              ),
                              Spacer(),
                              Text(popularMovieDetail.id.toString(),
                                  style: TextStyle(color: Colors.white30))
                            ],
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.bottomLeft,
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Sinopsis",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              child: Text(popularMovieDetail.overview,
                                  style: TextStyle(
                                      color: Colors.white30, fontSize: 15),
                                  textAlign: TextAlign.justify),
                            )
                          ],
                        )),
                        // )
                      ],
                    ),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}

class DetailHomePopularMovies extends StatelessWidget {
  final HomePopularMoviesResults homePopularMoviesDetail;

  const DetailHomePopularMovies({Key key, this.homePopularMoviesDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        color: AppStyle.bg,
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Flexible(
                  flex: 2,
                  child: Container(
                    transform: Matrix4.translationValues(
                      0.0,
                      -56.0,
                      0.0,
                    ),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            '$imageBaseUrl/' + homePopularMoviesDetail.backdropPath),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(30, 30),
                          bottomRight: Radius.elliptical(30, 30)),
                    ),
                    // child: Image.network('$imageBaseUrl'+ homePopularMoviesDetail.backdropPath, fit: BoxFit.cover,),
                  )),
              Flexible(
                  flex: 3,
                  child: Container(
                    transform: Matrix4.translationValues(
                      0.0,
                      -30.0,
                      0.0,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                homePopularMoviesDetail.title,
                                style: AppStyle.titleDetailMovie,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              // Text(" | ", style: TextStyle(color: Colors.white30, fontSize: 20),),
                              Text(homePopularMoviesDetail.releaseDate, style: TextStyle(color: Colors.white30),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: Row(
                            children: <Widget>[
                              RatingBarIndicator(
                                rating: homePopularMoviesDetail.voteAverage * 0.5,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 20.0,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: AppStyle.ambr,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  homePopularMoviesDetail.voteAverage.toString(),
                                  style: TextStyle(
                                      color: AppStyle.ambr, fontSize: 20),
                                ),
                              ),
                              Spacer(),
                              Text(homePopularMoviesDetail.id.toString(),
                                  style: TextStyle(color: Colors.white30))
                            ],
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.bottomLeft,
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Sinopsis",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              child: Text(homePopularMoviesDetail.overview,
                                  style: TextStyle(
                                      color: Colors.white30, fontSize: 15),
                                  textAlign: TextAlign.justify),
                            )
                          ],
                        )),
                        // )
                      ],
                    ),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}

class DetailUpComingMovies extends StatelessWidget {
  final UpComingResults upComingMovieDetail;

  const DetailUpComingMovies({Key key, this.upComingMovieDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        color: AppStyle.bg,
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Flexible(
                  flex: 2,
                  child: Container(
                    transform: Matrix4.translationValues(
                      0.0,
                      -56.0,
                      0.0,
                    ),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            '$imageBaseUrl/' + upComingMovieDetail.backdropPath),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(30, 30),
                          bottomRight: Radius.elliptical(30, 30)),
                    ),
                    // child: Image.network('$imageBaseUrl'+ upComingMovieDetail.backdropPath, fit: BoxFit.cover,),
                  )),
              Flexible(
                  flex: 3,
                  child: Container(
                    transform: Matrix4.translationValues(
                      0.0,
                      -30.0,
                      0.0,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                upComingMovieDetail.title,
                                style: AppStyle.titleDetailMovie,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              // Text(" | ", style: TextStyle(color: Colors.white30, fontSize: 20),),
                              Text(upComingMovieDetail.releaseDate, style: TextStyle(color: Colors.white30),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: Row(
                            children: <Widget>[
                              RatingBarIndicator(
                                rating: upComingMovieDetail.voteAverage * 0.5,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 20.0,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: AppStyle.ambr,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  upComingMovieDetail.voteAverage.toString(),
                                  style: TextStyle(
                                      color: AppStyle.ambr, fontSize: 20),
                                ),
                              ),
                              Spacer(),
                              Text(upComingMovieDetail.id.toString(),
                                  style: TextStyle(color: Colors.white30))
                            ],
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.bottomLeft,
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Sinopsis",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              child: Text(upComingMovieDetail.overview,
                                  style: TextStyle(
                                      color: Colors.white30, fontSize: 15),
                                  textAlign: TextAlign.justify),
                            )
                          ],
                        )),
                        // )
                      ],
                    ),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}

class DetailSearchMovie extends StatelessWidget {
  final SearchMovieResult searchMovieDetail;

  const DetailSearchMovie({Key key, this.searchMovieDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        color: AppStyle.bg,
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Flexible(
                  flex: 2,
                  child: Container(
                    transform: Matrix4.translationValues(
                      0.0,
                      -56.0,
                      0.0,
                    ),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            '$imageBaseUrl/' + searchMovieDetail.backdropPath),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(30, 30),
                          bottomRight: Radius.elliptical(30, 30)),
                    ),
                    // child: Image.network('$imageBaseUrl'+ detailSearchMovie.backdropPath, fit: BoxFit.cover,),
                  )),
              Flexible(
                  flex: 3,
                  child: Container(
                    transform: Matrix4.translationValues(
                      0.0,
                      -30.0,
                      0.0,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                searchMovieDetail.title,
                                style: AppStyle.titleDetailMovie,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              // Text(" | ", style: TextStyle(color: Colors.white30, fontSize: 20),),
                              Text(searchMovieDetail.releaseDate, style: TextStyle(color: Colors.white30),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: Row(
                            children: <Widget>[
                              RatingBarIndicator(
                                rating: searchMovieDetail.voteAverage * 0.5,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 20.0,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: AppStyle.ambr,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  searchMovieDetail.voteAverage.toString(),
                                  style: TextStyle(
                                      color: AppStyle.ambr, fontSize: 20),
                                ),
                              ),
                              Spacer(),
                              Text(searchMovieDetail.id.toString(),
                                  style: TextStyle(color: Colors.white30))
                            ],
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.bottomLeft,
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Sinopsis",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              child: Text(searchMovieDetail.overview,
                                  style: TextStyle(
                                      color: Colors.white30, fontSize: 15),
                                  textAlign: TextAlign.justify),
                            )
                          ],
                        )),
                        // )
                      ],
                    ),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}

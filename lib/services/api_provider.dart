import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import 'package:movie_app/tab_bar_views/home_movies.dart';
import 'package:movie_app/tab_bar_views/popular_movies.dart';
import 'package:movie_app/tab_bar_views/search_movies.dart';

class ApiProvider {
  String apiKey = 'fa8832c55db3bc246e74a7b024fb99b6';
  String baseUrl = 'https://api.themoviedb.org/3';
  

  Client client = Client();

  Future<GenreMovies> getGenreMovies() async {
    Response responseGenreMovies = await client.get('$baseUrl/genre/movie/list?api_key=$apiKey');

    if (responseGenreMovies.statusCode == 200) {
      return GenreMovies.fromJson(jsonDecode(responseGenreMovies.body));
    } else {
      throw Exception(responseGenreMovies.statusCode);
    }
  }

  // Future<GenreMovieDetail> getGenreMovieDetail() async {
  //   Response responseGenreMovieDetail = await client.get('$baseUrl/genre/movie/list?api_key=$apiKey');

  //   if (responseGenreMovieDetail.statusCode == 200) {
  //     return GenreMovieDetail.fromJson(jsonDecode(responseGenreMovieDetail.body));
  //   } else {
  //     throw Exception(responseGenreMovieDetail.statusCode);
  //   }
  // }

  Future<PopularMovies> getPopularMovies() async {
    Response responsePopularMovies =
        await client.get('$baseUrl/movie/popular?api_key=$apiKey');

    if (responsePopularMovies.statusCode == 200) {
      return PopularMovies.fromJson(jsonDecode(responsePopularMovies.body));
    } else {
      throw Exception(responsePopularMovies.statusCode);
    }
  }

  Future<UpComingMovies> getUpComingMovies() async {
    Response responseUpComingMovies = await client.get('$baseUrl/movie/upcoming?api_key=$apiKey');

    if (responseUpComingMovies.statusCode == 200) {
      return UpComingMovies.fromJson(jsonDecode(responseUpComingMovies.body));
    } else {
      throw Exception(responseUpComingMovies.statusCode);
    }
  }

  Future<HomePopularMovies> getHomePopularMovies() async {
    Response responseHomePopularMovies =
        await client.get('$baseUrl/movie/popular?api_key=$apiKey');

    if (responseHomePopularMovies.statusCode == 200) {
      return HomePopularMovies.fromJson(jsonDecode(responseHomePopularMovies.body));
    } else {
      throw Exception(responseHomePopularMovies.statusCode);
    }
  }

  Future<SearchMovie> getSearchMovie(query) async {
    Response responseSearchMovie = await client.get('$baseUrl/search/movie?api_key=$apiKey&query=$query');
    if(responseSearchMovie.statusCode == 200) {
      return SearchMovie.fromJson(jsonDecode(responseSearchMovie.body));
    } else {
      throw Exception(responseSearchMovie.statusCode);
    }
  }
}

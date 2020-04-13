import 'package:movie_app/models/base_model.dart';

class ItemModel extends BaseModel {
  int _page;
  int _total_results;
  int _total_pages;
  List<_Result> _results = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _total_pages = parsedJson['page'];
    _total_results = parsedJson['total_results'];
    List<_Result> temp = [];
    for(int i = 0; i<parsedJson['results'].length; i++) {
      _Result result = _Result(parsedJson[i]);
      temp.add(result);
    }
    _results = temp;
  }
  List<_Result> get results => _results;
  int get total_pages => _total_pages;
  int get total_results => _total_results;
  int get page => _page;
}

class _Result {
  int _vote_count;
  int _id;
  bool _video;
  var _vote_average;
  String _title;
  double _popularity;
  String _poster_path;
  String _original_language;
  String _original_title;
  List<int> _genre_ids = [];
  String _backdrop_path;
  bool _adult;
  String _overview;
  String _release_date;
  

  _Result(result) {
    _vote_count = result['vote_count'];
    _id = result['id'];
    _video = result['video'];
    _vote_average = result['vote_average'];
    _title = result['title'];
    _popularity = result['popularity'];
    _poster_path = result['poster_path'];
    _original_language = result['original_language'];
    _original_title = result['original_title'];
    for (int i = 0; i<result['genre_ids'][i]; i++) {
      _genre_ids.add(result['genre_ids'][i]);
    }
  }
}
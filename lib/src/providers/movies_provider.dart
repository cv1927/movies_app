import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movies_app/src/models/actors_models.dart';
import 'package:movies_app/src/models/movies_models.dart';

class MoviesProvider {

  String _apiKey   = '1e0a4841d367d5783a5e0cbe2840abae';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando     = false;

  List<Movie> _popular = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStream() {
    _popularStreamController?.close();
  }

  Future<List<Movie>> getMovieCinema() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  : _apiKey,
      'language' : _language
    });

    return await _responseMovies(url);

  }

  Future<List<Movie>> getMoviesPopular() async {

    if (_cargando) return [];

    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'   : _apiKey,
      'language'  : _language,
      'page'      : _popularesPage.toString()
    });

    final res = await _responseMovies(url);

    _popular.addAll(res);
    popularSink( _popular );

    _cargando = false;

    return res;
  }

  Future<List<Movie>> _responseMovies(Uri url) async {

    final resp  = await http.get( url );

    final decodedData = json.decode( resp.body );

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Actor>> getCast( String movieId) async {

    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key'   : _apiKey,
      'language'  : _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode( resp.body );

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;

  }

  Future<List<Movie>> searchMovie( String search ) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key'  : _apiKey,
      'language' : _language,
      'query'    : search
    });

    return await _responseMovies(url);

  }

}
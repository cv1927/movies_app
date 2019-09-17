import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movies_app/src/models/movies_models.dart';

class MoviesProvider {

  String _apiKey   = '1e0a4841d367d5783a5e0cbe2840abae';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';


  Future<List<Movie>> getMovieCinema() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  : _apiKey,
      'language' : _language
    });

    final resp = await http.get( url );

    final decodedData = json.decode( resp.body );

    final movies = new Movies.fromJsonList(decodedData['results']);

    print( movies.items[0] );

    return movies.items;

  }

  Future<List<Movie>> getMovies(String apiUrl) async {

    final url = Uri.https(_url, apiUrl, {
      'api_key'   : _apiKey,
      'language'  : _language
    });


    final resp  = await http.get( url );

    final decodedData = json.decode( resp.body );

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

}
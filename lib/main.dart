import 'package:flutter/material.dart';

//My Pages
import 'package:movies_app/src/pages/home_page.dart';
import 'package:movies_app/src/pages/movies_details.dart';
 
void main() => runApp(MovieApp());
 
class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      initialRoute: '/',
      routes: {
        '/'             : ( BuildContext context ) => HomePage(),
        'movie_detail'  : ( BuildContext context ) => MovieDetails()
      },
    );
  }
}
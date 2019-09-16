import 'package:flutter/material.dart';

//My Pages
import 'package:movies_app/src/pages/home_page.dart';
 
void main() => runApp(MovieApp());
 
class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      initialRoute: '/',
      routes: {
        '/'   : ( BuildContext context) => HomePage()
      },
    );
  }
}
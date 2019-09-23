import 'package:flutter/material.dart';

import '../models/movies_models.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({ @required this.movies, @required this.nextPage });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {

      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }

    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return _card(context, movies[index]);
        },
        //children: _cards(context),
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {

    movie.uniqueId = '${ movie.id }-popular';

    final card = Container(
      margin: EdgeInsets.only(right: 8.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: movie.posterPath != null ? NetworkImage( movie.getPosterImg() ) : AssetImage('images/no-image.jpg'),
                placeholder: AssetImage('images/no-image.jpg'),
                fit: BoxFit.cover,
                height: 120.0,
              ),
            ),
          ),
          SizedBox(height: 5.0,),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, 'movie_detail', arguments: movie);
      },
    );

  }

  List<Widget> _cards(BuildContext context) {

    return movies.map( (movie) {

      return Container(
        margin: EdgeInsets.only(right: 8.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: movie.posterPath != null ? NetworkImage( movie.getPosterImg() ) : AssetImage('images/no-image.jpg'),
                placeholder: AssetImage('images/no-image.jpg'),
                fit: BoxFit.cover,
                height: 120.0,
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );

    }).toList();

  }
}
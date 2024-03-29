import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/movies_provider.dart';


import 'package:movies_app/src/search/search_delegate.dart';

//My Widgets
import 'package:movies_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getMoviesPopular();

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      appBar: AppBar(
        centerTitle: false,
        title: Text('Información Peliculas'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text('Peliculas en cartelera', style: Theme.of(context).textTheme.subhead,)
                ),
                _swiperTarjetas(),
              ],
            ),
            _footer(context)
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: moviesProvider.getMovieCinema(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if ( snapshot.hasData ) {
          return CardSwiper( movies: snapshot.data, );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }

      },
    );

    // moviesProvider.getMovieCinema();

    // return CardSwiper(
    //   movies: [1,2,3,4,5,6],
    // );
  }

  Widget _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead,)
          ),
          SizedBox(height: 8.0,),
          
          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getMoviesPopular,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator()
                );
              }
            },
          ),
        ],
      ),
    );

  }


}
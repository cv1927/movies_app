import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/movies_provider.dart';

//My Widgets
import 'package:movies_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
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
          
          FutureBuilder(
            future: moviesProvider.getMovies('3/movie/popular'),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data,
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
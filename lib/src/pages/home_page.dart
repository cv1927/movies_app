import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/movies_provider.dart';

//My Widgets
import 'package:movies_app/src/widgets/card_swiper_widget.dart';

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
          children: <Widget>[
            _swiperTarjetas()
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
}
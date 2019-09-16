import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:movies_app/src/models/movies_models.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  CardSwiper({ @required this.movies });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context,int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: movies[index].posterPath != null ? NetworkImage( movies[index].getPosterImg() ) : AssetImage('images/no-image.jpg'),
              placeholder: AssetImage('images/no-image.jpg'),
              fit: BoxFit.cover,
            )
          );
        },
        itemCount: movies.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
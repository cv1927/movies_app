import 'package:flutter/material.dart';

import 'package:movies_app/src/models/movies_models.dart';
import 'package:movies_app/src/models/actors_models.dart';


import 'package:movies_app/src/providers/movies_provider.dart';

class MovieDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppbar( movie ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 10.0, ),
                _posterTitle( context, movie ),
                _description( movie ),
                _createCasting( movie ),
              ]
            ),
          ),
        ],
      )
    );
  }

  Widget _createAppbar( Movie movie ) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          overflow: TextOverflow.ellipsis,
        ),
        background: FadeInImage(
          image: movie.backdropPath != null ? NetworkImage( movie.getBackgroundImg() ) : AssetImage('images/no-image.jpg'),
          placeholder: AssetImage('images/loading.gif'),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
    
  }

  Widget _posterTitle( BuildContext context, Movie movie ) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image(
                image: movie.posterPath != null ? NetworkImage( movie.getPosterImg() ) : AssetImage('images/no-image.jpg'),
                height: 150.0,
              ),
            ),
          ),
          SizedBox( width: 20.0, ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text( movie.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis, ),
                Text( movie.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis, ),
                Row(
                  children: <Widget>[
                    Icon( Icons.star_border, color: Colors.yellow[600], ),
                    Text( movie.voteAverage.toString(), style: Theme.of(context).textTheme.subhead, )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );

  }

  Widget _description( Movie movie ) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );

  }

  Widget _createCasting( Movie movie ) {

    final movieProvider = new MoviesProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        
        if (snapshot.hasData) {
          return _crearActorsPageView( snapshot.data );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }

      },
    );

  }

  Widget _crearActorsPageView( List<Actor> actors) {
    
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actors.length,
        itemBuilder: (context, index) => _actorCard(actors[index]),
      ),
    );

  }

  Widget _actorCard( Actor actor ) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: actor.profilePath != null ? NetworkImage( actor.getPhoto() ) : AssetImage('images/no-image.jpg'),
              placeholder: AssetImage('images/loading.gif'),
              fit: BoxFit.cover,
              height: 150.0,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
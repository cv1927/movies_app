import 'package:flutter/material.dart';

import 'package:movies_app/src/models/movies_models.dart';

import 'package:movies_app/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {

  String select = '';

  final MoviesProvider moviesProvider = new MoviesProvider();

  final movies = [
    'Spiderman',
    'Superman',
    'Shazam',
    'Batman',
    'Aquaman',
    'Capitan America',
    'IronMan',
    'IronMan 2',
    'IronMan 3',
    'IronMan 4',
    'IronMan 5',
  ];

  final moviesRecent = [
    'Spiderman',
    'Capitan America'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBaR
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(select),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        
        if ( snapshot.hasData ) {

          final movies = snapshot.data;

          return ListView(
            children: movies.map( (movie) {

              movie.uniqueId = '${ movie.id }-search';

              return ListTile(
                leading: Hero(
                  tag: movie.uniqueId,
                  child: FadeInImage(
                    image: movie.posterPath != null ? NetworkImage( movie.getPosterImg() ) : AssetImage('images/no-image.jpg'),
                    placeholder: AssetImage('images/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: () {
                  close(context, null);
                  Navigator.pushNamed(context, 'movie_detail', arguments: movie);
                },
              );
            }).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }

      },
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias que aparecen cuando la persona escribe

  //   final listSuggestion = ( query.isEmpty ) ? moviesRecent : movies.where(
  //                           (m) => m.toLowerCase().startsWith(query.toLowerCase())
  //                         ).toList();

  //   return ListView.builder(
  //     itemCount: listSuggestion.length,
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listSuggestion[index]),
  //         onTap: () {
  //           select = listSuggestion[index];
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }

}
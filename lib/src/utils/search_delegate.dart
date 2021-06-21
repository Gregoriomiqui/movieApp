import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/providers/peliculas_providers.dart';


class DataSearch extends SearchDelegate {

  String selection = "";

  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spíderman',
    'capitan america',
    'superman',
    'x-men',
    'cruela',
    'atrapame si puedes',
    'ironman'
  ];

  final peliculasRecientes = [
    'Spíderman',
    'capitan america',
  ];

  
  @override
  List<Widget> buildActions(BuildContext context) {
    // las acciones de nuestro appbar
    return [
      IconButton(
        onPressed: (){
          query = '';
        },
        icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(
          context,
          null
        );
      },
      icon: AnimatedIcon( 
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation
      )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.amberAccent,
        child: Text(selection),
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // son las sugerencias cuando la persona escribe


    // final listaSugerida = ( query.isEmpty ) 
    //                     ? peliculasRecientes : 
    //                     peliculas.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

    // return ListView.builder(
    //   itemCount: listaSugerida.length,
    //   itemBuilder: (context, i){
    //     return ListTile(
    //       leading: Icon(Icons.movie),
    //       title: Text(listaSugerida[i]),
    //       onTap: (){
    //         selection = listaSugerida[i];
    //         showResults(context);
    //       },
    //     );
    //   }
    // );


    if ( query.isEmpty ){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.searchMovie(query),
      builder: (BuildContext context,  AsyncSnapshot<List<Pelicula>> snapshot) {
        if ( snapshot.hasData){

          final peliculas = snapshot.data;

          return ListView(
            children: peliculas!.map(( pelicula ){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder:  AssetImage('assets/no-image.jpg'), 
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList(),
              
            
          );
          
        }else{
          return  Center(child: CircularProgressIndicator());
        }
      },
    );



  }




}
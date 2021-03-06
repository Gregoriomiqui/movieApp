

import 'package:flutter/material.dart';
import 'package:movie_app/src/models/actores_model.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/providers/peliculas_providers.dart';



class PeliculaDetalle extends StatelessWidget {
  

  




  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context)!.settings.arguments as Pelicula;
    
    

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
             [
               SizedBox( height: 10.0 ),
               _posterTitulo(context, pelicula),
               _descripcion( pelicula ),
               _crearCasting(context, pelicula.id), 
             ]
            )
          )
        ],
      )
    );
  }

  Widget _crearAppbar(Pelicula pelicula){
    
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(pelicula.title, style: TextStyle(color: Colors.white, fontSize: 16.0)),
        background: FadeInImage(
          placeholder: AssetImage('assets/ellipsis_loading.gif'), 
          image: NetworkImage(pelicula.getBackgroundImg()),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 150),
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage( pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox( width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(pelicula.title, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle2 )
                  ],
                )
              ],
            )
          ),
        ]
      )
    );

  }

  Widget _descripcion( Pelicula pelicula ){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(pelicula.overview!, textAlign: TextAlign.justify),
    );
  }

  Widget _crearCasting( BuildContext context, int peliId ) {

    final peliculasProvider = new PeliculasProvider();


    
    return FutureBuilder(
      future: peliculasProvider.getCast(peliId.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if (snapshot.hasData ){
          return _crearActoresPageView( context, snapshot.data as List<Actor> );
        }else{
          return Center(child: CircularProgressIndicator() );
        }
        
      },
    );

  }

  Widget  _crearActoresPageView( BuildContext context, List<Actor> actores){
    
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta( actores[i]),
      )
    );

  }

  Widget _actorTarjeta( Actor  actor){
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.getFoto()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis),
        ],
      )
    );
  }

}
import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/providers/peliculas_providers.dart';
import 'package:movie_app/src/widgets/card_swiper_widget.dart';
import 'package:movie_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cines'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.search))
          ],
        ),
        body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        )));
  }


  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
        Container(
          padding: EdgeInsets.only(left:20.0),
          child: Text('Populares', style: Theme.of(context).textTheme.subtitle1)
        ),
        SizedBox(height: 5.0),
        
        StreamBuilder(
          stream: peliculasProvider.popularesStream,
          builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
            if (snapshot.hasData) {
              return MovieHorizontal(peliculas: snapshot.data, siguientePagina: peliculasProvider.getPopulares);
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],) ,
    );
  }

  Widget _swiperTarjetas() {
  
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiperWidget(peliculas: snapshot.data);
        } else {
          return Container(
            child: Center(
              child: CircularProgressIndicator()
            ), 
            height: 400.0,
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';



class MovieHorizontal extends StatelessWidget {
  
    
  final List<Pelicula>? peliculas;

  MovieHorizontal({ required this.peliculas });
  
  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;
    
    return Container(
      height: _screenSize.height * 0.3,  
      child: PageView(
        pageSnapping: true,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        children: _tarjetas(context),
      )
    
    );
  }

  List<Widget> _tarjetas( BuildContext context ){


    return peliculas!.map((pelicula){

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(pelicula.getPosterImg()), 
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            Text(pelicula.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption,)
          ],
        ),

      );

    }).toList();

  }
}



import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/src/models/pelicula_model.dart';


class PeliculasProvider {
  String _apikey = 'a45ef124123e44ac5be2d12481b43d4f';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES'; 

  int _popularesPage = 0;

  List<Pelicula> _populares = [];


  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();


  Function (List<Pelicula> )get popularesSink => _popularesStreamController.sink.add;


  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;



  void disposeStream(){
    _popularesStreamController.close();
  }


  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key'  : _apikey,
      'language' : _language
    });

    return await _callApiMovie(url);
  }

  Future<List<Pelicula>> getPopulares() async {

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key'  : _apikey,
      'language' : _language,
      'page'     : _popularesPage.toString()
    });


    final resp = await _callApiMovie(url);

    _populares.addAll(resp);

    popularesSink(_populares);

    return resp;
  }

  Future<List<Pelicula>> _callApiMovie(Uri url) async {
    final resp = await http.get( url );
    final decodedData = json.decode( resp.body );
    
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }
}
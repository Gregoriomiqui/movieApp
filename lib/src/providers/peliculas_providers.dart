

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/src/models/actores_model.dart';
import 'package:movie_app/src/models/pelicula_model.dart';


class PeliculasProvider {
  String _apikey = 'a45ef124123e44ac5be2d12481b43d4f';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES'; 

  int _popularesPage = 0;
  bool _cargando = false;
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

    if (_cargando ) return [];
    _cargando = true;

    _popularesPage++;


    print('cargando siguientes...');

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key'  : _apikey,
      'language' : _language,
      'page'     : _popularesPage.toString()
    });


    final resp = await _callApiMovie(url);

    _populares.addAll(resp);

    popularesSink(_populares);
    _cargando=false;
    return resp;
  }

  Future<List<Pelicula>> _callApiMovie(Uri url) async {
    final resp = await http.get( url );
    final decodedData = json.decode( resp.body );
    
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }


  Future<List<Actor>> getCast( String peliId ) async {

    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key'  : _apikey,
      'language' : _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;

  }


    Future<List<Pelicula>> searchMovie( String query ) async {

    final url = Uri.https(_url, '3/search/movie',{
      'api_key'  : _apikey, 
      'language' : _language,
      'query'    : query, 
    });

    return await _callApiMovie(url);
  }


}
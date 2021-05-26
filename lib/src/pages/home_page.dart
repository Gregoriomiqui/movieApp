import 'package:flutter/material.dart';
import 'package:movie_app/src/widgets/card_swiper_widget.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperTarjetas(),
          ],
        )
      )
    );
  }

  Widget _swiperTarjetas(){
    return CardSwiperWidget(
      peliculas: [1,2,3,4,5],
    );
  }
}

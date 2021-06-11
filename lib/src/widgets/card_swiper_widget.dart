import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

class CardSwiperWidget extends StatelessWidget {
  
  final List<dynamic>? peliculas;

  CardSwiperWidget({ required this.peliculas });


  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context,int index){
          peliculas![index].uniqueId = '${peliculas![index].id}-principal';
          return Hero(
              tag: peliculas![index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, 'detalle', arguments: peliculas![index] );
                  },
                  child: FadeInImage(
                    image: NetworkImage((peliculas![index].getPosterImg())),
                    placeholder: AssetImage('assets/ellipsis_loading.gif'),
                    fit: BoxFit.cover,
                  ),
                )
              ),
            );
        },
        itemCount: peliculas!.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
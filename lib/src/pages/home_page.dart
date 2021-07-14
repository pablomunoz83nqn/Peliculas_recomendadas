import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';




class HomePage extends StatelessWidget {


  final peliculasProvider = new PeliculasProvider();

  

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas recomendadas', style: TextStyle(color: Colors.white, fontSize: 20.0)),
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(icon: Icon(Icons.search),
           onPressed: (){
             showSearch(
               context: context, 
               delegate: DataSearch(),
               //query: 'Ingrese una palabra'
                );
           })
        ],
      ),

      body:

        Container(
          padding: EdgeInsets.only(left: 20.0),
          child: 
          Column(
            
            
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
                
                Row(
                                    
                  children: [
                  Icon( Icons.movie,color: Colors.yellow,),
                  Text('Últimos estrenos', style: Theme.of(context).textTheme.subtitle1,),
                ],),
                _swiperTarjetas(),
                _footer(context)
            ],
          ),
        )
  

    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }

         
      },
    );

  }

  Widget _footer(BuildContext context) {

    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              
              child: 
              
              Row(
                children: [
                  Icon( Icons.star,color: Colors.yellow,),
                  Text('Mejor puntuadas', style: Theme.of(context).textTheme.subtitle1,),
                ],
              )),
            SizedBox(
              height: 10.0,
            ),
            
                     StreamBuilder(
              stream: peliculasProvider.popularesStream,
          

              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

                if(snapshot.hasData){
                  return MovieHorizontal(
                    peliculas: snapshot.data,
                    siguientePagina: peliculasProvider.getPopulares,
                    );
                }else{
                  Center(child: CircularProgressIndicator());
                }
                return Container();

         
      },
    )

    
      ],
    ),
  );


  }
}
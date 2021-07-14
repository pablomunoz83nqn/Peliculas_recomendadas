

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  
  

  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    

    return Scaffold(
      
      body: CustomScrollView(
        
        slivers: [
          _crearAppbar (pelicula),
          SliverList(
            
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                
                Row(
                  
                  children: [
                    SizedBox(width: 30.0,),
                    Text('Actores',style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis,),
                  ],
                ),
                _crearCasting(pelicula),
                _otrosDatos(context, pelicula),
                
              ]
            )
            )
        ],
        
      ),
      
    );
  }

  Widget _crearAppbar(Pelicula pelicula){

    

    return SliverAppBar(
        elevation: 2.0,
        backgroundColor: Colors.indigo,
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            pelicula.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
             ),
         background: CachedNetworkImage(

                imageUrl: pelicula.getBackgroundImg(),
              placeholder: (context, url) =>new Image.asset('assets/img/loading.gif'),
              errorWidget: (context, url, error) => Icon(Icons.error), 
              // image: NetworkImage(pelicula.getBackgroundImg(),),
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
          children: [
            Hero(
              tag: pelicula.uniqueId,
                 child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
                width: 150.0,
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pelicula.title,style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis, maxLines: 2,),
                  Text('Titulo original: '+pelicula.originalTitle,style: Theme.of(context).textTheme.overline,overflow: TextOverflow.ellipsis, ),
                  Text('Lanzamiento: '+pelicula.releaseDate,style: Theme.of(context).textTheme.caption,overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 10.0),
                  Text('Puntaje de la gente'),
                  Row(children: [                    
                    Icon( Icons.star,color: Colors.yellow,size: 50.0,),
                    Text(pelicula.voteAverage.toString(),style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis,)
                  ],)
                ],
              ))
          ],
        ),
      );

  }

  Widget _descripcion(Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {

    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      
      builder: (context, AsyncSnapshot<List> snapshot) {

        if (snapshot.hasData) {
          return _crearActoresPageView (snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );


  }

  Widget _crearActoresPageView(List<Actor> actores) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actores.length,
        itemBuilder: (context, i)=> _actorTarjeta(actores[i]),

        ),
    );

  }

  Widget _actorTarjeta(Actor actor){
return Container(
  
  
  
  child: Column(
    
    children: [
      
      ClipRRect(
        
        borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
          placeholder: AssetImage('assets/img/no-image.jpg'), 
          image: NetworkImage(actor.getFoto()),
          height: 150.0,
          fit: BoxFit.cover,
        ),
      ),
      Text(actor.name,
      overflow: TextOverflow.ellipsis,)
    ],
  ),
);

  }

  Widget _otrosDatos(BuildContext context, Pelicula pelicula) {

    
     return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            
            SizedBox(width: 20.0),
            Flexible(
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Poster Original',style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis,),
                  ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                
                child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.contain,
                ),
              ),
                  Text('Número de votos: '+pelicula.voteCount.toString(),style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis, maxLines: 2,),
                  //Text('Título para adultos: '+pelicula.adult.toString(),style: Theme.of(context).textTheme.headline6,overflow: TextOverflow.ellipsis, ),
                  Text('Popularidad: '+pelicula.popularity.toString(),style: Theme.of(context).textTheme.caption,overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 10.0),
                  Text('Puntaje de la gente'),
                  Row(children: [                    
                    Icon( Icons.star,color: Colors.yellow,size: 50.0,),
                    Text(pelicula.voteAverage.toString(),style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis,)
                  ],)
                ],
              ))
          ],
        ),
      );

  }
}
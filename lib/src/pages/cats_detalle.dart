import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:gatos/src/models/cats_model.dart';
import 'package:gatos/src/providers/gatos_provider.dart';

class CatsDetalle extends StatelessWidget {
  final gatosProvider = CatsProvider();
  @override
  Widget build(BuildContext context) {
    final Cats cats = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppbar(cats),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10.0,
                ),
                _descripcion(cats),
                SizedBox(
                  width: 30.0,
                ),
                _otrosDatos(context, cats),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearAppbar(Cats cats) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.green,
      expandedHeight: 80.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          cats.tags[0],
          style: TextStyle(color: Colors.orange, fontSize: 30.0),
        ),
        background: CachedNetworkImage(
          imageUrl: 'https://' + gatosProvider.urlCats + cats.url,
          placeholder: (context, url) =>
              new Image.asset('assets/img/loading.gif'),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 150),
        ),
      ),
    );
  }

  Widget _descripcion(Cats cats) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        cats.id,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _otrosDatos(BuildContext context, Cats cats) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          SizedBox(width: 20.0),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Original Gif',
                style: Theme.of(context).textTheme.headline5,
                overflow: TextOverflow.ellipsis,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CachedNetworkImage(
                  imageUrl: 'https://' + gatosProvider.urlCats + cats.url,
                  placeholder: (context, url) =>
                      new Image.asset('assets/img/loading.gif'),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  // image: NetworkImage(cats.getBackgroundImg(),),
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 150),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Released Date: ' + cats.createdAt.toString(),
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 40.0),
              Text('Tags'),
              Row(
                children: [
                  Icon(
                    Icons.note_add,
                    color: Colors.yellow,
                    size: 50.0,
                  ),
                  Text(
                    cats.tags.toString(),
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}

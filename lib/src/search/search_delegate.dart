import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gatos/src/models/cats_model.dart';
import 'package:gatos/src/providers/gatos_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';

  final gatosProvider = CatsProvider();
  @override
  String get searchFieldLabel => 'Create your Gif';

  @override
  List<Widget> buildActions(BuildContext context) {
    // acciones del appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //  Icono a la izquierda del appbar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que vamos a mostrar
    // son las sugerencias que aparecen copiado abajo clonado
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: gatosProvider.createCats(query),
      builder: (BuildContext context, AsyncSnapshot<Cats> snapshot) {
        if (snapshot.hasData) {
          final gatos = snapshot.data;

          return ListTile(
            leading: FadeInImage(
              image: NetworkImage(gatos.url),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              width: 50.0,
              fit: BoxFit.contain,
            ),
            title: Text(gatos.id),
            subtitle: Text(gatos.tags.toString()),
            onTap: () {
              close(context, null);
              gatos.id = '';
              Navigator.pushNamed(context, 'detalle', arguments: gatos);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // son las sugerencias que aparecen copiado abajo clonado
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: gatosProvider.createCats(query),
      builder: (BuildContext context, AsyncSnapshot<Cats> snapshot) {
        if (snapshot.hasData) {
          final gatos = snapshot.data;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 10.0,
              child: GestureDetector(
                onTap: () {
                  close(context, null);
                  gatos.id = '';
                  Navigator.pushNamed(context, 'detalle', arguments: gatos);
                },
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: !gatosProvider.loading
                          ? CachedNetworkImage(
                              imageUrl: 'https://' +
                                  gatosProvider.urlCats +
                                  gatos.url,
                              placeholder: (context, url) => Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Image.asset(
                                  'assets/img/loading.gif',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              // image: NetworkImage(cats.getBackgroundImg(),),
                              fit: BoxFit.cover,
                              fadeInDuration: Duration(milliseconds: 150),
                            )
                          : AssetImage('assets/img/no-image.jpg'),
                    ),
                    Text(
                      ' See details! ',
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

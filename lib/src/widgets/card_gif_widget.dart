import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gatos/src/models/cats_model.dart';
import 'package:gatos/src/providers/gatos_provider.dart';

class CardGif extends StatefulWidget {
  final Cats gatos;

  CardGif({@required this.gatos});

  @override
  State<CardGif> createState() => _CardGifState();
}

class _CardGifState extends State<CardGif> {
  final gatosProvider = CatsProvider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.9,
      child: !gatosProvider.loading
          ? CachedNetworkImage(
              imageUrl: 'https://' + gatosProvider.urlCats + widget.gatos.url,
              placeholder: (context, url) => Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.fitHeight,
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 150),
            )
          : AssetImage('assets/img/no-image.jpg'),
    );
  }
}

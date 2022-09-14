import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_button/flutter_button.dart';
import 'package:gatos/src/providers/gatos_provider.dart';
import 'package:gatos/src/search/search_delegate.dart';

import 'package:gatos/src/widgets/card_gif_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final gatosProvider = new CatsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(context), body: _body());
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text('Cat Gif Creator',
          style: TextStyle(color: Colors.white, fontSize: 20.0)),
      backgroundColor: Colors.grey,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: IconButton(
              icon: Icon(
                Icons.create,
                size: 40,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
              }),
        )
      ],
    );
  }

  Container _body() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/img/back.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _title(),
          _meowButton(),
          _catsContainer(),
        ],
      ),
    );
  }

  Row _title() {
    return Row(
      children: [
        Icon(
          Icons.catching_pokemon,
          color: Colors.yellow,
        ),
        Text(
          'Gimme Some cats!',
          style: TextStyle(
              color: Colors.yellow,
              fontSize: 30,
              backgroundColor: Colors.grey.withOpacity(0.8)),
        ),
      ],
    );
  }

  Widget _catsContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.9,
      child: FutureBuilder(
        future: gatosProvider.getCats(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return CardGif(gatos: snapshot.data);
          } else {
            return _waitingWidget();
          }
        },
      ),
    );
  }

  Container _waitingWidget() => Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.asset(
          'assets/img/loading.gif',
          fit: BoxFit.fitHeight,
        ),
      );

  Widget _meowButton() {
    return Button3D(
      style: StyleOf3dButton(
        z: 15,
        backColor: Colors.blueGrey,
        topColor: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      height: 200,
      width: 200,
      onPressed: () async {
        await gatosProvider.getCats();
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: !gatosProvider.loading
            ? FadeInImage(
                image: AssetImage('assets/img/meow_button.jpeg'),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.fitHeight,
              )
            : AssetImage('assets/img/no-image.jpg'),
      ),
    );
  }
}

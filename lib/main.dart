import 'package:flutter/material.dart';

import 'package:gatos/src/pages/home_page.dart';
import 'package:gatos/src/pages/cats_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cat Gif builder',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => CatsDetalle(),
      },
    );
  }
}

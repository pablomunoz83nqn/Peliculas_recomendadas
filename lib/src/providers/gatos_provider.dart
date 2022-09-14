import 'dart:async';
import 'dart:convert';
import 'package:gatos/src/models/cats_model.dart';
import 'package:http/http.dart' as http;

class CatsProvider {
  String urlCats = 'cataas.com';
  final Map<String, String> _queryParameters = <String, String>{
    'json': 'true',
  };

  bool loading = false;

  //creo el codigo de Stream (solo es la tuberia)
  final _popularesStreamController = StreamController<
      Cats>.broadcast(); //broadcast para que haya muchos listeners del stream y no solo 1

  //inserto info
  Function(Cats) get popularesSink => _popularesStreamController.sink.add;

  //proceso para escuchar info
  Stream<Cats> get popularesStream => _popularesStreamController.stream;

  void disposeStrams() {
    _popularesStreamController?.close();
  }

  Future<Cats> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final gatos = new Cats.fromJson(decodedData);
    loading = false;
    return gatos;
  }

  Future<Cats> getCats() async {
    if (loading) return Cats();
    loading = true;
    final url = Uri.https(urlCats, '/cat/gif', _queryParameters);

    return await _procesarRespuesta(url);
  }

  Future<Cats> createCats(String query) async {
    final url = Uri.https(urlCats, '/cat/gif/says/$query', _queryParameters);

    return await _procesarRespuesta(url);
  }
}

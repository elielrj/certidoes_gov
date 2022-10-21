import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:xml2json/xml2json.dart';

class DecodificadorDeJson {
  List<dynamic> decodeJSON(http.Response response)  {
    return json.decode(utf8.decode(response.bodyBytes));
  }

  Future<List> decodeXML(http.Response response) async {

    final Xml2Json xml2Json = Xml2Json();
    xml2Json.parse(response.body);
    var jsonString = xml2Json.toParker();

    return await jsonDecode(jsonString);


//    return json.decode(utf8.decode(response.bodyBytes));
  }
}

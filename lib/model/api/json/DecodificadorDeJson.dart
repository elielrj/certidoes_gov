

import 'dart:html';

import 'package:http/http.dart' as http;

import 'dart:convert';




class DecodificadorDeJson{

  List<dynamic> decode(http.Response response){
    return json.decode(utf8.decode(response.bodyBytes));
  }


}
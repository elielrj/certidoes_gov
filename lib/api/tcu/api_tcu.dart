import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiTcu {

  String query;
  Map<String, String> herders;


  ApiTcu({required this.query,required  this.herders});

  Future<http.Response> consultar() async {
    return await http.get(Uri.parse(query),headers: herders );
  }

}

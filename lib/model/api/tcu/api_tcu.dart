import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiTcu {
  String query;

  Future<http.Response> get() async {
    return await http.get(
        Uri.parse('https://certidoes-apf.apps.tcu.gov.br/api/rest/publico/certidoes/00638562000165'),
        headers: {
          "content-type":'application/json;charset=UTF-8',
          "accept":"application/json",
        }
    );
  }

  ApiTcu({required this.query});
}

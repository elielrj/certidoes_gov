import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiCeis {
  String query;
  Map<String, String> herders;

  ApiCeis({required this.query, required this.herders});

  Future<http.Response> get() async {
    return await http.get(Uri.parse(query), headers: herders);
  }
}

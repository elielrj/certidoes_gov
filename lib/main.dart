
import 'package:certidoes_gov/certidoes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text("Certidões")),
          body: const Certidoes())));
}

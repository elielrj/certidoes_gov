
import 'package:certidoes_gov/view/certidoes/certidoes_view.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Ceis"),
      ),
      body: const CertidoesView(),
    ),
  ));
}

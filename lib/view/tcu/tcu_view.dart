import 'package:flutter/material.dart';

import '../../controller/tcu/tcu_controller.dart';
import '../../model/bo/tcu/tcu_certidoes.dart';
import '../../model/bo/tcu/tcu.dart';

class TcuView extends StatefulWidget {
  const TcuView({Key? key, required this.controller}) : super(key: key);

  final TcuController controller;

  @override
  State<TcuView> createState() => _TcuViewState();
}

class _TcuViewState extends State<TcuView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.controller.listaDeCertidoesTcu.isNotEmpty
            ? _resultado()
            : Container(width: 0)
      ],
    );
  }

  Widget _resultado() => Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Resultado da consulta:"),
            if (widget.controller.listaDeCertidoesTcu.isEmpty)
              _nadaConsta()
            else
              for (var item in widget.controller.listaDeCertidoesTcu)
                _restricao(item)
          ],
        ),
      );

  Widget _restricao(Tcu tcu) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (tcu.razaoSocial != null)
              _textWidget(descricao: tcu.razaoSocial!),
            if (tcu.nomeFantasia != null)
              _textWidget(descricao: tcu.nomeFantasia!),
            if (tcu.cnpj != null) _textWidget(descricao: tcu.cnpj!),
            if (tcu.uf != null) _textWidget(descricao: tcu.uf!),
            if (tcu.certidoes != null)
              Column(
                children: [
                  for (int index = 0; index < tcu.certidoes!.length; index++)
                    Column(
                      children: [
                        if (tcu.certidoes![index].emissor != null)
                          _textWidget(
                              descricao: tcu.certidoes![index].emissor!),
                        if (tcu.certidoes![index].tipo != null)
                          _textWidget(descricao: tcu.certidoes![index].tipo!),
                        if (tcu.certidoes![index].dataHoraEmissao != null)
                          _textWidget(
                              descricao: tcu.certidoes![index].dataHoraEmissao!
                                  .toString()),
                        if (tcu.certidoes![index].descricao != null)
                          _textWidget(
                              descricao: tcu.certidoes![index].descricao!),
                        if (tcu.certidoes![index].situacao != null)
                          _textWidget(
                              descricao: tcu.certidoes![index].situacao!),
                        if (tcu.certidoes![index].observacao != null)
                          _textWidget(
                              descricao: tcu.certidoes![index].observacao!),
                      ],
                    )
                ],
              )
          ]);

  Widget _nadaConsta() => const Text(
        "Nada consta",
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      );

  Widget _textWidget({String? titulo, required String descricao}) {
    return Text(
      titulo == null ? descricao : "$titulo$descricao",
      style: const TextStyle(color: Colors.black),
    );
  }

  Future _showDialogWidget(var data) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: Text(
                "Não foi possível acessar o servidor do Ceis: ${data.toString()}"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok")),
            ],
          );
        },
      );
}

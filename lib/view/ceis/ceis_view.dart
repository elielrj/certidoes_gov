
import 'package:flutter/material.dart';

import '../../controller/ceis/ceis_controller.dart';
import '../../model/bo/ceis/ceis.dart';

class CeisView extends StatefulWidget {
  const CeisView({Key? key, required this.controller}) : super(key: key);

  final CeisController controller;

  @override
  State<CeisView> createState() => _CeisViewState();
}

class _CeisViewState extends State<CeisView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.controller.listaDeCertidoesCeis.isNotEmpty
            ? _resultado()
            : Container(width: 0),
      ],
    );
  }

/*
  Future<void> _get() async {
    setState(() => widget.ceisController.isResult = false);

    // widget.ceisController.isResult = false;

    var data = await widget.ceisController.get();

    if (data is List<dynamic>) {
      widget.ceisController.fromListDynamic(data);

      setState(() => widget.ceisController.isResult = true);

      // widget.ceisController.isResult = true;

    } else if (data == 401) {
      showDialogWidget401();
    } else if (data == 403) {
      showDialogWidget403();
    } else if (data == 404) {
      showDialogWidget404();
    } else {
      showDialogWidget(data);
    }
  }
*/
  Widget _resultado() => Container(
        color: Colors.amber,
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Órgão Gestor: Portal da Transparência\n'),
            const Text(
                'Cadastro:  Cadastro Nacional de Empresas Inidôneas e Suspensas\n'),
            Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Resultado da consulta:"),
                    if (widget.controller.listaDeCertidoesCeis.isEmpty)
                      _nadaCosta()
                    else
                      for (var item in widget.controller.listaDeCertidoesCeis)
                        _restricao(item),
                  ],
                )),
          ],
        ),
      );

/*
  Future showDialogWidget(var data) => showDialog(
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

  Future showDialogWidget404() => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro: 404"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text('Não encontrado'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok")),
            ],
          );
        },
      );

  Future showDialogWidget403() => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro: 403"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text('Forbidden'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok")),
            ],
          );
        },
      );

  Future showDialogWidget401() => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro: 401"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text(
                'Acesso não autorizado! Verifique sua chave api de dados!'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok")),
            ],
          );
        },
      );

 */

  Widget _nadaCosta() => const Text(
        " Nada Consta",
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      );

  Widget _restricao(Ceis ceis) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${ceis.tipoSancao!.descricaoResumida}",
            style: const TextStyle(color: Colors.red),
          ),
          Text(
            "${ceis.legislacao!.fundamentacaoLegal}",
            style: const TextStyle(color: Colors.black),
          ),
          Text(
            "${ceis.legislacao!.descricaoFundamentacaoLegal}",
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.justify,
          ),
          Text(
            "Início da sanssão: ${ceis.dataInicioSancao}",
            style: const TextStyle(color: Colors.black),
          ),
          Text(
            "Fim da sanssão: ${ceis.dataFimSancao}",
            style: const TextStyle(color: Colors.black),
          ),
          Text(
            "Órgão sancionador: ${ceis.orgaoSancionador!.nome}",
            style: const TextStyle(color: Colors.black),
          )
        ],
      );
}

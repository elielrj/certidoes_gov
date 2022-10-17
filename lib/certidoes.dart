import 'package:certidoes_gov/api/mascara/formatter_cnpj.dart';
import 'package:certidoes_gov/api/mascara/mask.dart';
import 'package:certidoes_gov/controller/ceis/ceis_controller.dart';
import 'package:flutter/material.dart';

class Certidoes extends StatefulWidget {
  const Certidoes({Key? key}) : super(key: key);

  @override
  State<Certidoes> createState() => _CertidoesState();
}

class _CertidoesState extends State<Certidoes> {
  final Mask cnpj = Mask(formatter: FormatterCnpj());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Capo para digitar CNPJ
              ///
              TextField(
                controller: cnpj.textEditingController,
                maxLength: 18,
                keyboardType: TextInputType.number,
                inputFormatters: [cnpj.formatter.getFormatter()],
              ),

              ///Capo Botão para "consultar" CNPJ
              ///
              TextButton(
                  onPressed: () => cnpj.formatter.isValid()
                      ? _columnResulted()
                      : _mensagemDeeEerroDeValorInvalido(),
                  child: const Text("Consultar")),
            ],
          ),
        ),
      ),
    );
  }

  ///Resultado para CNPJ válido
  ///
  Future<Widget> _columnResulted() async => Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///CADIN
            ///
            _campoCadin(),
            const SizedBox(height: 50),

            ///CEIS
            ///
            await _campoCeis(),
            const SizedBox(height: 50),

            ///CNJ
            ///
            _campoCnj(),
            const SizedBox(height: 50),

            ///SICAF
            ///
            _campoSicaf(),
            const SizedBox(height: 50),

            ///TCU
            ///
            _campoTcu(),
            const SizedBox(height: 50),

            ///PDF
            ///
            _imprimirPdf(),
          ],
        ),
      );

  ///Mensagem de erro para CPF ou CNPJ inválido
  ///
  _mensagemDeeEerroDeValorInvalido() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Erro"),
          titlePadding: const EdgeInsets.all(20),
          titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
          content: const Text("CPF ou Cnpj inválido!"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Ok")),
          ],
        );
      },
    );
  }

  _imprimirPdf() => TextButton(
      onPressed: () async {
        /*
        final conversor = Conversor();

        String ceis = conversor.converterCeis(
            ceis: certidoesController.ceisController!.listaDeCertidoesCeis);
        String cnj = conversor.converterCnj(cnj: []);
        String sicaf = conversor.converterSicaf(sicaf: []);
        String tcu = conversor.converterTcu(
            tcu: certidoesController.tcuController!.listaDeCertidoesTcu);
        String cadin = conversor.converterCadin(cadin: []);
        String rf = conversor.converterRf(rf: []);
        String fgts = conversor.converterFgts(fgts: []);
        String tst = conversor.converterTst(tst: []);

        List<String> listOfCells = [];

        listOfCells.add(ceis);
        listOfCells.add(cnj);
        listOfCells.add(sicaf);
        listOfCells.add(tcu);
        listOfCells.add(cadin);
        listOfCells.add(rf);
        listOfCells.add(fgts);
        listOfCells.add(tst);

        final pdfApi = PdfApi();
        await pdfApi.createTableOfOneColoumn(listOfCells: listOfCells);
        */
      },
      child: const Text("SALVAR"));

  void _limparCampos() {
    //todo: criar limpar campos
  }

  Widget _campoCadin() {
    return Container();
  }

  Future<Widget> _campoCeis() async {
    final controller = CeisController();

    await controller.consulta(
        cnpj: cnpj.formatter.getFormatter().getUnmaskedText());

    return controller.ceisView;
  }

  Widget _campoCnj() {
    return Container();
  }

  Widget _campoSicaf() {
    return Container();
  }

  Widget _campoTcu() {
    return Container();
  }
}

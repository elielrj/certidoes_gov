import 'package:certidoes_gov/api/mascara/formatter_cnpj.dart';
import 'package:certidoes_gov/api/mascara/mask.dart';
import 'package:certidoes_gov/controller/ceis/ceis_controller.dart';
import 'package:certidoes_gov/controller/tcu/tcu_consolidada_controller.dart';
import 'package:certidoes_gov/view/ceis/ceis_view.dart';
import 'package:flutter/material.dart';

class Certidoes extends StatefulWidget {
  const Certidoes({Key? key}) : super(key: key);

  @override
  State<Certidoes> createState() => _CertidoesState();
}

class _CertidoesState extends State<Certidoes> {
  final Mask cnpj = Mask(formatter: FormatterCnpj());

  final controllerCeis = CeisController();
  final controllerTcu = TcuConsolidadaController();


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
                      ? Container(width: 0)
                      : _mensagemDeeEerroDeValorInvalido(),
                  child: const Text("Consultar")),

              ///Exibe compo
              ///
              _columnResulted(),
            ],
          ),
        ),
      ),
    );
  }

  ///Resultado para CNPJ válido
  ///
  Widget _columnResulted()  {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.green,
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
          FutureBuilder(
            future: _campoCeis(),
              builder: (context,snapshot){
              if(snapshot.hasData){
                return Center(
                  child: snapshot.data,
                );
              }else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              }),
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
          FutureBuilder(
              future: _campoTcu(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return Center(
                    child: snapshot.data,
                  );
                }else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
          ),
          const SizedBox(height: 50),

          ///PDF
          ///
          _imprimirPdf(),
        ],
      ),
    );
  }

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

  Widget _campoCnj() {
    return Container();
  }

  Widget _campoSicaf() {
    return Container();
  }

  Future<Widget> _campoCeis() async {

    await controllerCeis.consulta(
        cnpj: cnpj.formatter.getFormatter().getUnmaskedText());

    setState(() {
      controllerCeis.ceisView.listaDeCertidoes;
    });

    return controllerCeis.ceisView;
  }

  Future<Widget> _campoTcu() async {


    await controllerTcu.consultar(
        cnpj: cnpj.formatter.getFormatter().getUnmaskedText());

    setState(() {
      controllerTcu.tcuView.listaDeCertidoes;
    });

    return controllerTcu.tcuView;
  }
}

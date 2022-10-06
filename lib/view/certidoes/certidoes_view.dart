
import 'package:flutter/material.dart';
import '../../controller/certidoes/certidoes_controller.dart';
import '../../model/api/mask/formatter.dart';
import '../../model/api/mask/formatter_cnpj.dart';
import '../../model/api/mask/mask.dart';
import '../../model/api/validador/validor.dart';
import '../../model/bo/pdf/conversor.dart';
import '../../model/bo/pdf/pdf_api.dart';

class CertidoesView extends StatefulWidget {
  const CertidoesView({Key? key}) : super(key: key);

  @override
  State<CertidoesView> createState() => _CertidoesViewState();
}

class _CertidoesViewState extends State<CertidoesView> {
  bool isConsulted = false;
  final Mask mask = Mask(formatter: FormatterCnpj());
  late CertidoesController certidoesController;

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
              _textField(),
              _textButton(),
              isConsulted ? _columnResulted() : Container(width: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField() => TextField(
        controller: mask.textEditingController,
        maxLength: 18,
        keyboardType: TextInputType.number,
        inputFormatters: [mask.formatter.getFormatter()],
      );

  Widget _textButton() => TextButton(
      onPressed: () async => await _acaoDoBotao(), child: const Text("Consultar"));

  Widget _columnResulted() => Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            certidoesController.ceisView(),
            certidoesController.tcuView(),
            const SizedBox(height: 50,),
            _imprimirCertidoes(),
          ],
        ),
      );

 Future<void>  _acaoDoBotao() async {
    setState(() => isConsulted = false);
    if (_validarCpfOuCnpj()) {

      certidoesController = CertidoesController(cnpj: mask.formatter.getFormatter().getUnmaskedText().toString() );

      await _consultarCertidoes();
    } else {
      _mensagemDeeEerroDeValorInvalido();
    }
  }

  _validarCpfOuCnpj() {
    if (Validador.validarCpf(mask.formatter.getFormatter().getUnmaskedText()) ||
        Validador.validarCnpj(
            mask.formatter.getFormatter().getUnmaskedText())) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _consultarCertidoes() async {
    await certidoesController.consultar(
        cnpj: mask.formatter.getFormatter().getUnmaskedText());
    setState(() => isConsulted = true);
  }

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

  Widget _imprimirCertidoes() => TextButton(
      onPressed: () async {
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
      },
      child: const Text("SALVAR"));
}

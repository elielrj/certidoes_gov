/*
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../ceis/ceis.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class CriadorDePdf {
  Future<void> criarPdf(List<Ceis> _listaDeCertidoesCeis) async {
    var myTheme = pw.ThemeData.withFont(
      base: Font.ttf(await rootBundle.load("assets/OpenSans-Regular.ttf")),
      bold: Font.ttf(await rootBundle.load("assets/OpenSans-Bold.ttf")),
      italic: Font.ttf(await rootBundle.load("assets/OpenSans-Italic.ttf")),
      boldItalic:
          Font.ttf(await rootBundle.load("assets/OpenSans-BoldItalic.ttf")),
    );

    final pdf = pw.Document(theme: myTheme);

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Center(
                child: pw.Column(children: [
              for (var item in _listaDeCertidoesCeis)
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "${item.tipoSancao!.descricaoResumida}",
                      style: const pw.TextStyle(color: pw.GridPaper.lineColor),
                    ),
                    pw.Text(
                      "${item.legislacao!.fundamentacaoLegal}",
                      style: const pw.TextStyle(color: pw.GridPaper.lineColor),
                    ),
                    pw.Text(
                      "${item.legislacao!.descricaoFundamentacaoLegal}",
                      style: const pw.TextStyle(color: pw.GridPaper.lineColor),
                      textAlign: pw.TextAlign.justify,
                    ),
                    pw.Text(
                      "Início da sanssão: ${item.dataInicioSancao}",
                      style: const pw.TextStyle(color: pw.GridPaper.lineColor),
                    ),
                    pw.Text(
                      "Fim da sanssão: ${item.dataFimSancao}",
                      style: const pw.TextStyle(color: pw.GridPaper.lineColor),
                    ),
                    pw.Text(
                      "Órgão sancionador: ${item.orgaoSancionador!.nome}",
                      style: const pw.TextStyle(color: pw.GridPaper.lineColor),
                    )
                  ],
                )
            ]))));


    File('HelloWorld.pdf').writeAsBytes(await pdf.save());
// Dispose the document.
    pdf.dispose();


    //var arquivo = File("exemple.pdf");

    //final List<int> bytes = await pdf.save();

     //arquivo.writeAsBytesSync(bytes);
  }
}
*/
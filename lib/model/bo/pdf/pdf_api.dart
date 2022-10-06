import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:convert';
import 'dart:html';

class PdfApi {
  ///https://www.syncfusion.com/kb/11973/how-to-create-a-pdf-file-in-flutter-web-platform
  ///https://help.syncfusion.com/flutter/pdf/getting-started#creating-a-pdf-document-with-table

  /// Create a new PDF document.
  PdfDocument createPdfDocument() => PdfDocument();

  /// Add a PDF page and draw text.
  Future<void> createTextPdf(String text,
      {required PdfDocument document}) async {
    document.pages.add().graphics.drawString(
        text, PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 0, 150, 20));

    // Save the document.
    List<int> bytes = await _saveDocument(document: document);

    // Dispose the document.
    _disposeDocument(document: document);

    downloadPDF(bytes: bytes);
  }

  /// Create table with columns and rows
  Future<void> createTable(
      List<String> listTextNameColumn,
      List<String> listTextLines) async {
    //Creates a new PDF document
    PdfDocument document = createPdfDocument();

    //Adds page settings
    document.pageSettings.orientation = PdfPageOrientation.portrait;
    document.pageSettings.margins.all = 50;

    //Create a PdfGrid
    PdfGrid grid = PdfGrid();

    //Add the columns to the grid
    grid.columns.add(count: listTextNameColumn.length);

    //Add header to the grid
    grid.headers.add(1);

    //Add the rows to the grid
    PdfGridRow header = grid.headers[0];

    int index = 0;
    for (var item in listTextNameColumn) {
      header.cells[index].value = item;
    }

    //Add rows to grid

    index = 0;
    for (var item in listTextLines) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = "${listTextNameColumn[index]}\n$item";
      index++;
    }

    //Draw grid to the page of the PDF document
    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    //Saves the document
    List<int> bytes = await _saveDocument(document: document);

    //Dispose the document
    _disposeDocument(document: document);

    //Download
    downloadPDF(bytes: bytes);
  }

  Future<void> createTableOfOneColoumn(
      {required List<String> listOfCells}) async {
    //Creates a new PDF document
    PdfDocument document = createPdfDocument();

    //Adds page settings
    document.pageSettings.orientation = PdfPageOrientation.portrait;
    document.pageSettings.margins.all = 50;

    //Create a PdfGrid
    PdfGrid grid = PdfGrid();

    //Add the columns to the grid
    grid.columns.add(count: 1);

    //Add rows to grid

    int index = 0;
    for (var item in listOfCells) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = item;
      index++;
    }

    //Draw grid to the page of the PDF document
    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    //Saves the document
    List<int> bytes = await _saveDocument(document: document);

    //Dispose the document
    _disposeDocument(document: document);

    //Download
    downloadPDF(bytes: bytes);
  }

  /// Add a PDF page
  Future<void> addPage({required PdfDocument document}) async =>
      document.pages.add();

  ///Save the document
  Future<List<int>> _saveDocument({required PdfDocument document}) async =>
      await document.save();

  ///Dispose the document
  _disposeDocument({required PdfDocument document}) => document.dispose();

  downloadPDF({required List<int> bytes}) {
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "ouput.pdf")
      ..click();
  }
}

import 'dart:convert';

import 'package:certidoes_gov/api/json/DecodificadorDeJson.dart';
import 'package:certidoes_gov/api/tcu/api_tcu.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

///https://portal.tcu.gov.br/webservices-tcu/
/// GET https://certidoes-apf.apps.tcu.gov.br/api/rest/publico/tipos-certidoes
///     https://certidoes-apf.apps.tcu.gov.br/api/rest/publico/certidoes/00638562000165?seEmitirPDF=true
class TcuDAO {
  static final ORGAO_EMISSOR = "TCU";
  static final SIGLA = "Inidônios";
  static final DESCRICAO = "Licitantes Inidônios";
  static final URL =
      //"https://certidoes-apf.apps.tcu.gov.br/api/rest/publico/tipos-certidoes";
      //"certidoes-apf.apps.tcu.gov.br/api/rest/publico/tipos-certidoes";
      'https://certidoes-apf.apps.tcu.gov.br/api/rest/publico/certidoes';

  String? _cnpj;
  bool seEmitirPDF = false;
  DateTime? data;

  Future<List<dynamic>> consultar({required String cnpj}) async {
    ///Atribuir CNPJ
    ///
    _cnpj = cnpj;

    ///API para acessar portal do TCU
    ///
    final apiTcu = ApiTcu(
      query: _criarQuery(),
      herders: _criarHerder(),
    );

    ///Consulta API
    ///
    http.Response data = await apiTcu.consultar();

    /*
      if (data.statusCode == 200) {
        print(data.body.toString());

        return await _decodificar(data);
      } else {
        print("Erro ao tentar buscar certião no TCU: Servidor!");
        return [];
      }

    */

    print('objeto: ${data.body}');

    ///Decodifica em um List<dynamic>
    ///antes de retornar o resultado
    ///
    return await _decodificar(data);
  }

  String _criarQuery() {
    return "$URL/$_cnpj?seEmitirPDF=$seEmitirPDF";
  }

  Map<String, String> _criarHerder() {
    return {'orgaoEmissor': 'TCU'};
  }

  ///Recebe um http.Response e decodifica em um List<dynamic>
  ///
  Future<List> _decodificar(http.Response response) async {
    final decodificadorDeJson = DecodificadorDeJson();

    return await decodificadorDeJson.decodeXML(response);
  }
}

import 'dart:convert';

import 'package:certidoes_gov/api/json/DecodificadorDeJson.dart';
import 'package:certidoes_gov/api/tcu/api_tcu.dart';
import 'package:http/http.dart' as http;

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
      'certidoes-apf.apps.tcu.gov.br/api/rest/publico/certidoes';

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

    ///Decodifica em um List<dynamic>
    ///antes de retornar o resultado
    ///
    return _decodificar(data);
  }

  String _criarQuery() {
    //return "$URL/$_cnpj?seEmitirPDF=$seEmitirPDF";
    return "$URL/$_cnpj";
  }

  Map<String, String> _criarHerder() {
    return {
      "Accept":
          "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
      "Accept-Encoding": "gzip, deflate, br",
      "Accept-Language": "pt-BR",
      "Connection": "keep-alive",
      "Host": "certidoes-apf.apps.tcu.gov.br",
      "Proxy-Authorization": "Basic c2d0ZWxpZWwtM2NpYTYzYmk6OTUyNDk1MjQ=",
      "Sec-Fetch-Dest": "document",
      "Sec-Fetch-Mode": "navigate",
      "Sec-Fetch-Site": "none",
      "Sec-Fetch-User": "?1",
      "Upgrade-Insecure-Requests": "1",
      "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:105.0) Gecko/20100101 Firefox/105.0",
    };
  }

  ///Recebe um http.Response e decodifica em um List<dynamic>
  ///
  List<dynamic> _decodificar(http.Response response) {
    final decodificadorDeJson = DecodificadorDeJson();

    return decodificadorDeJson.decode(response);
  }
}

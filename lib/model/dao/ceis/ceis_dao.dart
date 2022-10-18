import 'package:http/http.dart' as http;

import 'dart:convert';

import '../../../api/ceis/api_ceis.dart';
import '../../../api/json/DecodificadorDeJson.dart';
import '../../../controller/ceis/fonte_sancao_controller.dart';
import '../../../controller/ceis/legislacao_controller.dart';
import '../../../controller/ceis/orgao_sancionador_controller.dart';
import '../../../controller/ceis/pessoa_controller.dart';
import '../../../controller/ceis/sancionado_controller.dart';
import '../../../controller/ceis/tipo_sancao_controller.dart';
import '../../bo/ceis/ceis.dart';
import 'chave.dart';

class CeisDAO {
  final ORGAO_EMISSOR = "PORTAL DA TRANSPARÊNCIA";
  final SIGLA = "CEIS";
  final DESCRICAO = "Cadastro Nacional de Empresas Inidônias e Suspensas";
  final URL = "https://api.portaldatransparencia.gov.br/api-de-dados/ceis";

  String chaveApiDados = Chave.CHAVE;
  String? codigoSancionado;
  String? dataFinalSancao;
  String? dataInicialSancao;
  String? nomeSancionado;
  String? orgaoSancionador;
  int pagina = 1;

  ///Consulta certidão do CEIS
  ///
  Future<List<dynamic>> consultar({required String cnpj}) async {
    ///Atribui CNPJ
    ///
    codigoSancionado = cnpj;

    ///API criada para acessar via get no Portal da Transparência
    ///
    final ApiCeis apiCeis = ApiCeis(
      query: _criarQuery(),
      herders: _criarHerders(),
    );

    ///Consulta a API
    ///
    http.Response data = await apiCeis.consulta();

/*
    if (data.statusCode == 200) {

    } else if (data.statusCode == 401) {
      //CODE_Unauthorized
      print("Acesso não autorizado");
      return [];
    } else if (data.statusCode == 403) {
      //CODE_Forbidden
      print("Forbiden");
      return [];
    } else if (data.statusCode == 404) {
      //CODE_Not_Found
      print("Não encontrado");
      return [];
    } else {
      print("Erro desconhecido!");
      return [];
    }*/

    return _decodificar(data);
  }

  ///Cria Query de consulta
  ///
  String _criarQuery() {
    return "$URL?codigoSancionado=$codigoSancionado&pagina=$pagina";
  }

  ///Cria Herders
  ///
  Map<String, String> _criarHerders() {
    return {'chave-api-dados': chaveApiDados};
  }

  ///Recebe um http.Response e decodifica em um Lis<dynamic>
  ///
  List<dynamic> _decodificar(http.Response response) {
    final decodificadorDeJson = DecodificadorDeJson();

    return  decodificadorDeJson.decode(response);
  }
}

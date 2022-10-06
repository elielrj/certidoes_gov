
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../../../controller/ceis/fonte_sancao_controller.dart';
import '../../../controller/ceis/legislacao_controller.dart';
import '../../../controller/ceis/orgao_sancionador_controller.dart';
import '../../../controller/ceis/pessoa_controller.dart';
import '../../../controller/ceis/sancionado_controller.dart';
import '../../../controller/ceis/tipo_sancao_controller.dart';
import '../../api/ceis/api_ceis.dart';
import '../../api/json/DecodificadorDeJson.dart';
import '../../bo/ceis/ceis.dart';
import 'chave.dart';

class CeisDAO {
   final ORGAO_EMISSOR = "PORTAL DA TRANSPARÊNCIA";
   final SIGLA = "CEIS";
   final DESCRICAO =
      "Cadastro Nacional de Empresas Inidônias e Suspensas";
   final URL =
      "https://api.portaldatransparencia.gov.br/api-de-dados/ceis";

  String chaveApiDados = Chave.CHAVE;
  String codigoSancionado;
  String? dataFinalSancao;
  String? dataInicialSancao;
  String? nomeSancionado;
  String? orgaoSancionador;
  int pagina;

  CeisDAO(
      {required this.codigoSancionado, //2
      this.dataFinalSancao, //3
      this.dataInicialSancao, //4
      this.nomeSancionado, //5
      this.orgaoSancionador, //6
      this.pagina = 1});

  Future<List<Ceis>> get() async {
    try {
      final apiCeis = ApiCeis(query: _criarQuery(), herders: _criarHerders());

      http.Response data = await apiCeis.get();

      if (data.statusCode == 200) {
        return _decodificar(data);
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
      }
    } catch (error) {
      print("Erro ao tentar buscar certião no Ceis. ${error.toString()}");
      return [];
    }
  }

  String _criarQuery() {
    return "$URL?codigoSancionado=$codigoSancionado&pagina=$pagina";
  }

  Map<String, String> _criarHerders() {
    return {'chave-api-dados': chaveApiDados};
  }

  List<Ceis> _decodificar(http.Response response) {
    final decodificadorDeJson = DecodificadorDeJson();

    var data = decodificadorDeJson.decode(response);

    return _fromListDynamic(data);
  }

  List<Ceis> _fromListDynamic(List<dynamic> listaDinamica) {
    List<Ceis> listaDeCertidoes = [];

    for (var item in listaDinamica) {
      var mapFromItem = item as Map<String, dynamic>;

      var tcu = _fromMap(mapFromItem);

      listaDeCertidoes.add(tcu);
    }

    return listaDeCertidoes;
  }

  Ceis _fromMap(Map<String, dynamic> map) {
    final fonteSancaoController = FonteSancaoController();
    final fonteSancao = fonteSancaoController.fromMap(map['fonteSancao']);

    final tipoSancaoController = TipoSancaoController();
    final tipoSancao = tipoSancaoController.fromMap(map['tipoSancao']);

    final pessoaController = PessoaController();
    final pessoa = pessoaController.fromMap(map['pessoa']);

    final legislacaoController = LegislacaoController();
    final legislacao = legislacaoController.fromMap(map['legislacao']);

    final sancionadoController = SancionadoController();
    final sancionado = sancionadoController.fromMap(map['sancionado']);

    final orgaoSancionadorController = OrgaoSancionadorController();
    final OrgaoSancionador =
        orgaoSancionadorController.fromMap(map['orgaoSancionador']);

    return Ceis(
      abrangenciaDefinidaDecisaoJudicial:
          map['abrangenciaDefinidaDecisaoJudicial'],
      dataFimSancao: map['dataFimSancao'],
      dataInicioSancao: map['dataInicioSancao'],
      dataOrigemInformacao: map['dataOrigemInformacao'],
      dataPublicacaoSancao: map['dataPublicacaoSancao'],
      dataReferencia: map['dataReferencia'],
      dataTransitadoJulgado: map['dataTransitadoJulgado'],
      detalhamentoPublicacao: map['detalhamentoPublicacao'],
      id: map['id'],
      informacoesAdicionaisDoOrgaoSancionador:
          map['informacoesAdicionaisDoOrgaoSancionador'],
      linkPublicacao: map['linkPublicacao'],
      numeroProcesso: map['numeroProcesso'],
      textoPublicacao: map['textoPublicacao'],
      fonteSancao: fonteSancao,
      legislacao: legislacao,
      orgaoSancionador: OrgaoSancionador,
      pessoa: pessoa,
      sancionado: sancionado,
      tipoSancao: tipoSancao,
    );
  }
}

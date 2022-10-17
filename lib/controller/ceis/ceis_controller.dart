import 'package:certidoes_gov/controller/ceis/legislacao_controller.dart';
import 'package:certidoes_gov/controller/ceis/pessoa_controller.dart';
import 'package:certidoes_gov/controller/ceis/sancionado_controller.dart';
import 'package:certidoes_gov/controller/ceis/tipo_sancao_controller.dart';
import 'package:certidoes_gov/view/ceis/ceis_view.dart';

import '../../model/bo/ceis/ceis.dart';
import '../../model/dao/ceis/ceis_dao.dart';
import 'fonte_sancao_controller.dart';
import 'orgao_sancionador_controller.dart';

import 'dart:async';

class CeisController {
  final Ceis ceis = Ceis();

  late final CeisView ceisView;

  ///Consulta de certidão CEIS
  ///
  Future<void> consulta({required String cnpj}) async {
    final CeisDAO ceisDAO = CeisDAO();

    List<dynamic> listaDinamica = await ceisDAO.consultar(cnpj: cnpj);

    List<Ceis> listaDeCertidoes = _fromListDynamic(listaDinamica);

    ceisView = CeisView(listaDeCertidoes: listaDeCertidoes);
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

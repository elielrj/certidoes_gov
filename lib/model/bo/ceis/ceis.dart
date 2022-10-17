import 'pessoa.dart';

import 'fonte_sancao.dart';
import 'legislacao.dart';
import 'orgao_sancionador.dart';
import 'sancionado.dart';
import 'tipo_sancao.dart';

class Ceis {



  String? abrangenciaDefinidaDecisaoJudicial;
  String? dataFimSancao;
  String? dataInicioSancao;
  String? dataOrigemInformacao;
  String? dataPublicacaoSancao;
  String? dataReferencia;
  String? dataTransitadoJulgado;
  String? detalhamentoPublicacao;
  int? id;
  String? informacoesAdicionaisDoOrgaoSancionador;
  String? linkPublicacao;
  String? numeroProcesso;
  String? textoPublicacao;

  FonteSancao? fonteSancao;
  Legislacao? legislacao;
  OrgaoSancionador? orgaoSancionador;
  Pessoa? pessoa;
  Sancionado? sancionado;
  TipoSancao? tipoSancao;

  Ceis({

      this.abrangenciaDefinidaDecisaoJudicial,
      this.dataFimSancao,
      this.dataInicioSancao,
      this.dataOrigemInformacao,
      this.dataPublicacaoSancao,
      this.dataReferencia,
      this.dataTransitadoJulgado,
      this.detalhamentoPublicacao,
      this.id,
      this.informacoesAdicionaisDoOrgaoSancionador,
      this.linkPublicacao,
      this.numeroProcesso,
      this.textoPublicacao,
      this.fonteSancao,
      this.legislacao,
      this.orgaoSancionador,
      this.pessoa,
      this.sancionado,
      this.tipoSancao});
}

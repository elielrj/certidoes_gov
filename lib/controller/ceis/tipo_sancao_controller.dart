import '../../model/bo/ceis/tipo_sancao.dart';

class TipoSancaoController {
  TipoSancao fromMap(Map<String, dynamic> map) {
    return TipoSancao(
      descricaoPortal: map['descricaoPortal'],
      descricaoResumida: map['descricaoResumida'],
    );
  }
}

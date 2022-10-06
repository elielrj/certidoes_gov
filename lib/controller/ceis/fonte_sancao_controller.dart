import '../../model/bo/ceis/fonte_sancao.dart';

class FonteSancaoController {
  FonteSancao fromMap(Map<String, dynamic> map) {
    return FonteSancao(
      enderecoContato: map['enderecoContato'],
      nomeExibicao: map['nomeExibicao'],
      telefoneContato: map['telefoneContato'],
    );
  }
}

import '../../model/bo/ceis/pessoa.dart';

class PessoaController {
  Pessoa fromMap(Map<String, dynamic> map) {
    return Pessoa(
      cnpjFormatado: map['cnpjFormatado'],
      cpfFormatado: map['cpfFormatado'],
      id: map['id'],
      nome: map['nome'],
      nomeFantasiaReceita: map['nomeFantasiaReceita'],
      numeroInscricaoSocial: map['numeroInscricaoSocial'],
      razaoSocialReceita: map['razaoSocialReceita'],
      tipo: map['tipo'],
    );
  }
}

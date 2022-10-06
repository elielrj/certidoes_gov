import '../../bo/tcu/tcu_certidoes.dart';

class TcuCertidoesDAO {
  List<TcuCertidoes> fromMap(Map<String, dynamic> map) {
    List<TcuCertidoes> listaDeCertidoes = [];

    for (int index = 0; index < 4; index++) {
      listaDeCertidoes.add(_fromMap(map));
    }
    return listaDeCertidoes;
  }

  TcuCertidoes _fromMap(Map<String, dynamic> map) {
    return TcuCertidoes(
      emissor: map['emissor'],
      tipo: map['tipo'],
      dataHoraEmissao: map['dataHoraEmissao'],
      descricao: map['descricao'],
      situacao: map['situacao'],
      observacao: map['observacao'],
    );
  }
}
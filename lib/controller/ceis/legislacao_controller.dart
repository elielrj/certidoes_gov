


import '../../model/bo/ceis/legislacao.dart';

class LegislacaoController{
  Legislacao fromMap(Map<String,dynamic> map){
    return Legislacao(
      descricaoFundamentacaoLegal: map['descricaoFundamentacaoLegal'],
      fundamentacaoLegal: map['fundamentacaoLegal'],
    );
  }
}

import '../../model/bo/ceis/orgao_sancionador.dart';

class OrgaoSancionadorController{
  OrgaoSancionador fromMap(Map<String,dynamic> map){
    return OrgaoSancionador(
      nome: map['nome'],
      poder: map['poder'],
      siglaUf: map['siglaUf'],
    );
  }

}
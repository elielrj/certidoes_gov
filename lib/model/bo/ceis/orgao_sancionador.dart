
class OrgaoSancionador{
  String? nome;
  String? poder;
  String? siglaUf;

  OrgaoSancionador({this.nome, this.poder, this.siglaUf});

  static OrgaoSancionador fromMap(Map<String,dynamic> map){
    return OrgaoSancionador(
      nome: map['nome'],
      poder: map['poder'],
      siglaUf: map['siglaUf'],
    );
  }

  @override
  String toString() {
    return "$nome, $poder - $siglaUf";
  }
}
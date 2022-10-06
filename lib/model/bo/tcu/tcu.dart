import 'tcu_certidoes.dart';

class Tcu {
  String? razaoSocial;
  String? nomeFantasia;
  String? cnpj;
  String? uf;

  List<TcuCertidoes>? certidoes;

  Tcu(
      {this.razaoSocial,
      this.nomeFantasia,
      this.cnpj,
      this.uf,
      this.certidoes});
}



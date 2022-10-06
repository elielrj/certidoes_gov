import 'dart:convert';


import 'package:certidoes_gov/model/dao/tcu/tcu_certiddoes_dao.dart';
import 'package:http/http.dart' as http;
import '../../api/json/DecodificadorDeJson.dart';
import '../../api/tcu/api_tcu.dart';
import '../../bo/tcu/tcu_certidoes.dart';
import '../../bo/tcu/tcu.dart';
 ///https://portal.tcu.gov.br/webservices-tcu/
/// GET https://certidoes-apf.apps.tcu.gov.br/api/rest/publico/tipos-certidoes
///     https://certidoes-apf.apps.tcu.gov.br/api/rest/publico/certidoes/00638562000165?seEmitirPDF=true
class TcuDAO {
  static final ORGAO_EMISSOR = "TCU";
  static   final SIGLA = "Inidônios";
  static   final DESCRICAO = "Licitantes Inidônios";
  static final URL =
      //"https://certidoes-apf.apps.tcu.gov.br/api/rest/publico/tipos-certidoes";
      "certidoes-apf.apps.tcu.gov.br/api/rest/publico/tipos-certidoes";

  String cnpj;
  bool seEmitirPDF;
  DateTime? data;

  TcuDAO({required this.cnpj, this.seEmitirPDF = true});

  Future<List<Tcu>> get() async {
    try {
      final api = ApiTcu(query: _criarQuery());

      http.Response data = await api.get();


      if (data.statusCode == 200) {

        print(data.body.toString());

        return await _decodificar(data);
      } else {
        print("Erro ao tentar buscar certião no TCU: Servidor!");
        return [];
      }
    } catch (error) {

      print("Erro ao tentar buscar certião no TCU. ${error.toString()}");
      return [];
    }
  }
String _criarQuery2(){
    return "$URL/$cnpj?seEmitirPDF=$seEmitirPDF";
}


  String _criarQuery() {
    return "$URL/$cnpj?seEmitirPDF=$seEmitirPDF";
  }

  List<Tcu> _decodificar(http.Response response) {



    final decodificadorDeJson = DecodificadorDeJson();



    var data =  decodificadorDeJson.decode(response);
    //var data =  json.decode((response.body));

    //final teste = json.decode((await data));

    return _fromListDynamic( data);
  }

  List<Tcu> _fromListDynamic(List<dynamic> listaDinamica) {
    List<Tcu> listaDeCertidoes = [];

    for (var item in listaDinamica) {
      var mapFromItem = item as Map<String, dynamic>;

      var tcu = _fromMap(mapFromItem);

      listaDeCertidoes.add(tcu);
    }

    return listaDeCertidoes;
  }

  Tcu _fromMap(Map<String, dynamic> map) {
    TcuCertidoesDAO tcuCertidoesDAO = TcuCertidoesDAO();
    List<TcuCertidoes> listaDeCertidoes =
        tcuCertidoesDAO.fromMap(map['certidoes']);

    return Tcu(
      razaoSocial: map['razaoSocial'],
      nomeFantasia: map['nomeFantasia'],
      cnpj: map['cnpj'],
      uf: map['uf'],
      certidoes: listaDeCertidoes,
    );
  }
}

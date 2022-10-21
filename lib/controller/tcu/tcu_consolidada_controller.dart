import 'package:certidoes_gov/model/bo/tcu/tcu_certidoes.dart';
import 'package:certidoes_gov/model/dao/tcu/tcu_certiddoes_dao.dart';
import 'package:certidoes_gov/view/tcu/tcu_view.dart';
import 'package:flutter/cupertino.dart';

import '../../model/bo/tcu/tcu.dart';
import '../../model/dao/tcu/tcu_dao.dart';

class TcuConsolidadaController extends ChangeNotifier{
//  final Tcu tcu = Tcu();

  late TcuView tcuView ;

  ///Consulta de Certidão TCU
  ///
  Future<void> consultar({required String cnpj}) async {
    try {
      final tcuDAO = TcuDAO();

      List<dynamic> listaDinamica = await tcuDAO.consultar(cnpj: cnpj);

      List<Tcu> listaDeCertidoes = _fromListDynamic(listaDinamica);

      tcuView = TcuView(listaDeCertidoes: listaDeCertidoes);
      notifyListeners();

    }catch(erro){
      print('erro: ${erro.toString()}');
    }
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

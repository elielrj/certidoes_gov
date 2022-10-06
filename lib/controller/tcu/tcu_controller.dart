
import '../../model/api/mask/formatter.dart';
import '../../model/bo/tcu/tcu.dart';
import '../../model/dao/tcu/tcu_dao.dart';

class TcuController {
  String cnpj;
  List<Tcu> listaDeCertidoesTcu = [];

  TcuController({required this.cnpj});

  Future<void> get() async {
    final tcuDAO = TcuDAO(cnpj: cnpj);

    listaDeCertidoesTcu = await tcuDAO.get();


  }


}



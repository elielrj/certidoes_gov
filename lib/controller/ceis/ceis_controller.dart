import '../../model/bo/ceis/ceis.dart';
import '../../model/dao/ceis/ceis_dao.dart';
import 'fonte_sancao_controller.dart';
import 'orgao_sancionador_controller.dart';

import 'dart:async';

class CeisController {
  String cnpj;
  List<Ceis> listaDeCertidoesCeis = [];

  CeisController({required this.cnpj});

  Future<void> get() async {
    final ceisDAO =
        CeisDAO(codigoSancionado: cnpj);

    listaDeCertidoesCeis = await ceisDAO.get();
  }
}

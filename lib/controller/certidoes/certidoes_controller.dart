
import '../../model/api/mask/formatter.dart';
import '../../view/ceis/ceis_view.dart';
import '../../view/tcu/tcu_view.dart';
import '../ceis/ceis_controller.dart';
import '../tcu/tcu_controller.dart';

class CertidoesController {

  //String cnpj;
  CeisController? ceisController;
  TcuController? tcuController;


  CertidoesController({required String cnpj}){
    ceisController = CeisController(cnpj: cnpj);
    tcuController = TcuController(cnpj: cnpj);
  }

  Future<void> consultar({required String cnpj}) async {

    await ceisController!.get();
    await tcuController!.get();
  }

  CeisView ceisView() => CeisView(controller: ceisController!);

  TcuView tcuView() => TcuView(controller: tcuController!);
}

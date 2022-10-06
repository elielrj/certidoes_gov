
import '../cadin/cadin.dart';
import '../ceis/ceis.dart';
import '../cnj/cnj.dart';
import '../fgts/fgts.dart';
import '../rf/rf.dart';
import '../sicaf/sicaf.dart';
import '../tcu/tcu.dart';
import '../tst/tst.dart';

class Conversor {


  String converterCeis({required List<Ceis> ceis}) {

    String value = "CEIS\n";

    for (Ceis item in ceis) {

      value += "Tipo de Sanção: ${item.tipoSancao!.descricaoResumida!}\n";
      value += "Fundamentação legal: ${item.legislacao!.fundamentacaoLegal!}\n";
      value += "Descrição da fundamentação legal: ${item.legislacao!.descricaoFundamentacaoLegal!}\n";
      value += "Início da sanssão: ${item.dataInicioSancao!}\n";
      value += "Fim da sanssão: ${item.dataFimSancao!}\n";
      value += "Órgão sancionador: ${item.orgaoSancionador!.nome}\n\n";

    }

    return value;

  }

  String converterCnj({required List<Cnj> cnj}) {

    String value = "CNJ\n";

    for (Cnj item in cnj) {

    }

    return value;

  }

  String converterSicaf({required List<Sicaf> sicaf}) {

    String value = "SICAF\n";

    for (Sicaf item in sicaf) {

    }

    return value;

  }

  String converterTcu({required List<Tcu> tcu}) {

    String value = "TCU\n";

    for (Tcu item in tcu) {

    }

    return value;

  }

  String converterCadin({required List<Cadin> cadin}) {

    String value = "CADIN\n";

    for (Cadin item in cadin) {

    }

    return value;

  }

  String converterRf({required List<Rf> rf}) {

  String value = "RECEITA FEDERAL\n";

  for (Rf item in rf) {

  }

  return value;

  }

  String converterFgts({required List<Fgts> fgts}) {

  String value = "FGTS\n";

  for (Fgts item in fgts) {

  }

  return value;

  }

  String converterTst({required List<Tst> tst}) {

  String value = "TST\n";

  for (Tst item in tst) {

  }

  return value;

  }





}

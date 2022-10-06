import '../../model/bo/ceis/sancionado.dart';

class SancionadoController {
  Sancionado fromMap(Map<String, dynamic> map) {
    return Sancionado(
      codigoFormatado: map['codigoFormatado'],
      nome: map['nome'],
    );
  }
}

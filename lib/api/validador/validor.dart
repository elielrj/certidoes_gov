

import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

class Validador{

  static bool validarCpf(String cpf){
    return CPFValidator.isValid(cpf);
  }

  static bool validarCnpj(String cnpj){
    return CNPJValidator.isValid(cnpj);
  }
}
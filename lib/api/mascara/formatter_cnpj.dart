import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../api/mascara/formatter.dart';
import '../validador/validor.dart';

class FormatterCnpj implements Formatter {
  final MaskTextInputFormatter formatter =
      MaskTextInputFormatter(mask: "##.###.###/####-##");

  final String hint = "00.000.000/0000-00";

  final TextInputType textInputType = TextInputType.number;

  FormFieldValidator<String>? validator = (value) {
    //todo
  };

  @override
  MaskTextInputFormatter getFormatter() {
    return formatter;
  }

  @override
  bool isValid() {
    if (Validador.validarCnpj(getFormatter().getUnmaskedText())) {
      return true;
    } else if (Validador.validarCpf(getFormatter().getUnmaskedText())) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String getHint() {
    return hint;
  }

  @override
  TextInputType getTextInputType() {
    return textInputType;
  }
}

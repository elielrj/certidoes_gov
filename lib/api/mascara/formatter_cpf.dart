import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'formatter.dart';

class FormatterCpf implements Formatter {

  final MaskTextInputFormatter formatter = MaskTextInputFormatter(mask: "###.###.###-##");

  final String hint = "000.000.000-00";

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
    // TODO: implement getHint
    throw UnimplementedError();
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

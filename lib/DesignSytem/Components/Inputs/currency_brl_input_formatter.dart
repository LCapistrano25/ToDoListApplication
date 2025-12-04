import 'package:flutter/services.dart';

class CurrencyBRLInputFormatter extends TextInputFormatter {
  static String formatFromText(String input) {
    final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return '';
    final cents = int.parse(digits);
    final intPart = cents ~/ 100;
    final decPart = cents % 100;
    final intStr = _groupThousands(intPart.toString());
    final decStr = decPart.toString().padLeft(2, '0');
    return 'R\$ ' + intStr + ',' + decStr;
  }

  static String normalizeToDecimal(String input) {
    final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return '';
    final cents = int.parse(digits);
    final intPart = cents ~/ 100;
    final decPart = cents % 100;
    return intPart.toString() + '.' + decPart.toString().padLeft(2, '0');
  }

  static String _groupThousands(String s) {
    final buffer = StringBuffer();
    int count = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      buffer.write(s[i]);
      count++;
      if (count == 3 && i != 0) {
        buffer.write('.');
        count = 0;
      }
    }
    return String.fromCharCodes(buffer.toString().runes.toList().reversed);
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final formatted = formatFromText(newValue.text);
    return TextEditingValue(text: formatted, selection: TextSelection.collapsed(offset: formatted.length));
  }
}

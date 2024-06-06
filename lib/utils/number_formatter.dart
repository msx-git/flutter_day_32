import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String newString = newValue.text
        .replaceAll(RegExp(r'\D+'), ''); // Remove non-numeric characters
    if (newString.length <= 2) {
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(offset: newString.length),
      );
    } else if (newString.length <= 5) {
      return TextEditingValue(
        text: '${newString.substring(0, 2)} ${newString.substring(2)}',
        selection: TextSelection.collapsed(offset: newString.length + 1),
      );
    } else if (newString.length <= 7) {
      return TextEditingValue(
        text:
            '${newString.substring(0, 2)} ${newString.substring(2, 5)} ${newString.substring(5)}',
        selection: TextSelection.collapsed(offset: newString.length + 2),
      );
    } else {
      return TextEditingValue(
        text:
            '${newString.substring(0, 2)} ${newString.substring(2, 5)} ${newString.substring(5, 7)} ${newString.substring(7)}',
        selection: TextSelection.collapsed(offset: newString.length + 3),
      );
    }
  }
}

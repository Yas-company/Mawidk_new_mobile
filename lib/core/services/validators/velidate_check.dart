import 'package:easy_localization/easy_localization.dart';

class ValidateCheck {
  static String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final kEmailValid = RegExp(pattern);
    bool isValid = kEmailValid.hasMatch(value.toString());
    if (value!.isEmpty) {
      return '\u26A0 ${tr('EMAIL_MUST_BE_REQUIRED')}';
    } else if (isValid == false) {
      return '\u26A0 ${tr("enter_valid_email_address")}';
    }
    return null;
  }

  static String? validateEmptyText(String? value, String? message) {
    if (value == null || value.isEmpty) {
      return tr(
        message ?? 'This field is required',
      );
    }
    return null;
  }

  static String? validatePassword(String? value, String? message) {
    if (value == null || value.isEmpty) {
      return tr(message ?? 'This field is required');
    } else if (value.length < 7) {
      return tr('minimum_password_is_8_character');
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return tr('confirm_password_must_be_required');
    } else if (value != password) {
      return tr('confirm_password_not_matched');
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return tr('addYourPhoneNumber');
    } else if (value.length < 5) {
      return tr('addValidPhoneNumber');
    }
    return null;
  }
}

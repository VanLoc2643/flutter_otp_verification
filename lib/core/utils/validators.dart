import 'package:email_validator/email_validator.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email không được để trống";
    }
    if (!EmailValidator.validate(value.trim())) {
      return "Email không hợp lệ (ví dụ: user@gmail.com)";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Mật khẩu không được để trống";
    }
    if (value.length < 6) {
      return "Mật khẩu tối thiểu 6 ký tự";
    }
    return null;
  }
}

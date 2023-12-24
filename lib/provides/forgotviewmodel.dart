import 'package:app_sv/repositories/forgot_password_repository.dart';
import 'package:flutter/material.dart';

class ForgotViewModel with ChangeNotifier {
  int status = 0;
  String errorMessage = "";
  final forgotRepo = ForgotRepository();
  Future<void> forgotPassword(String email) async {
    status = 1;
    notifyListeners();
    errorMessage = "";
    if (email.isEmpty) {
      status = 2;
      errorMessage += "Vui lòng nhập email khôi phục!\n";
    }
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (email.isEmpty == false && emailValid == false) {
      status = 2;
      errorMessage += "Email không hợp lệ!\n";
    }
    if (status != 2) {
      if (await forgotRepo.forgotPassword(email) == true) {
        status = 3;
      } else {
        status = 2;
        errorMessage += "Gửi yêu cầu không thành công, kiểm tra lại email!";
      }
    }
    notifyListeners();
  }
}

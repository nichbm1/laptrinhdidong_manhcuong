import 'package:app_sv/repositories/register_repository.dart';
import 'package:flutter/material.dart';

class RegisterViewModel with ChangeNotifier {
  int status = 0;
  String errorMessage = "";
  bool agree = false;
  final registerRepo = RegisterRepository();
  String terms =
      "Bạn cần đồng ý các điều khoản sau để tiến hành tạo tài khoản sau:\n1. Bạn phải đủ 18 tuổi.\n2. Thông tin cá nhân của bạn sẽ được chia sẻ với mọi người.\n3. Các thông tin cung cấp phải chính xác tránh xảy ra lỗi gây thiệt hại.\n";
  void setAgree(bool value) {
    agree = value;
    notifyListeners();
  }

  Future<void> register(
      String username, String email, String pass1, String pass2) async {
    status = 1;
    notifyListeners();
    errorMessage = "";
    if (agree == false) {
      status = 2;
      errorMessage += "Bắt buộc phải đồng ý điều khoản để đăng kí!\n";
    }
    if (username.isEmpty || email.isEmpty || pass1.isEmpty) {
      status = 2;
      errorMessage += "Bạn phải điền đẩy đủ các thông tin!\n";
    }
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (email.isEmpty == false && emailValid == false) {
      status = 2;
      errorMessage += "Email không hợp lệ!\n";
    }
    if (pass1.length < 8) {
      status = 2;
      errorMessage += "Mật khẩu không hợp lệ!\n";
    }
    if (pass1 != pass2) {
      status = 2;
      errorMessage += "Mật khẩu không trùng khớp!\n";
    }
    if (status != 2) {
      status = await registerRepo.register(username, email, pass1);
    }
    notifyListeners();
  }
}

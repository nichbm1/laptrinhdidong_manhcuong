import 'package:app_sv/model/student.dart';
import 'package:app_sv/model/user.dart';
import 'package:app_sv/repositories/login_repository.dart';
import 'package:app_sv/repositories/student_repository.dart';
import 'package:app_sv/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  String errorMessage = "";
  int status = 0;
  LoginRepository loginRepo = LoginRepository();
  Future<void> login(String username, String password) async {
    status = 1;
    notifyListeners();
    try {
      var profile = await loginRepo.login(username, password);
      if (profile.token == "") {
        status = 2;
        errorMessage = "Thông tin đăng nhập không đúng! Xin thử lại!";
      } else {
        var student = await StudentRepository().getStudentInfo();
        profile.student = Student.fromStudent(student);
        var user = await UserRepository().getUserInfo();
        profile.user = User.fromUser(user);
        // print(profile.user.id);
        status = 3; // Login succesful
      }
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}

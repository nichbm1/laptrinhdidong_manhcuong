import 'package:app_sv/model/profile.dart';
import 'package:app_sv/model/student.dart';
import 'package:app_sv/model/user.dart';
import 'package:flutter/foundation.dart';

class MainViewModel with ChangeNotifier {
  static final MainViewModel _instance = MainViewModel._internal();
  // ignore: unused_element
  MainViewModel._internal();
  factory MainViewModel() {
    return _instance;
  }
  int menuStatus = 0;
  int activeMenu = 0;
  void toggleMenu() {
    if (menuStatus == 0) {
      menuStatus = 1;
    } else {
      menuStatus = 0;
    }
    notifyListeners();
  }

  void setActive(int index) {
    activeMenu = index;
    menuStatus = 0;
    notifyListeners();
  }

  void closeMenu() {
    menuStatus = 0;
    notifyListeners();
  }

  void logout() {
    Profile profile = Profile();
    profile.token = "";
    profile.clearUsernamePassword();
    profile.user = User.clearInfo();
    profile.student = Student.clearInfo();
    notifyListeners();
  }
}

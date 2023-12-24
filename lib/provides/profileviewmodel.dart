import 'package:app_sv/model/profile.dart';
import 'package:app_sv/model/user.dart';
import 'package:app_sv/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel with ChangeNotifier {
  int status = 0;
  int isChange = 0;
  int updateAvatar = 0;
  void updateScreen() {
    notifyListeners();
  }

  void startLoading() {
    status = 1;
    notifyListeners();
  }

  void stopLoading() {
    status = 0;
    notifyListeners();
  }

  void setChange() {
    if (isChange == 0) {
      isChange = 1;
      notifyListeners();
    }
  }

  Future<void> updateProfile() async {
    status = 1;
    notifyListeners();
    await UserRepository().updateProfile();
    status = 0;
    isChange = 0;
    notifyListeners();
  }

  void upAvatar() {
    updateAvatar = 1;
    notifyListeners();
  }

  Future<void> saveAvatar(XFile image) async {
    status = 1;
    notifyListeners();
    await UserRepository().updateNewAvatar(image);
    var user = await UserRepository().getUserInfo();
    Profile().user = User.fromUser(user);
    updateAvatar = 0;
    status = 0;
    notifyListeners();
  }
}
